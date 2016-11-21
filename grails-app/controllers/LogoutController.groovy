import com.bm.utils.MyNetUtils
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

    def dispatch = {
        def cookies = request.getCookies();
        def stu = false
        cookies.each {c->
            def a = c.getName();
            if(a == 'studentLogin'){
                stu = true
            }
        }
        if(stu){
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                redirect(controller: 'mobile',action: 'studentLogin');
                return
            }
            redirect(controller: 'stu',action: 'index')
        }else{
            if(MyNetUtils.checkMobile(request.getHeader("user-agent"))){
                redirect(controller: 'mobile',action: 'teacherLogin');
                return
            }
            redirect(controller: 'login',action: 'auth')
        }
    }
}
