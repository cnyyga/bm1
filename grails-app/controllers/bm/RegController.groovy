package bm

import com.baoming.MiddleSchool
import com.baoming.account.Student
import com.baoming.account.User
import com.baoming.Plan
import com.baoming.Province
import com.baoming.City
import com.baoming.District
import com.baoming.account.Payment
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter

class RegController {
    def userService
    def jcaptchaService
    def planService
    def provinceService

    def index() {
         [student: new Student(params),plans:planService.getPlans(),provinces:provinceService.getProvinces()]
    }

    def save() {

        def planId = params.list('planId')
        def student = new Student(params)
        student.username = params.number
        student.password = '111111'


        if(!params.middleSchoolId){
            flash.message = "请选择毕业中学"
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }

        def province = Province.findByCode(params.provinceId)
        def city = City.findByCode(params.cityId)
        def district = District.findByCode(params.districtId)
        student.province=province
        student.city = city
        student.district=district
        student.middleSchool = MiddleSchool.get(params.middleSchoolId)

        def score = params.float('score')
        if(!score || score < 0) {
            flash.message = "请填写正确高考成绩"
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }
        if(!planId || planId.empty){
            flash.message = "请选择专业"
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }

        def scoreStr = ''
        planId.each {p->
            def plan = Plan.get(p)
            def planScore = plan.score
            if(score < planScore) {
                scoreStr += plan.name + ' '
            }
        }
        if(scoreStr) {
            flash.message = "高考分数未达到填报专业【${scoreStr}】分数要求，注册失败。 "
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }

        try {
            /*
            三个参数：name(标签中的name),session.id这个是固定的,用户输入的内容
             */
            if (!jcaptchaService.validateResponse("imageCaptcha", session.id, params.val_code)) {
                flash.message = "验证码错误"
                render(view: 'index', model: [student: student,planIds:planId])
                return
            }
            def s = userService.saveStudent(student,planId)

            if (s.status == 0) {
                flash.message = '出现不明异常，保存失败'
                render(view: 'index', model: [student: student,planIds:planId])
                return
            }

            session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]= student.username
            render(view: 'success')
        } catch (Exception e) {
            flash.message = "拒绝重复提交"
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }
    }
}
