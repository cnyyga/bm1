package bm

import com.baoming.account.Student
import com.baoming.account.UserRole
import com.baoming.account.User
import com.baoming.account.Role
import com.baoming.Plan
import com.baoming.account.Teacher
import com.baoming.StudentPlan
import grails.plugin.cache.CacheEvict
import grails.plugin.cache.Cacheable
import org.springframework.dao.DataIntegrityViolationException
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import com.baoming.account.Admin
import com.baoming.account.Finance
import com.baoming.District
import com.baoming.City
import com.baoming.MiddleSchool
import com.baoming.account.TeacherDistrict
import com.baoming.Department

class UserService {

    def getStudents(Long userId, def params) {
        def year = params.date('year', 'yyyy')
        def planId = params.planId
        def cityId = params.cityId
        def districtId = params.districtId
        def departmentId = params.departmentId
        def middleSchoolId = params.long('middleSchoolId')

        def startDate = params.date('startDate', 'yyyy-MM-dd')
        def endDate = params.date('endDate', 'yyyy-MM-dd')
        def cal = Calendar.instance
        cal.clearTime()
        if(!year){
            cal.set(Calendar.DAY_OF_YEAR,1)
            cal.set(Calendar.MONTH,0)
            startDate = cal.time
            cal.add(Calendar.YEAR,1)
            endDate = cal.time
        }else{
            cal.time = year
            cal.add(Calendar.YEAR,1)
            startDate = year
            endDate = cal.time
        }

        def plan
        if(planId){
            plan = Plan.get(planId)
        }
        def district
        if(districtId){
            district = District.findByCode(districtId)
        }
        def city
        if(cityId){
            city = City.findByCode(cityId)
        }
        def middleSchool
        if(middleSchoolId){
            middleSchool = MiddleSchool.get(middleSchoolId)
        }

        def teachers
        if(departmentId) {
            teachers = Teacher.findAll("from Teacher where department.id=:departmentId",[departmentId:departmentId as long])
        }

        def teacher

        def reviewStatus = params.audit
        def list = []
        def total = 0

        //def districts
        if (SpringSecurityUtils.ifAllGranted(Role.AUTHORITY_TEACHER)) {
            teacher = Teacher.get(userId)
           // districts = teacher?.teacherDistricts*.district
           // if(!districts || districts.empty){
               // return [students: list, total: total]
            //}
        }else if(params.teacherId){
            teacher = Teacher.get(params.teacherId)
            //districts = teacher?.teacherDistricts*.district
            //if(!districts || districts.empty){
               // return [students: list, total: total]
           // }
        }

        def closure = {
            if (startDate)
                ge('dateCreated', startDate)
            if (endDate)
                lt('dateCreated', endDate)
            if (reviewStatus) {
                eq('reviewStatus', Student.ReviewStatus."${reviewStatus}")
            }
            if(district)   {
                eq("district",district)
            }
            if(city){
                eq('city',city)
            }
            if(middleSchool){
                eq('middleSchool',middleSchool)
            }
            if(plan){
                studentPlans{
                    eq('plan',plan)
                }
            }
            if (params.name)
                like('name', "%${params.name}%")

           // or{
               // if(districts){
                //    'in'('district',districts)
               /// }
                if(teacher) {
                    eq('teacher',teacher)
                }
           // }

            if(teachers && !teachers.empty) {
                and{
                    isNotNull('teacher')
                    'in'('teacher',teachers)
                }
            }

            order('id','desc')
        }

        list = Student.createCriteria().list(params,closure)
        total = Student.createCriteria().count(closure)

        [students: list, total: total]
    }

    def saveStudent(Student student,List planIds) {

        student.enabled = true

        if (!student.save(flush: true)) {
            log.error student.errors
            return [status: 0, msg: student.errors]
        }

        def role = Role.findByAuthority('ROLE_STUDENT')

        def ur = UserRole.create(student, role, true)
        if (!ur) {
            log.error ur.errors
            return [status: 0, msg: ur.errors]
        }

        planIds.each {pid->
            if(!pid){
                return
            }
            def plan = Plan.get(pid)
            def studentPlan = StudentPlan.create(student,plan,false)
            if(!studentPlan){
                log.error studentPlan.errors
                return
            }
        }
        return [status: 1]
    }

    def saveStudent(Student student,Plan plan,Teacher teacher = null) {

        student.enabled = true

        if (!student.save(flush: true)) {
            log.error student.errors
            return [status: 0, msg: student.errors]
        }

        def role = Role.findByAuthority('ROLE_STUDENT')

        def ur = UserRole.create(student, role, true)
        if (!ur) {
            log.error ur.errors
            return [status: 0, msg: ur.errors]
        }

        def studentPlan = StudentPlan.create(student,plan,false)
        if(!studentPlan){
            log.error studentPlan.errors
            return [status: 0, msg: ur.errors]
        }

        return [status: 1]
    }

    def updateStudent(Student student,List planIds) {

        if (!student.save(flush: true)) {
            log.error student.errors
            return [status: 0, msg: student.errors]
        }

        StudentPlan.removeAll(student)

        planIds.each {pid->
            if(!pid){
                return
            }
            def plan = Plan.get(pid)
            def studentPlan = StudentPlan.create(student,plan,false)
            if(!studentPlan){
                log.error studentPlan.errors
                return
            }
        }

        return [status: 1]
    }

    def saveStudent(Student student) {

        if (!student.save(flush: true)) {
            log.error student.errors
            return [status: 0, msg: student.errors]
        }

        return [status: 1]
    }

    def removeStudent(Student student) throws DataIntegrityViolationException{
        UserRole.removeAll(student)
        StudentPlan.removeAll(student)
        student.delete(flush: true)
    }

    def saveAdmin(Admin admin) {
        saveUser(admin,Role.AUTHORITY_ADMIN)
    }

    def saveFinance(Finance finance) {
        saveUser(finance,Role.AUTHORITY_FINANCE)
    }

    def saveTeacher(Teacher teacher,List cityIds = []) {
        def a = saveUser(teacher,Role.AUTHORITY_TEACHER)
        if(a.status == 0 || !cityIds || cityIds.size() == 0){
            return a
        }

        def i = 0
        cityIds.each {cityId->
            def district = District.findByCode(cityId)
            if(!new TeacherDistrict([teacher:teacher,district:district]).save() ){
                 i++
            }
        }
        return i == 0?a:[status: 0]
    }

    def updateTeacher(Teacher teacher,List cityIds = []){
        if(!teacher.save(flush: true) ){
            return [status: 0]
        }
        def tc =TeacherDistrict.findAllByTeacher(teacher)

        if(tc){
            tc*.delete(flush: true)
        }
        if(!cityIds || cityIds.size() == 0){
            return  [status: 1]
        }
        def i = 0
        cityIds.each {cityId->
            def district = District.findByCode(cityId)
            def teacherCity =  new TeacherDistrict([teacher:teacher,district:district])
            if(!teacherCity.save(flush: true)){
                i++
                log.error(teacherCity.errors)
            }
        }
        return [status: i ==0 ?1:0]
    }

    def saveUser(User user,String authority){
        if (!user.save(flush: true)) {
            log.error user.errors
            return [status: 0, msg: user.errors]
        }
        def role = Role.findByAuthority(authority)
        def ur = UserRole.create(user, role, true)
        if (!ur) {
            log.error ur.errors
            return [status: 0, msg: ur.errors]
        }
        [status: 1]
    }

    def removeUser(User user){
        UserRole.removeAll(user)
        user.delete(flush: true)
    }

    @Cacheable('teachers')
    def getTeachers() {
        Teacher.findAllByEnabled(Boolean.TRUE)
    }

    @CacheEvict(value='teachers', allEntries = true)
    def clearTeachers() {

    }
}
