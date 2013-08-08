import com.baoming.account.Role
import com.baoming.account.UserRole
import com.baoming.account.Admin

class BootStrap {

    def init = { servletContext ->
       def adminRole = new Role(name:'系统管理员',authority: 'ROLE_ADMIN').save(flush: true)
        def teacherRole = new Role(name:'老师',authority: 'ROLE_TEACHER').save(flush: true)
        def studentRole = new Role(name:'学生',authority: 'ROLE_STUDENT').save(flush: true)
        def financeRole = new Role(name:'财务',authority: 'ROLE_FINANCE').save(flush: true)
        def adminUser = new Admin(name: '系统管理员', username: 'admin', enabled: true, password: '1') .save(flush: true)
        UserRole.create adminUser, adminRole, true

    }
    def destroy = {
    }
}
