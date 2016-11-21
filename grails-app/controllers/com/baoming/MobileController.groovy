package com.baoming

import com.baoming.account.Student
import com.baoming.account.User
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import javax.servlet.http.Cookie

class MobileController {
    def springSecurityService
    def planService
    def provinceService
    def studentTypeService

    def index() {}

    def studentLogin(){
        session['userLoginType']="student"
        def cookie = new Cookie("studentLogin","yes")
        cookie.setPath("/")
        cookie.setMaxAge(0)
        response.addCookie(cookie)

        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            //redirect uri: config.successHandler.defaultTargetUrl
            //return
        }

        String view = 'student_auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                                   rememberMeParameter: config.rememberMe.parameter]
    }

    def teacherLogin(){
        session['userLoginType']="teacher"
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            //redirect uri: config.successHandler.defaultTargetUrl
            //return
        }

        String view = 'teacher_auth'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                                   rememberMeParameter: config.rememberMe.parameter]
    }

    //ѧ��ҳ��
    def info(){
        def userId = springSecurityService.authentication.principal?.id
        def user = User.get(userId)
        if(!user){
            flash.message = message(code: 'default.save.failure.label')
            render(view: "info", model: [preppy: null])
            return
        }
        def username = user.username
        def preppy = Preppy.findByNumber(username)
        if(!preppy){
            flash.message = message(code: 'default.save.failure.label')
            render(view: "info", model: [preppy: null])
            return
        }
        [preppyInstance:preppy,provinces:provinceService.getProvinces(),
         preppyPlans:planService.getPreppyPlans()]
    }

    //��ʦ����ѧ����ѡ������ҳ��
    def createStu() {

    }

    //����ո���
    def addStu() {

        [studentInstance: new Student(params),plans:planService.getStuPlans(),provinces:provinceService.getProvinces(),studentTypes:studentTypeService.getStudentTypes()]
    }

    //���������
    def addPreppy() {
        [preppyInstance: new Preppy(params),provinces:provinceService.getProvinces(),
         preppyPlans:planService.getPreppyPlans()]
    }

    //�����ְ��
    def addMedium() {
        [mediumInstance: new Medium(params),provinces:provinceService.getProvinces(),mediumPlans:planService.getMediumPlans()]
    }

}
