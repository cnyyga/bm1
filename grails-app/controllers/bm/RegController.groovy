package bm

import com.baoming.account.Student
import com.baoming.account.User
import com.baoming.Plan
import com.baoming.Province
import com.baoming.City
import com.baoming.District
import com.baoming.account.Payment
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.web.util.TextEscapeUtils

class RegController {
    def userService
    def jcaptchaService
    def index() {
        // [student: new Student(params)]
    }

    def save() {

       // def planId = params.list('planId')
        def student = new Student(params)
        student.username = params.number
        try {
            /*
            三个参数：name(标签中的name),session.id这个是固定的,用户输入的内容
             */
            if (!jcaptchaService.validateResponse("imageCaptcha", session.id, params.val_code)) {
                flash.message = "验证码错误"
                render(view: 'index', model: [student: student,planIds:[]])
                return
            }
        } catch (Exception e) {
            flash.message = "拒绝重复提交"
            render(view: 'index', model: [student: student,planIds:[]])
            return
        }

       /* if(!planId || planId.empty){
            flash.message = "请选择专业"
            render(view: 'index', model: [student: student,planIds:planId])
            return
        }
*/
      /*  def province = Province.findByCode(params.provinceId)
        def city = City.findByCode(params.cityId)
        def district = District.findByCode(params.districtId)
        student.province=province
        student.city = city
        student.district=district*/

        def c = Student.countByUsername(params.number)
        if(c > 0) {
            flash.message = message(code: 'student.number.not.unique.message')
            render(view: 'index', model: [student: student])
            return
        }

        def s = userService.saveStudent(student,[])

        if (s.status == 0) {
            //flash.message = s.msg
            render(view: 'index', model: [student: student,planIds:[]])
            return
        }

        session[UsernamePasswordAuthenticationFilter.SPRING_SECURITY_LAST_USERNAME_KEY]= student.username
        render(view: 'success')
    }
}
