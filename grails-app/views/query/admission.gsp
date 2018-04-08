<%@ page import="com.baoming.Plan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainReg">
    <g:set var="entityName" value="${message(code: 'admission.query.label', default: 'Reg')}"/>
    <title>${entityName}</title>
    <script>
        $(function () {
            $(".captcha_referer").click(function(){
                var s = $("#imageCaptcha").attr("src") ;
                var id = s.indexOf("=");
                var ss  = s.substring(0,id+1) ;
                var d = new Date();
                d = d.getTime() ;
                d += '';
                d = d.substring(0,10);
                ss += d;
                $("#imageCaptcha").attr("src",ss) ;
            })
        })
    </script>
</head>

<body>
<div class="reg-content">
    <div class="reg-header">
        ${entityName}
    </div>
    <g:if test="${flash.message}">
        <div class="info-result ">
            <label class="error">${flash.message}</label>
        </div>
    </g:if>

    <g:form action="admission" controller="query" name="regForm">
        <ul class="reg_box">
            <li class="live">
                <label class="reg_tit"><g:message code="admission.name.label"/>： <span class="required-indicator">*</span>
                </label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:textField name="name" value="${params?.name}" class="txt"/>
                    </span>
                </div>
            </li>
            <li class="live">
                <label class="reg_tit"><g:message code="student.number.label"/>： <span class="required-indicator">*</span>
                </label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:textField name="idNo" value="${params?.idNo}" class="txt"/>
                    </span>
                </div>
            </li>
            <li class="captchadiv">
                <label class="reg_tit "><g:message code="reg.validate.code.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element ">
                    <span class="inp_box"><input type="text" id="val_code" name="val_code" class="capt txt">
                    </span>
                </div>
            </li>
            <li class="captchadiv">
                <label class="reg_tit "></label>

                <div class="reg_element ">
                    <span class="inp_box">
                        <jcaptcha:jpeg name="imageCaptcha"/> <a href="javascript:void 0"
                                                                class="captcha_referer"><g:message code="reg.not.known.label"/></a>
                    </span>
                </div>
            </li>
        </ul>

        <div style="padding: 50px;">
            <button class="btn-large btn btn-primary" type="submit">
                <g:message code="default.button.query.label"/>
            </button>
        </div>
    </g:form>
</div>
</body>
</html>