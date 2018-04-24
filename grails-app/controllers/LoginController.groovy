import com.bm.utils.MyNetUtils
import grails.converters.JSON

import javax.servlet.http.Cookie
import javax.servlet.http.HttpServletResponse

import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.context.SecurityContextHolder as SCH
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import com.baoming.account.Role

class LoginController {

    /**
     * Dependency injection for the authenticationTrustResolver.
     */
    def authenticationTrustResolver

    /**
     * Dependency injection for the springSecurityService.
     */
    def springSecurityService

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise.
     */
    def index = {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        }
        else {
            redirect action: 'auth', params: params
        }
    }

    /**
     * Show the login page.
     */
    def auth = {

        //def cookie = new Cookie("studentLogin","yes")
        //cookie.setPath("/")
        //cookie.setMaxAge(0)
        //response.addCookie(cookie)

        def config = SpringSecurityUtils.securityConfig

        if (springSecurityService.isLoggedIn()) {
            redirect uri: config.successHandler.defaultTargetUrl
            return
        }



        String view = 'auth'
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = '/mobile/auth'
        }
        String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
        render view: view, model: [postUrl: postUrl,
                rememberMeParameter: config.rememberMe.parameter]
    }

    /**
     * The redirect action for Ajax requests.
     */
    def authAjax = {
        response.setHeader 'Location', SpringSecurityUtils.securityConfig.auth.ajaxLoginFormUrl
        response.sendError HttpServletResponse.SC_UNAUTHORIZED
    }

    /**
     * Show denied page.
     */
    def denied = {
        if (springSecurityService.isLoggedIn() &&
                authenticationTrustResolver.isRememberMe(SCH.context?.authentication)) {
            // have cookie but the page is guarded with IS_AUTHENTICATED_FULLY
            redirect action: 'full', params: params
        }
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_STUDENT)) {
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                //redirect(controller: 'mobile',action: 'info')
                //return
            }
            redirect(controller: 'logout')
            return
        }

        def view = 'denied'
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = '/mobile/denied'
        }
        render(view: view)
    }

    /**
     * Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page.
     */
    def full = {
        def config = SpringSecurityUtils.securityConfig

        def view = 'auth'
        if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
            view = '/mobile/auth'
        }
        render view: view, params: params,
                model: [hasCookie: authenticationTrustResolver.isRememberMe(SCH.context?.authentication),
                        postUrl: "${request.contextPath}${config.apf.filterProcessesUrl}"]
    }

    /**
     * Callback after a failed login. Redirects to the auth page with a warning message.
     */
    def authfail = {

        def username = session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]
        String msg = ''
        def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
        if (exception) {
            if (exception instanceof AccountExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.expired")
            }
            else if (exception instanceof CredentialsExpiredException) {
                msg = g.message(code: "springSecurity.errors.login.passwordExpired")
            }
            else if (exception instanceof DisabledException) {
                msg = g.message(code: "springSecurity.errors.login.disabled")
            }
            else if (exception instanceof LockedException) {
                msg = g.message(code: "springSecurity.errors.login.locked")
            }
            else {
                msg = g.message(code: "springSecurity.errors.login.fail")
            }
        }

        if (springSecurityService.isAjax(request)) {
            render([error: msg] as JSON)
        }
        else {
            flash.message = msg
            def a =  session['userLoginType']
            if(a == 'student'){
                redirect action: 'studentLogin',controller: 'mobile', params: params
                return
            }else if(a == 'teacher'){
                redirect action: 'teacherLogin', controller: 'mobile',params: params
                return
            }
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                if(session.studentLogin){
                    redirect action: 'studentLogin',controller: 'mobile', params: params
                    return
                }else {
                    redirect action: 'teacherLogin', controller: 'mobile',params: params
                    return
                }
            }
            if(session.studentLogin){
                redirect action: 'index',controller: 'stu', params: params
                return
            }
            redirect action: 'auth', params: params
        }
    }

    /**
     * The Ajax success redirect url.
     */
    def ajaxSuccess = {
        render([success: true, username: springSecurityService.authentication.name] as JSON)
    }

    /**
     * The Ajax denied redirect url.
     */
    def ajaxDenied = {
        render([error: 'access denied'] as JSON)
    }

    def dispatch = {
        println(request.getHeader("user-agent"))
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_STUDENT)) {
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                //redirect controller: 'mobile',action: 'info'
                //return ;
            }
            redirect controller: 'logout'
        } else {
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                redirect controller: 'mobile',action: 'createStu'
                return ;
            }
            redirect controller: 'home'
        }
    }
}
