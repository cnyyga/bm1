package bm

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import javax.servlet.http.Cookie

class StuController {
    def springSecurityService

    def index = {
        session.studentLogin = 'yes'
        def cookie = new Cookie("studentLogin","yes")
        cookie.setPath("/")
        cookie.maxAge=-1
        response.addCookie(cookie)
        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }

        String view = 'index'
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                                   rememberMeParameter: config.rememberMe.parameter]
    }

}
