import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils

class LogoutController {

    /**
     * Index action. Redirects to the Spring security logout uri.
     */
    def index = {
        // TODO put any pre-logout code here
       // SpringSecurityUtils.securityConfig.logout.afterLogoutUrl = createLink(action: 'index',controller: 'login')
        redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl // '/j_spring_security_logout'
    }
}
