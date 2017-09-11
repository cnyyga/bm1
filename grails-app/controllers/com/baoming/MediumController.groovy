package com.baoming

import com.baoming.account.Role
import com.baoming.account.Student
import com.baoming.account.Teacher
import com.baoming.account.User
import com.bm.utils.MyNetUtils
import grails.converters.JSON
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.FileUtils
import org.apache.commons.io.IOUtils
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.dao.DataIntegrityViolationException

class MediumController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def planService
    def provinceService
    def springSecurityService

    def index() {

        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def total
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        params.sort = params.sort?:'id'
        params.order = params.order?:'desc'

        if (!year) {
          /*  cal.set(Calendar.DAY_OF_YEAR, 1)
            cal.set(Calendar.MONTH, 0)
            startDate = cal.time
            cal.add(Calendar.YEAR, 1)
            endDate = cal.time*/
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

        list = Medium.createCriteria().list(params) {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                or{
                    like('name', "%${name}%")
                    eq("number",name)
                }
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }
        total = Medium.createCriteria().count {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                or{
                    like('name', "%${name}%")
                    eq("number",name)
                }
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }
        def view = "list"
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = "/mobile/mediumList"
        }
        render(view: view,model: [mediumInstanceList: list, mediumInstanceTotal: total])

    }

    def create() {
        [mediumInstance: new Medium(params),provinces:provinceService.getProvinces(),mediumPlans:planService.getMediumPlans()]
    }

    def save() {
        def mediumInstance = new Medium(params)

        def teacher
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId as Long)
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }

            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT.name()){
                mediumInstance.reviewDate = new Date()
                mediumInstance.reviewPerson = User.get(userId as Long)
            }
        }
        mediumInstance.teacher = teacher

        mediumInstance.province = Province.findByCode(params.provinceId)
        mediumInstance.city = City.findByCode(params.cityId)
        mediumInstance.district = District.findByCode(params.districtId)

        mediumInstance.studentProvince = Province.findByCode(params.studentProvinceId)
        mediumInstance.studentCity = City.findByCode(params.studentCityId)
        mediumInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def file = request.getFile("voucherPathInp")
        if(file &&  !file.empty) {
            def cal = Calendar.instance
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "voucher_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            mediumInstance.voucherPath = storeName1
        }
        def file1 = request.getFile("cardNoPathInp")
        if(file1 &&  !file1.empty) {
            def cal = Calendar.instance
            def fileName1 = file1.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "medium_card_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file1.transferTo(f1)
            mediumInstance.cardNoPath = storeName1
        }
        def file2 = request.getFile("admissionPathInp")
        if(file2 &&  !file2.empty) {
            def cal = Calendar.instance
            def fileName1 = file2.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "medium_admission_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file2.transferTo(f1)
            mediumInstance.admissionPath = storeName1
        }
        def file3 = request.getFile("agreementPathInp")
        if(file3 &&  !file3.empty) {
            def cal = Calendar.instance
            def fileName1 = file3.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "medium_agreement_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file3.transferTo(f1)
            mediumInstance.agreementPath = storeName1
        }

        if (!mediumInstance.save(flush: true)) {
            def view = "create"
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                view = "/mobile/addMedium"
            }
            render(view: view, model: [mediumInstance: mediumInstance,provinces:provinceService.getProvinces()])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'medium.label', default: 'Medium'), mediumInstance.id])
        redirect(action: "show", id: mediumInstance.id)
    }

    def show(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }
        def view = "show"
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = "/mobile/mediumShow"
        }
        render(view: view,model: [mediumInstance: mediumInstance])
    }

    def edit(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        [mediumInstance: mediumInstance,provinces:provinceService.getProvinces(),mediumPlans:planService.getMediumPlans()]
    }

    def update(Long id, Long version) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (mediumInstance.version > version) {
                mediumInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'medium.label', default: 'Medium')] as Object[],
                        "Another user has updated this Medium while you were editing")
                render(view: "edit", model: [mediumInstance: mediumInstance,provinces:provinceService.getProvinces()])
                return
            }
        }

        mediumInstance.properties = params

        def teacher
        def userId = springSecurityService.authentication.principal?.id
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId as Long)
        }else{
            if(params.teacherId){
                teacher = Teacher.get(params.long('teacherId'))
            }

            if(params.reviewStatus != Student.ReviewStatus.NO_AUDIT.name()){
                mediumInstance.reviewDate = new Date()
                mediumInstance.reviewPerson = User.get(userId as Long)
            }
        }
        mediumInstance.teacher = teacher

        mediumInstance.province = Province.findByCode(params.provinceId)
        mediumInstance.city = City.findByCode(params.cityId)
        mediumInstance.district = District.findByCode(params.districtId)

        mediumInstance.studentProvince = Province.findByCode(params.studentProvinceId)
        mediumInstance.studentCity = City.findByCode(params.studentCityId)
        mediumInstance.studentDistrict = District.findByCode(params.studentDistrictId)

        def file = request.getFile("voucherPathInp")
        if(file &&  !file.empty) {
            def cal = Calendar.instance
            def fileName1 = file.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${cal.timeInMillis}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file.transferTo(f1)
            mediumInstance.voucherPath = storeName1
        }

        if (!mediumInstance.save(flush: true)) {
            render(view: "edit", model: [mediumInstance: mediumInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'medium.label', default: 'Medium'), mediumInstance.id])
        redirect(action: "show", id: mediumInstance.id)
    }

    def delete(Long id) {
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
            return
        }

        try {
            mediumInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'medium.label', default: 'Medium'), id])
            redirect(action: "show", id: id)
        }
    }

    def exp() {
        def userId = springSecurityService.authentication.principal?.id
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
        println(startDate?.format('yyyy-MM-dd HH:mm:ss'))
        println(endDate?.format('yyyy-MM-dd HH:mm:ss'))

        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
        } else {
            teacher = Teacher.get(params.long('teacherId'))
        }
        def list = Medium.createCriteria().list {
            if (teacher){
                eq('teacher', teacher)
            }
            ge('dateCreated', startDate)
            lt('dateCreated', endDate)
        }

        def titles = [message(code: 'medium.name.label'),message(code: 'medium.code.label'),message(code: 'medium.number.label'),
                      message(code: 'medium.gender.label'),message(code: 'mediumPlan.label'),message(code: 'medium.plan.label'),
                      message(code: 'medium.district.label'),message(code: 'medium.studentDistrict.label'),message(code: 'medium.teacher.label'),
                      message(code: 'default.dateCreated.label')];
        def outputStream
        try {
            outputStream = response.outputStream;
            response.setContentType("APPLICATION/OCTET-STREAM");
            response.setHeader("Content-Disposition", "attachment; filename=\""+new String("${message(code: 'medium.label')}.xls".getBytes('gbk'),"ISO8859_1")+"\"");
            new ExcelBuilder().workbook(outputStream) {
                sheet {
                    titles.eachWithIndex {e,i->
                        cell(i,0,e).bold()
                    }
                    list.eachWithIndex { de, k ->
                        def kk = k+1
                        def district = de.province?.name?:''
                        district += de.city?.name?:''
                        district += de.district?.name?:''

                        def studentDistrict = de.studentProvince?.name?:''
                        studentDistrict += de.studentCity?.name?:''
                        studentDistrict += de.studentDistrict?.name?:''


                        cell(0,kk,de.name?:'')
                        cell(1,kk,de.code?:'')
                        cell(2,kk,de.number?:'')
                        cell(3,kk,de.gender?.label?:'')
                        cell(4,kk,de.mediumPlan?.name?:'')
                        try {
                            cell(5,kk,de.plan?.name?:'')
                        } catch (e) {
                            cell(5,kk,'')
                        }
                        cell(6,kk,district?:'')
                        cell(7,kk,studentDistrict?:'')
                        def teacherNmae=""
                        try {
                            teacherNmae = de.teacher?.name
                        } catch (e) {
                        }
                        cell(8,kk,teacherNmae)
                        cell(9,kk,de.lastUpdated.format('yyyy-MM-dd HH:mm:ss'))
                    }
                }
            }
            //
        } catch (Exception e) {
            flash.message = message(code: 'download.null.message')
            log.error("medium exprot errors:${e.message}",e)
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
        def mediumInstance = Medium.get(id)
        if (!mediumInstance) {
            render(([status:'0'] as JSON) as String)
            return
        }
        if (params.reviewStatus == Student.ReviewStatus.NO_AUDIT.name()) {
            render(([status: '1'] as JSON) as String)
            return
        }
        def userId = springSecurityService.authentication.principal?.id
        mediumInstance.reviewDate = new Date()
        mediumInstance.reviewPerson = User.get(userId as Long)
        mediumInstance.reviewStatus = Student.ReviewStatus."${params.reviewStatus}"

        if (!mediumInstance.save()) {
            render(([status: '0'] as JSON) as String)
            return
        }
        render(([status: '1', reviewStatusId:mediumInstance.reviewStatus?.id,reviewStatusLab:mediumInstance.reviewStatus?.label] as JSON) as String)
    }
}
