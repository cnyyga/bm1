package bm

import com.baoming.Admission

class QueryController {
    def jcaptchaService

    def admission() {
        def name = params.name
        def idNo = params.idNo
        if(name && idNo){
            try {
                if (!jcaptchaService.validateResponse("imageCaptcha", session.id, params.val_code)) {
                    flash.message = "请输入正确的验证码"
                    render(view: 'admission')
                    return
                }
            } catch (e) {
                flash.message = "请输入正确的验证码"
                render(view: 'admission')
                return
            }
            def admission = Admission.findByNameAndIdNo(name,idNo)
            if(!admission){
                flash.message = "抱歉！没有查询到相关记录，请稍后再试。"
                render(view: 'admissionResult')
                return
            }else{
                flash.message = "恭喜！您已经被我校录取。"
                render(view: 'admissionResult',model: [admissionInstance:admission])
                return
            }
        }
    }


}
