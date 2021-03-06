package com.baoming

import com.baoming.account.Role
import com.baoming.account.Teacher
import com.baoming.account.User
import com.bm.utils.MyNetUtils
import grails.converters.JSON
import grails.plugin.jxl.builder.ExcelBuilder
import org.apache.commons.io.IOUtils
import org.apache.commons.lang.RandomStringUtils
import org.apache.commons.lang.math.RandomUtils
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
        params.sort = "id"
        params.order = "desc"

        if (!year && !name) {
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
                or{
                    like('name', "%${name}%")
                    eq("number",name)
                }
            }
            if(plan){
                eq('plan',plan)
            }
            if(params.reviewStatus) {
                if(params.reviewStatus == 'NO_AUDIT'){
                    or {
                        isNull('reviewStatus')
                        eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
                    }
                }else{
                    eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
                }
            }
            if(startDate){
                ge('dateCreated', startDate)
            }
            if(endDate){
                lt('dateCreated', endDate)
            }
        }
        total = Preppy.createCriteria().count {
            if (teacher)
                eq('teacher', teacher)
            if (name) {
                or{
                    like('name', "%${name}%")
                    eq("number",name)
                }
            }
            if(plan){
                eq('plan',plan)
            }
            if(params.reviewStatus) {
                if(params.reviewStatus == 'NO_AUDIT'){
                    or {
                        isNull('reviewStatus')
                        eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
                    }
                }else{
                    eq('reviewStatus',Preppy.ReviewStatus."${params.reviewStatus}")
                }
            }
            if(startDate){
                ge('dateCreated', startDate)
            }
            if(endDate){
                lt('dateCreated', endDate)
            }
        }
        def view = "list"
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = "/mobile/preppyList"
        }
        render(view: view,model: [preppyInstanceList: list, preppyInstanceTotal: total,preppyPlans:planService.getPreppyPlans()])
    }

    def create() {
        [preppyInstance: new Preppy(params),provinces:provinceService.getProvinces(),
                preppyPlans:planService.getPreppyPlans(),plans:planService.getPreppyPlanPlans()]
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

        def province = params.provinceId?Province.findByCode(params.provinceId):null
      //  if(province && province.name.count('江苏') > 0) {
        //    preppyInstance.family = Preppy.Family.JIANGSU
       // }else  if(province && !province.name.count('江苏') > 0){
        //    preppyInstance.family = Preppy.Family.OTHER
      //  }
        if(province){
            preppyInstance.province = province
        }
        if(params.cityId){
            preppyInstance.city = City.findByCode(params.cityId)
        }
        if(params.districtId){
            preppyInstance.district = District.findByCode(params.districtId)
        }

        def studentProvince = params.studentProvinceId?Province.findByCode(params.studentProvinceId):null
        if(studentProvince && studentProvince.name.count('江苏') > 0) {
            preppyInstance.studentFamily = Preppy.Family.JIANGSU
        } else{
            preppyInstance.studentFamily = Preppy.Family.OTHER
        }
        if(studentProvince){
            preppyInstance.studentProvince = studentProvince
        }
        if(params.studentCityId){
            preppyInstance.studentCity = City.findByCode(params.studentCityId)
        }
        if(params.studentDistrictId){
            preppyInstance.studentDistrict = District.findByCode(params.studentDistrictId)
        }

        if(params.receiverProvinceId){
            preppyInstance.receiverProvince= Province.findByCode(params.receiverProvinceId)
        }
        if(params.receiverCityId){
            preppyInstance.receiverCity = City.findByCode(params.receiverCityId)
        }
        if(params.receiverDistrictId){
            preppyInstance.receiverDistrict = District.findByCode(params.receiverDistrictId)
        }

        def academicScores = params.list('academicScore')
        if(academicScores){
            academicScores = academicScores.join(",")
            preppyInstance.academicScore = academicScores
        }
        preppyInstance.protocolCode = preppyService.buildProtocolCode()

        def hkbPathFile = request.getFile("hkbPathInp")
        def hkbksyPathFile = request.getFile("hkbksyPathInp")
        def cardPhotoPathFile = request.getFile("cardPhotoPathInp")
        def cardBackgroundPhotoPathFile = request.getFile("cardBackgroundPhotoPathInp")
        def byzsPathFile = request.getFile("byzsPathInp")
        def xjzmPathFile = request.getFile("xjzmPathInp")
        def otherPhotoPathFile = request.getFile("otherPhotoPathInp")
        def payPhotoFile = request.getFile("payPhotoPathInp")

        def hkbPath =hkbPathFile?fileService.upload(hkbPathFile,"preppy"):null
        def hkbksyPath =hkbksyPathFile?fileService.upload(hkbksyPathFile,"preppy"):null
        def cardPhotoPath =cardPhotoPathFile?fileService.upload(cardPhotoPathFile,"preppy"):null
        def cardBackgroundPhotoPath =cardBackgroundPhotoPathFile?fileService.upload(cardBackgroundPhotoPathFile,"preppy"):null
        def byzsPath =byzsPathFile?fileService.upload(byzsPathFile,"preppy"):null
        def xjzmPath =xjzmPathFile?fileService.upload(xjzmPathFile,"preppy"):null
        def otherPhotoPath =otherPhotoPathFile?fileService.upload(otherPhotoPathFile,"preppy"):null
        def payPhotoPath =payPhotoFile?fileService.upload(payPhotoFile,"preppy"):null
        if(hkbPath){
            preppyInstance.hkbPath=hkbPath
        }
        if(hkbksyPath){
            preppyInstance.hkbksyPath=hkbksyPath
        }
        if(cardPhotoPath){
            preppyInstance.cardPhotoPath=cardPhotoPath
        }
        if(cardBackgroundPhotoPath){
            preppyInstance.cardBackgroundPhotoPath=cardBackgroundPhotoPath
        }
        if(byzsPath){
            preppyInstance.byzsPath=byzsPath
        }
        if(xjzmPath){
            preppyInstance.xjzmPath=xjzmPath
        }
        if(otherPhotoPath){
            preppyInstance.otherPhotoPath=otherPhotoPath
        }
        if(payPhotoPath){
            preppyInstance.payPhoto=payPhotoPath
        }
        def c  = Preppy.countByNumber(preppyInstance.number)
        if(c > 0){
            flash.message = '身份证号已经存在'
            def view = "create"
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                view = "/mobile/addPreppy"
            }
            render(view: view, model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
            return
        }
        if (SpringSecurityUtils.ifNotGranted(Role.AUTHORITY_TEACHER)) {
            def juniorStart_year = params.get("juniorStart_year")
        def juniorStart_month = params.get("juniorStart_month")
        def juniorEnd_year = params.get("juniorEnd_year")
        def juniorEnd_month = params.get("juniorEnd_month")
        def juniorSchool = params.get("juniorSchool")
        def juniorAuthenticator = params.get("juniorAuthenticator")
        def highStart_year = params.get("highStart_year")
        def highStart_month = params.get("highStart_month")
        def highEnd_year = params.get("highEnd_year")
        def highEnd_month = params.get("highEnd_month")
        def highSchool = params.get("highSchool")
        def highAuthenticator = params.get("highAuthenticator")
        def zzzy = params.get("zzzy")
        def cal = Calendar.instance
        cal.clearTime()
        def resume = preppyInstance.resume?:new Resume()
        if(juniorStart_year&&juniorStart_month){
            cal.set(Calendar.YEAR,juniorStart_year as int)
            cal.set(Calendar.MONTH,(juniorStart_month as int)-1)
            resume.juniorStart = cal.time
        }
        if(juniorEnd_year&&juniorEnd_month){
            cal.set(Calendar.YEAR,juniorEnd_year as int)
            cal.set(Calendar.MONTH,(juniorEnd_month as int)-1)
            resume.juniorEnd=cal.time
        }
        if(juniorSchool){
            resume.juniorSchool=juniorSchool
        }
        if(juniorAuthenticator){
            resume.juniorAuthenticator=juniorAuthenticator
        }
        if(highStart_year&&highStart_month){
            cal.set(Calendar.YEAR,highStart_year as int)
            cal.set(Calendar.MONTH,(highStart_month as int)-1)
            resume.highStart = cal.time
        }
        if(highEnd_year&&highEnd_month){
            cal.set(Calendar.YEAR,highEnd_year as int)
            cal.set(Calendar.MONTH,(highEnd_month as int)-1)
            resume.highEnd=cal.time
        }
        if(highSchool){
            resume.highSchool=highSchool
        }
        if(zzzy){
            resume.zzzy=zzzy
        }
        if(highAuthenticator){
            resume.highAuthenticator=highAuthenticator
        }
        preppyInstance.resume=resume
            if (params.reviewStatus && params.reviewStatus != Preppy.ReviewStatus.NO_AUDIT.name() && params.reviewStatus != Preppy.ReviewStatus.NO_PASS.name()) {
                def codes = preppyService.generateCode(preppyInstance)
                if (codes && !preppyInstance.code) {
                    preppyInstance.code = codes[0]
                }
                if (codes) {
                    preppyInstance.csCode = codes[1]
                }
            }
        }

        if(params.leiBie){
            preppyInstance.leiBie = Preppy.LeiBie."${params.leiBie}"
        }

        if(params.beforeFamily){
            preppyInstance.beforeFamily = params.boolean("beforeFamily");
        }
        preppyInstance.validate()
        if (!preppyInstance.save(flush: true)) {
            println(preppyInstance.errors)
            def view = "create"
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                view = "/mobile/addPreppy"
            }
            render(view: view, model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
            return
        }

        def user = new User();
        user.username = preppyInstance.number
        user.password = params.password?:"${user.username}"
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
        def view = "show"
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = "/mobile/preppyShow"
        }

        render(view: view,model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans(),plans:planService.getPreppyPlanPlans()])
    }

    def edit(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }

        [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans(),plans:planService.getPreppyPlanPlans()]
    }

    @Transactional
    def update(Long id) {

        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def oldReviewStatus = preppyInstance.reviewStatus

        preppyInstance.properties = params

        if(params.beforeFamily){
            preppyInstance.beforeFamily = params.boolean("beforeFamily");
        }

        def userId = springSecurityService.authentication.principal?.id
        def teacher
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            if(preppyInstance.reviewStatus && preppyInstance.reviewStatus != Preppy.ReviewStatus.NO_AUDIT && preppyInstance.reviewStatus != Preppy.ReviewStatus.GJSZZ ){
                flash.message = '已经审核无法修改资料'
                redirect(action: 'list')
                return
            }
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

        if(params.password){
            def user = User.findByUsername(preppyInstance.number)
            if(user){
                user.password = params.password
                user.save()
            }
        }

        def province = params.provinceId?Province.findByCode(params.provinceId):null
        if(params.family) {
            preppyInstance.family = Preppy.Family."${params.family}"
        }else{
            //preppyInstance.family = Preppy.Family.OTHER
        }
        if(params.cityId){
            preppyInstance.city = City.findByCode(params.cityId)
        }
        if(province){
            preppyInstance.province = province
        }
        if(params.districtId){
            preppyInstance.district = District.findByCode(params.districtId)
        }

        def studentProvince = params.studentProvinceId?Province.findByCode(params.studentProvinceId):null
        if(studentProvince && studentProvince.name.count('江苏') > 0) {
            preppyInstance.studentFamily = Preppy.Family.JIANGSU
        }else{
            preppyInstance.studentFamily = Preppy.Family.OTHER
        }
        if(studentProvince){
            preppyInstance.studentProvince = studentProvince
        }
        if(params.studentCityId){
            preppyInstance.studentCity = City.findByCode(params.studentCityId)
        }
        if(params.studentDistrictId){
            preppyInstance.studentDistrict = District.findByCode(params.studentDistrictId)
        }
        if(params.receiverProvinceId){
            preppyInstance.receiverProvince= Province.findByCode(params.receiverProvinceId)
        }
        if(params.receiverCityId){
            preppyInstance.receiverCity = City.findByCode(params.receiverCityId)
        }
        if(params.receiverDistrictId){
            preppyInstance.receiverDistrict = District.findByCode(params.receiverDistrictId)
        }
        def academicScores = params.list('academicScore')
        academicScores = academicScores.join(",")
        preppyInstance.academicScore = academicScores

        def hkbPathFile = request.getFile("hkbPathInp")
        def hkbksyPathFile = request.getFile("hkbksyPathInp")
        def cardPhotoPathFile = request.getFile("cardPhotoPathInp")
        def cardBackgroundPhotoPathFile = request.getFile("cardBackgroundPhotoPathInp")
        def byzsPathFile = request.getFile("byzsPathInp")
        def xjzmPathFile = request.getFile("xjzmPathInp")
        def otherPhotoPathFile = request.getFile("otherPhotoPathInp")
        def payPhotoFile = request.getFile("payPhotoPathInp")

        def hkbPath =hkbPathFile?fileService.upload(hkbPathFile,"preppy"):null
        def hkbksyPath =hkbksyPathFile?fileService.upload(hkbksyPathFile,"preppy"):null
        def cardPhotoPath =cardPhotoPathFile?fileService.upload(cardPhotoPathFile,"preppy"):null
        def cardBackgroundPhotoPath =cardBackgroundPhotoPathFile?fileService.upload(cardBackgroundPhotoPathFile,"preppy"):null
        def byzsPath =byzsPathFile?fileService.upload(byzsPathFile,"preppy"):null
        def xjzmPath =xjzmPathFile?fileService.upload(xjzmPathFile,"preppy"):null
        def otherPhotoPath =otherPhotoPathFile?fileService.upload(otherPhotoPathFile,"preppy"):null
        def payPhotoPath =payPhotoFile?fileService.upload(payPhotoFile,"preppy"):null

        if(hkbPath){
            preppyInstance.hkbPath=hkbPath
        }
        if(hkbksyPath){
            preppyInstance.hkbksyPath=hkbksyPath
        }
        if(cardPhotoPath){
            preppyInstance.cardPhotoPath=cardPhotoPath
        }
        if(cardBackgroundPhotoPath){
            preppyInstance.cardBackgroundPhotoPath=cardBackgroundPhotoPath
        }
        if(byzsPath){
            preppyInstance.byzsPath=byzsPath
        }
        if(xjzmPath){
            preppyInstance.xjzmPath=xjzmPath
        }
        if(otherPhotoPath){
            preppyInstance.otherPhotoPath=otherPhotoPath
        }
        if(payPhotoPath){
            preppyInstance.payPhoto=payPhotoPath
        }
        def juniorStart_year = params.get("juniorStart_year")
        def juniorStart_month = params.get("juniorStart_month")
        def juniorEnd_year = params.get("juniorEnd_year")
        def juniorEnd_month = params.get("juniorEnd_month")
        def juniorSchool = params.get("juniorSchool")
        def juniorAuthenticator = params.get("juniorAuthenticator")
        def highStart_year = params.get("highStart_year")
        def highStart_month = params.get("highStart_month")
        def highEnd_year = params.get("highEnd_year")
        def highEnd_month = params.get("highEnd_month")
        def highSchool = params.get("highSchool")
        def highAuthenticator = params.get("highAuthenticator")
        def zzzy = params.get("zzzy")
        def cal = Calendar.instance
        cal.clearTime()
        def resume = preppyInstance.resume?:new Resume()
        if(juniorStart_year&&juniorStart_month){
            cal.set(Calendar.YEAR,juniorStart_year as int)
            cal.set(Calendar.MONTH,(juniorStart_month as int)-1)
            resume.juniorStart = cal.time
        }
        if(juniorEnd_year&&juniorEnd_month){
            cal.set(Calendar.YEAR,juniorEnd_year as int)
            cal.set(Calendar.MONTH,(juniorEnd_month as int)-1)
            resume.juniorEnd=cal.time
        }
        if(juniorSchool){
            resume.juniorSchool=juniorSchool
        }
        if(juniorAuthenticator){
            resume.juniorAuthenticator=juniorAuthenticator
        }
        if(highStart_year&&highStart_month){
            cal.set(Calendar.YEAR,highStart_year as int)
            cal.set(Calendar.MONTH,(highStart_month as int)-1)
            resume.highStart = cal.time
        }
        if(highEnd_year&&highEnd_month){
            cal.set(Calendar.YEAR,highEnd_year as int)
            cal.set(Calendar.MONTH,(highEnd_month as int)-1)
            resume.highEnd=cal.time
        }
        if(highSchool){
            resume.highSchool=highSchool
        }
        if(zzzy){
            resume.zzzy=zzzy
        }
        if(highAuthenticator){
            resume.highAuthenticator=highAuthenticator
        }
        preppyInstance.resume=resume

        if (params.reviewStatus && params.reviewStatus != Preppy.ReviewStatus.NO_AUDIT.name() && params.reviewStatus != Preppy.ReviewStatus.NO_PASS.name()) {
            def codes = preppyService.generateCode(preppyInstance)
            if(codes && !preppyInstance.code){
                preppyInstance.code=codes[0]
            }
            if(codes){
                if(!preppyInstance.csCode){
                    preppyInstance.csCode=codes[1]
                }else if(!oldReviewStatus || oldReviewStatus.name()!=params.reviewStatus){
                    preppyInstance.csCode=codes[1]
                }
            }
        }

        if(params.leiBie){
            preppyInstance.leiBie = Preppy.LeiBie."${params.leiBie}"
        }

        if (!preppyInstance.save(flush: true)) {
            println(preppyInstance.errors)
            def view = "edit"
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                view = "/mobile/editPreppy"
            }
            render(view: view, model: [preppyInstance: preppyInstance,provinces:provinceService.getProvinces(),preppyPlans:planService.getPreppyPlans()])
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

    def xy1(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
        render(view: 'xyPrint2',model: [preppyInstance: preppyInstance,year:year])
    }

    def xyPrint1(Long id) {
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)

        render(view: 'xyPrint2',model: [preppyInstance: preppyInstance,year:year])
    }

    def exp(Integer max) {
        def userId = springSecurityService.authentication.principal?.id
        def name = params.name
        def list
        def year = params.date('year', 'yyyy')
        def cal = Calendar.instance
        def startDate
        def endDate
        if (!year&&!name) {
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
                or{
                    like('name', "%${name}%")
                    eq("number",name)
                }
            }
            if(startDate){
                ge('dateCreated', startDate)
            }
            if(endDate){
                lt('dateCreated', endDate)
            }

        }
        def titles = [message(code: 'preppy.code.label'),
                      message(code: 'preppy.csCode.label'),
                      message(code: 'preppy.name.label'),
                      message(code: 'preppy.number.label'),
                      message(code: 'preppy.phone.label'),
                      message(code: 'preppy.parentPhone.label'),
                      message(code: 'preppy.sendType.label'),
                      message(code: 'preppy.school.label'),
                      message(code: 'student.plans.label'),
                      message(code: 'preppy.receiverFamily.label'),
                      message(code: 'preppy.receiverAddress.label'),
                      message(code: 'preppy.receiver.label'),
                      message(code: 'preppy.receivePhone.label'),
                      message(code: 'preppy.cardPhotoPath.label'),
                      message(code: 'preppy.cardBackgroundPhotoPath.label'),
                      message(code: 'preppy.payPhoto.label'),
                      message(code: 'preppy.reviewStatus.label'),
                      message(code: 'preppy.exStatus.label'),
                      message(code: 'preppy.exDate.label'),
                      message(code: 'preppy.counselor.label'),
                      message(code: 'preppy.counselorPhone.label'),
                      message(code: 'preppy.remark.label'),
                      message(code: 'nation.label'),
                      message(code: 'preppy.birthday.label'),
                      message(code: 'politicalStatus.label'),
                      message(code: 'preppy.familyType.label'),
                      message(code: 'preppy.family.label'),
                      message(code: 'preppy.address.label'),
                      message(code: 'preppy.resume.juniorSchoolName.label'),
                      message(code: 'preppy.resume.juniorAuth.label'),
                      message(code: 'preppy.teacher.label'),
                      message(code: 'default.dateCreated.label'),
                      message(code: 'preppy.reviewDate.label')
                ]
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
                        try {
                            district = de.province?.name?:''
                            district += de.city?.name?:''
                            district += de.district?.name?:''
                            district += de.town?:''
                        } catch (e) {
                            log.error(e.message)
                        }

                        def receiverDistrict = ''
                        try {
                            receiverDistrict = de.receiverProvince?.name?:''
                            receiverDistrict += de.receiverCity?.name?:''
                            receiverDistrict += de.receiverDistrict?.name?:''
                            receiverDistrict += de.receiverTown?:''
                        } catch (e) {
                            log.error(e.message)
                        }

                        def juniorSchool = de?.resume?.juniorSchool
                        def juniorAuthenticator = de?.resume?.juniorAuthenticator

                        cell(0,kk,de.code?:'')
                        cell(1,kk,de.csCode?:'')
                        cell(2,kk,de.name?:'')
                        cell(3,kk,de.number?:'')
                        cell(4,kk,de.phone?:'')
                        cell(5,kk,de.parentPhone?:'')
                        cell(6,kk,de.sendType?.label?:'')
                        cell(7,kk,de.school?:'')
                        cell(8,kk,de.plan?.name?:'')
                        cell(9,kk,receiverDistrict)
                        cell(10,kk,de.receiverAddress?:'')
                        cell(11,kk,de.receiver?:'')
                        cell(12,kk,de.receivePhone?:'')
                        cell(13,kk,de.cardPhotoPath?:'')
                        cell(14,kk,de.cardBackgroundPhotoPath?:'')
                        cell(15,kk,de.payPhoto?:'')
                        cell(16,kk,de.reviewStatus?.label?:'')
                        cell(17,kk,de.exStatus?.label?:'')
                        cell(18,kk,de.exDate?de.exDate.format('yyyy-MM-dd'):'')
                        cell(19,kk,de.counselor?:'')
                        cell(20,kk,de.counselorPhone?:'')
                        cell(21,kk,de.remark?:'')
                        cell(22,kk,de.nation?.name?:'')
                        cell(23,kk,de.birthday?de.birthday.format('yyyy-MM-dd'):'')
                        cell(24,kk,de.politicalStatus?.name?:'')
                        cell(25,kk,de.familyType?.label?:'')
                        cell(26,kk,district)
                        cell(27,kk,de.address?:'')
                        cell(28,kk,juniorSchool?:'')
                        cell(29,kk,juniorAuthenticator?:'')

                        try {
                            cell(30,kk,de.teacher?.name?:'')
                        } catch (Exception e) {
                            cell(30,kk,'')
                        }
                        cell(31,kk,de.dateCreated?.format('yyyy-MM-dd HH:mm:ss'))
                        try {
                            cell(32,kk,de.reviewDate?.format('yyyy-MM-dd HH:mm:ss'))
                        } catch (e) {
                            cell(32,kk,'')
                        }
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
        preppyInstance.collegeSignUp = Preppy.CollegeSignUp."${params.collegeSignUp}"
        preppyInstance.preppyPlan = PreppyPlan.get(params.long("preppyPlan"))
        preppyInstance.remark = params.remark
        preppyInstance.remark1 = params.remark1
        preppyInstance.remark2 = params.remark2
        def codes = preppyService.generateCode(preppyInstance)
        if(codes && !preppyInstance.code){
            preppyInstance.code=codes[0]
        }
        if(codes && !preppyInstance.csCode){
            preppyInstance.csCode=codes[1]
        }
        if (!preppyInstance.save()) {
            log.error(preppyInstance.errors)
            render(([status: '0'] as JSON) as String)
            return
        }

        render(([status: '1', reviewStatusId:preppyInstance.reviewStatus?.id,reviewStatusLab:preppyInstance.reviewStatus?.label] as JSON) as String)
    }

    def audit(Long id) {
        if(!id) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        def preppyInstance = Preppy.get(id)
        if (!preppyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'preppy.label', default: 'Preppy'), id])
            redirect(action: "list")
            return
        }
        if (!params.reviewStatus || params.reviewStatus == Preppy.ReviewStatus.NO_AUDIT.name() || params.reviewStatus == Preppy.ReviewStatus.GJSZZ.name()) {
            redirect(action: "edit",id: id)
            return
        }
        def userId = springSecurityService.authentication.principal?.id
        preppyInstance.reviewDate = new Date()
        preppyInstance.reviewPerson = User.get(userId as Long)
        preppyInstance.reviewStatus = Preppy.ReviewStatus."${params.reviewStatus}"
        preppyInstance.collegeSignUp = Preppy.CollegeSignUp."${params.collegeSignUp}"
        preppyInstance.preppyPlan = PreppyPlan.get(params.long("preppyPlan.id"))
        preppyInstance.remark = params.remark
        preppyInstance.remark1 = params.remark1
        preppyInstance.remark2 = params.remark2
        def codes = preppyService.generateCode(preppyInstance)
        if(codes && !preppyInstance.code){
            preppyInstance.code=codes[0]
        }
        if(codes && !preppyInstance.csCode){
            preppyInstance.csCode=codes[1]
        }
        if (!preppyInstance.save()) {
            log.error(preppyInstance.errors)
            flash.message = message(code: 'default.save.failure.label')
            redirect(action: "edit",id: id)
            return
        }
        flash.message = message(code: 'default.save.success.label')
        redirect(action: "edit",id: id)
    }
}
