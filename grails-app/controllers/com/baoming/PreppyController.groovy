package com.baoming

import com.baoming.account.Role
import com.baoming.account.Teacher
import com.baoming.account.User
import grails.converters.JSON
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.transaction.annotation.Transactional

class PreppyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
    def springSecurityService
    def planService
    def provinceService
    def preppyService
    def fileService
    def userService

    def index() {

        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def total
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        params.max = Math.min(max ?: 10, 100)
        params.sort = "id";
        params.order = "desc"

        if (!year) {
            cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time
        } else {
            cal.time = year
            cal.add(Calendar.YEAR, 1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }

        def plan
        if(params.planId) {
            plan = Plan.get(params.planId as long)
        }

        list = Preppy.createCriteria().list(params) {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            if(plan){
                eq('plan',plan)
            }
            if(params.reviewStatus) {
                eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }
        total = Preppy.createCriteria().count {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            if(plan){
                eq('plan',plan)
            }
            if(params.reviewStatus) {
                eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }

        [preppyInstanceList: list, preppyInstanceTotal: total]
    }

    def create() {
        [preppyInstance: new Preppy(params),provinces:provinceService.getProvinces(),
                preppyPlans:planService.getPreppyPlans()]
    }

    @Transactional
    def save() {
        def preppyInstance = new Preppy(params)
        def userId = springSecurityService.authentication.principal?.id
        def teacher = null
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }
            if(params.reviewStatus != Preppy.ReviewStatus.NO_AUDIT.name()){
                preppyInstance.reviewDate = new Date()
                preppyInstance.reviewPerson = User.get(userId as Long)
            }
        }

        preppyInstance.teacher = teacher

        def province = Province.findByCode(params.provinceId)
        if(province && province.name.count('江苏') > 0) {
            preppyInstance.family = Preppy.Family.JIANGSU
        }else{
            preppyInstance.family = Preppy.Family.OTHER
        }
        preppyInstance.province = province
        preppyInstance.city = City.findByCode(params.cityId)
        preppyInstance.district = District.findByCode(params.districtId)

        def studentProvince = Province.findByCode(params.studentProvinceId)
        if(studentProvince && studentProvince.name.count('江苏') > 0) {
            preppyInstance.studentFamily = Preppy.Family.JIANGSU
        } else{
            preppyInstance.studentFamily = Preppy.Family.OTHER
        }
        preppyInstance.studentProvince = studentProvince
        preppyInstance.studentCity = City.findByCode(params.studentCityId)
        preppyInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def academicScores = params.list('academicScore')
        academicScores = academicScores.join(",")
        preppyInstance.academicScore = academicScores
        preppyInstance.protocolCode = preppyService.buildProtocolCode()

        def hkbPathFile = request.getFile("hkbPathInp")
        def hkbksyPathFile = request.getFile("hkbksyPathInp")
        def cardPhotoPathFile = request.getFile("cardPhotoPathInp")
        def byzsPathFile = request.getFile("byzsPathInp")
        def xjzmPathFile = request.getFile("xjzmPathInp")

        def hkbPath =fileService.upload(hkbPathFile,"preppy")
        def hkbksyPath =fileService.upload(hkbksyPathFile,"preppy")
        def cardPhotoPath =fileService.upload(cardPhotoPathFile,"preppy")
        def byzsPath =fileService.upload(byzsPathFile,"preppy")
        def xjzmPath =fileService.upload(xjzmPathFile,"preppy")
        if(hkbPath){
            preppyInstance.hkbPath=hkbPath
        }
        if(hkbksyPath){
            preppyInstance.hkbksyPath=hkbksyPath
        }
        if(cardPhotoPath){
            preppyInstance.cardPhotoPath=cardPhotoPath
        }
        if(byzsPath){
            preppyInstance.byzsPath=byzsPath
        }
        if(xjzmPath){
            preppyInstance.xjzmPath=xjzmPath
        }

        if (!preppyInstance.save(flush: true)) {
            render(view: "create", model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
            return
        }

        def user = new User();
        user.username = preppyInstance.number
        user.password = params.password
        user.enabled=true
        userService.saveUser(user,Role.AUTHORITY_STUDENT)

        flash.message = message(code: 'default.created.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def show(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }


        [preppyInstance: preppyInstance]
    }

    def edit(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()]
    }

    def update(Long id, Long version) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (preppyInstance.version > version) {
                preppyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'preppy.label', default: 'Preppy')] as Object[],
                        "Another user has updated this Preppy while you were editing")
                render(view: "edit", model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
                return
            }
        }

        preppyInstance.properties = params
        def userId = springSecurityService.authentication.principal?.id
        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
            preppyInstance.teacher = teacher
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }
            if(params.reviewStatus != Preppy.ReviewStatus.NO_AUDIT.name()){
                preppyInstance.reviewDate = new Date()
                preppyInstance.reviewPerson = User.get(userId as Long)
            }
        }
        preppyInstance.teacher = teacher

        def province = Province.findByCode(params.provinceId)
        if(province && province.name.count('江苏') > 0) {
            preppyInstance.family = Preppy.Family.JIANGSU
        }    else{
            preppyInstance.family = Preppy.Family.OTHER
        }
        preppyInstance.province = province
        preppyInstance.city = City.findByCode(params.cityId)
        preppyInstance.district = District.findByCode(params.districtId)

        def studentProvince = Province.findByCode(params.studentProvinceId)
        if(studentProvince && studentProvince.name.count('江苏') > 0) {
            preppyInstance.studentFamily = Preppy.Family.JIANGSU
        }else{
            preppyInstance.studentFamily = Preppy.Family.OTHER
        }
        preppyInstance.studentProvince = studentProvince
        preppyInstance.studentCity = City.findByCode(params.studentCityId)
        preppyInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def academicScores = params.list('academicScore')
        academicScores = academicScores.join(",")
        preppyInstance.academicScore = academicScores

        def hkbPathFile = request.getFile("hkbPathInp")
        def hkbksyPathFile = request.getFile("hkbksyPathInp")
        def cardPhotoPathFile = request.getFile("cardPhotoPathInp")
        def byzsPathFile = request.getFile("byzsPathInp")
        def xjzmPathFile = request.getFile("xjzmPathInp")

        def hkbPath =fileService.upload(hkbPathFile,"preppy")
        def hkbksyPath =fileService.upload(hkbksyPathFile,"preppy")
        def cardPhotoPath =fileService.upload(cardPhotoPathFile,"preppy")
        def byzsPath =fileService.upload(byzsPathFile,"preppy")
        def xjzmPath =fileService.upload(xjzmPathFile,"preppy")
        if(hkbPath){
            preppyInstance.hkbPath=hkbPath
        }
        if(hkbksyPath){
            preppyInstance.hkbksyPath=hkbksyPath
        }
        if(cardPhotoPath){
            preppyInstance.cardPhotoPath=cardPhotoPath
        }
        if(byzsPath){
            preppyInstance.byzsPath=byzsPath
        }
        if(xjzmPath){
            preppyInstance.xjzmPath=xjzmPath
        }

        if (!preppyInstance.save(flush: true)) {
            render(view: "edit", model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'preppy.label', default: 'Preppy'), preppyInstance.id])
        redirect(action: "show", id: preppyInstance.id)
    }

    def delete(Long id) {
        def preppyInstance
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            def userId = springSecurityService.authentication.principal?.id
            def teacher = Teacher.get(userId)
            preppyInstance = Preppy.findByIdAndTeacher(id, teacher)
        } else {
            preppyInstance = Preppy.get(id)
        }
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 0] as JSON) as String)
            return
        }

        try {
            preppyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 1] as JSON) as String)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            if (params.act) {
                redirect(action: 'list')
                return
            }
            render(([status: 0] as JSON) as String)
        }
    }

    def xy(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
        def birthday = preppyInstance.birthday
        cal.time = birthday
        [preppyInstance: preppyInstance,year:year,age:(year - cal.get(Calendar.YEAR))]
    }

    def xyPrint(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
        def birthday = preppyInstance.birthday
        cal.time = birthday
        [preppyInstance: preppyInstance,year:year,age:(year - cal.get(Calendar.YEAR))]
    }

    def exp(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        if (!year) {
            cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time
        } else {
            cal.time = year
            cal.add(Calendar.YEAR, 1)
            startDate = year
            endDate = cal.time
        }

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }

        list = Preppy.createCriteria().list {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                like('name', "%${name}%")
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)

        }
        def titles = [message(code: 'preppy.name.label'),message(code: 'preppy.gender.label'),message(code: 'preppy.number.label'),
                      message(code: 'preppy.birthday.label'),message(code: 'medium.district.label'),message(code: 'preppy.studentDistrict.label'),
                      message(code: 'preppy.school.label'),message(code: 'preppy.type.label'),message(code: 'preppy.schoolType.label'),
                      message(code: 'preppy.academicYear.label'),message(code: 'preppy.academicScore.label'),message(code: 'preppy.skill.label'),
                      message(code: 'preppy.middlePlan.label'),message(code: 'preppyPlan.label'),message(code: 'preppy.plan.label'),
                message(code: 'preppy.deposit.label'),message(code: 'preppy.phone.label'),message(code: 'preppy.parentPhone.label'),
                message(code: 'preppy.address.label'),message(code: 'preppy.studentCateories.label'),message(code: 'preppy.reviewStatus.label'),
                      message(code: 'preppy.teacher.label'),message(code: 'preppy.remark.label'),message(code: 'default.lastUpdated.label')]
        def outputStream
        try {

            outputStream = response.outputStream
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'preppy.label')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold()
                    }
                    list.eachWithIndex {de,k->
                        def kk = k+1
                        def district = ''
                        def studentDistrict = ''
                        try {
                            district = de.province?.name?:''
                            district += de.city?.name?:''
                            district += de.district?.name?:''
                        } catch (e) {
                            log.error(e.message)
                        }
                        try {
                            studentDistrict = de.studentProvince?.name?:''
                            studentDistrict += de.studentCity?.name?:''
                            studentDistrict += de.studentDistrict?.name?:''
                        } catch (e) {
                            log.error(e.message)
                        }

                        def academicScore = de.academicScore
                        if(academicScore) {
                            def acss = academicScore.tokenize(",")
                            academicScore = "物理${acss[0]} 化学${acss[1]} 生物${acss[2]} 地理${acss[3]} 历史${acss[4]} 政治${acss[5]}"
                        }

                        cell(0,kk,de.name?:'')
                        cell(1,kk,de.gender?.label?:'')
                        cell(2,kk,de.number?:'')
                        cell(3,kk,de.birthday?de.birthday.format('yyyy-MM-dd'):'')
                        cell(4,kk,district?:'')
                        cell(5,kk,studentDistrict?:'')
                        cell(6,kk,de.school?:'')
                        cell(7,kk,de.type?.label?:'')
                        if(de.studentCateories?.name() == Preppy.StudentCateories.SG.name()){
                            cell(8,kk,'')
                            cell(9,kk,de.academicYear?:'未参加')
                            cell(10,kk,academicScore?:'')
                            cell(11,kk,de.skill?.label?:'')
                        }else{
                            cell(8,kk,de.schoolType?.label?:'')
                            cell(9,kk,'')
                            cell(10,kk,'')
                            cell(11,kk,'')
                        }

                        if(de.studentCateories?.name() == Preppy.StudentCateories.WG.name()){
                            cell(12,kk,de.middlePlan?:'')
                        }else{
                            cell(12,kk,'')
                        }

                        try {
                            cell(13,kk,de.preppyPlan?.name?:'')
                        } catch (ee) {
                            cell(13,kk,'')
                        }
                        cell(14,kk,de.plan?.name?:'')
                        cell(15,kk,de.deposit?:'')
                        cell(16,kk,de.phone?:'')
                        cell(17,kk,de.parentPhone?:'')
                        cell(18,kk,de.address?:'')
                        cell(19,kk,de.studentCateories?.label?:'')
                        cell(20,kk,de.reviewStatus?.label?:'')
                        try {
                            cell(21,kk,de.teacher?.name?:'')
                        } catch (Exception e) {
                            cell(21,kk,'')
                        }
                        cell(22,kk,de.remark?:'')
                        cell(23,kk,de.lastUpdated.format('yyyy-MM-dd HH:mm:ss'))
                    }
                }
            }
            //
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("Preppy exprot errors:${e.message}",e)
        } finally {
            IOUtils.closeQuietly(outputStream)
        }
        return
    }

    def ajaxAudit(Long id) {
        if(!id) {
            render(([status:'0'] as JSON) as String)
            return
        }
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            render(([status:'0'] as JSON) as String)
            return
        }
        if (!params.reviewStatus || params.reviewStatus == Preppy.ReviewStatus.NO_AUDIT.name()) {
            render(([status: '1'] as JSON) as String)
            return
        }
        def userId = springSecurityService.authentication.principal?.id
        preppyInstance.reviewDate = new Date()
        preppyInstance.reviewPerson = User.get(userId as Long)
        preppyInstance.reviewStatus = Preppy.ReviewStatus."${params.reviewStatus}"

        if (!preppyInstance.save()) {
            log.error(preppyInstance.errors)
            render(([status: '0'] as JSON) as String)
            return
        }
        render(([status: '1', reviewStatusId:preppyInstance.reviewStatus?.id,reviewStatusLab:preppyInstance.reviewStatus?.label] as JSON) as String)
    }
}
