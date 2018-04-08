package bm

import com.baoming.Admission

class QueryController {
    def jcaptchaService

    def admission() {
        def name = params.name
        def idNo = params.idNo
        if(name && idNo){
            if (!jcaptchaService.validateResponse("imageCaptcha", session.id, params.val_code)) {
                flash.message = "请输入正确的验证码"
                render(view: 'admission')
                return
            }
            def admission = Admission.countByNameAndIdNo(name,idNo)
            if(admission==0){
                flash.message = "抱歉！没有查询到相关记录，请稍后再试。"
            }else{
                flash.message = "恭喜！您已经被我校录取。"
            }
        }
    }
}
