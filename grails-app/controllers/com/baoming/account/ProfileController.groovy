package com.baoming.account

import com.baoming.Nation
import com.baoming.Plan
import com.baoming.Preppy
import com.baoming.Province
import com.baoming.City
import com.baoming.District
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.apache.commons.io.FileUtils

class ProfileController {
    def springSecurityService
    def userService
    def provinceService
    def planService

    def index() {
        redirect(action: "edit")
    }

    def rePassword() {
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_STUDENT)) {
            render(view: 're_password')
        }else{
            render(view: 're_password_m')
        }
    }

    def saveRePassword() {
        def password = params.password
        def passwordnew = params.password_new
        def passwordnew2 = params.password_new2
        def userInstance = User.get(springSecurityService.principal.id)

        def view =  're_password_m'
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_STUDENT)) {
            view = 're_password'
        }
        if (!password) {
            flash.message =  message(code: 'operator.nopassword.message',default: 'No password')
            render(view: view)
            return
        }
        if (!passwordnew) {
            flash.message =   message(code: 'operator.nopasswordnew.message',default: 'No new password')
            render(view: view)
            return
        }
        if (!passwordnew2) {
            flash.message =  message(code: 'operator.nopasswordnew2.message',default: 'No confirm password')
            render(view: 're_password')
            return
        }

        if (passwordnew.length>16 || passwordnew.length<6) {
            flash.message = message(code: 'operator.password.len.error.message')
            render(view: view)
            return
        }

        if (passwordnew != passwordnew2) {
            flash.message = message(code: 'operator.passwordnotequal.message',default: 'Passwords are not equal')
            render(view: view)
            return
        }

        password =  springSecurityService.encodePassword(password, userInstance.username)
        if (password != userInstance.password) {
            flash.message =   message(code: 'operator.passwordincorrect.message',default: 'The current password is incorrect')
            render(view: view)
            return
        }

        userInstance.password = passwordnew

        if (!userInstance.save(flush: true)) {
            flash.message = message(code: 'operator.passwordfailed.message',default: 'The password change failed')
            render(view: view)
            return
        }

        if (springSecurityService.loggedIn &&
                springSecurityService.principal.username == userInstance.username) {
            springSecurityService.reauthenticate userInstance.username
        }

        flash.message = message(code: 'operator.passwordsuccess.message',default: 'The password change successfully')
        render(view: view)
    }

    def edit() {
        def id = springSecurityService.principal?.id
        def view = params.v?:'info'
        if(!id) {
            redirect(action: 'index',controller: 'reg')
        }
        def studentInstance = Student.get(id)
        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
           // redirect(action: "list")
            render(flash.message)
            return
        }
        render(view: view,model: [student: studentInstance])
    }

    def update() {
        def id = springSecurityService.principal?.id
        def studentInstance = Student.get(id)
        def planId = params.list('planId')
        def v = params.v?:'info'

        if (!studentInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'student.label', default: 'Student'), id])
            render(view: '/error')
            return
        }


        /*if(!planId){
            flash.message = "请选择专业"
            render(view: 'index', model: [student: studentInstance])
            return
        }*/

        studentInstance.properties = params
        def py = studentInstance.payment
        if(!py){
            py = new Payment()
            if(params.get('payment.type')){
                py.date =  params.get('paymentDate')
            }
            studentInstance.payment = py
        } else{
            if(params.get('payment.type')){
                studentInstance.payment.date = params.get('paymentDate')
            }
        }
        def province = params.provinceId?Province.findByCode(params.provinceId):null
        def city =  params.cityId?City.findByCode(params.cityId) :null
        def district = params.districtId?District.findByCode(params.districtId)  :null
        if(province){
            studentInstance.province = province
        }
        if(city){
            studentInstance.city = city
        }
        if(district){
            studentInstance.district = district
        }


        def c = Student.countByAdmissionTicketNumberAndIdNotEqual(params.admissionTicketNumber,id)
        if(c > 0) {
            flash.message = message(code: 'student.admissionTicketNumber.not.unique.message')
            render(view: v, model: [student: studentInstance])
            return
        }

        def file = request.getFile("docPic")
        if (file && !file.empty) {
            def fileName = file.originalFilename
            def suffix = fileName.substring(fileName.lastIndexOf('.'))
            def storeName = studentInstance.number + suffix
            def url = grailsApplication.config.baoming.image.storage.path
            def storageFilePath = url +'/'+storeName
            def f = new File(storageFilePath)
            if(!f.exists()) {
                FileUtils.forceMkdir(f)
            }
            file.transferTo(f)
            studentInstance.payment.docPic = storeName
            studentInstance.payment.docDate = new Date()
        }

        def file1 = request.getFile("admissionTicketPicInp")
        if (file1 && !file1.empty) {
            def fileName1 = file1.originalFilename
            def suffix1 = fileName1.substring(fileName1.lastIndexOf('.'))
            def storeName1 = "admission_ticket_${studentInstance.id}${suffix1}"
            def url1 = grailsApplication.config.baoming.image.storage.path
            def storageFilePath1 = url1 +'/'+storeName1
            def f1 = new File(storageFilePath1)
            if(!f1.exists()) {
                FileUtils.forceMkdir(f1)
            }
            file1.transferTo(f1)
            studentInstance.admissionTicketPic = storeName1
        }

        def s = userService.updateStudent(studentInstance,planId)
        if (s.status == 0) {
            flash.message = s.msg
            render(view: 'edit', params:[v:v], model: [student: studentInstance])
            return
        }
        def msg = message(code: 'reg.student.info.label')
        if(v == 'plan'){
            msg = message(code: 'student.plans.label')
        }
        if(v == 'payment'){
            msg = message(code: 'student.payment.label')
        }
        flash.message = message(code: 'default.updated1.message', args: [msg])
        redirect(action: "edit", params:[v:v])
    }


    def preppy() {
        def userId = springSecurityService.authentication.principal?.id
        def user = User.get(userId)
        if(!user){
            flash.message = message(code: 'default.save.failure.label')
            render(view: "preppy", model: [preppy: null])
            return
        }
        def username = user.username
        def preppy = Preppy.findByNumber(username)
        if(!preppy){
            flash.message = message(code: 'default.save.failure.label')
            render(view: "preppy", model: [preppy: null])
            return
        }
        [preppyInstance:preppy,provinces:provinceService.getProvinces(),
         preppyPlans:planService.getPreppyPlans()]
    }

    def savePreppy() {
        def userId = springSecurityService.authentication.principal?.id
        def user = User.get(userId)
        if(!user){
            flash.message = message(code: 'default.save.failure.label')
            redirect(action: 'preppy')
            return
        }
        def username = user.username
        def preppy = Preppy.findByNumber(username)
        if(!preppy){
            flash.message = message(code: 'default.save.failure.label')
            redirect(action: 'preppy')
            return
        }
        if(preppy.reviewStatus != Preppy.ReviewStatus.NO_AUDIT){
            flash.message = '已经审核无法修改资料'
            redirect(action: 'preppy')
            return
        }
        preppy.family =Preppy.Family."${params.family}"
        preppy.studentCateories = Preppy.StudentCateories."${params.studentCateories}"
        preppy.gender = User.Gender."${params.gender}"
        preppy.nation = Nation.get(params.long("nation"))
        preppy.birthday = params.birthday
        preppy.district = District.findByCode(params.districtId)
        preppy.city = City.findByCode(params.cityId)
        preppy.province = Province.findByCode(params.provinceId)
        preppy.address = params.address
        preppy.plan = Plan.get(params.long("plan.id"))
        preppy.phone = params.phone
        preppy.parentPhone = params.parentPhone
        preppy.qq = params.qq
        preppy.resume = params.resume
        if(!preppy.save()){
            log.error(preppy.errors)
            flash.message = message(code: 'default.save.failure.label')
            render(view: "preppy", model: [preppy: preppy])
            return
        }
        flash.message = message(code: 'default.save.success.label')
        redirect(action: 'preppy')
    }
}
