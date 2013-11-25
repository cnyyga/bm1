<%@ page import="com.baoming.Plan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainReg">
    <g:set var="entityName" value="${message(code: 'reg.label', default: 'Reg')}"/>
    <title>${entityName}</title>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="baoming.js"/>
    <style>

    .reg-content textarea.txt {
        height: 60px;
    }
    </style>
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
    <g:hasErrors bean="${student}">
        <ul class="errors" role="alert">
            <g:eachError bean="${student}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form action="save" controller="reg" name="regForm">
        <ul class="reg_box">
            %{--<li class="accounts">
                <label class="reg_tit"><g:message code="user.username.label"/> ：<span class="required-indicator">*</span></label>

                <div style="z-index:1" class="reg_element">
                    <span class="inp_box">
                        <g:textField name="username" class="txt" value="${student?.username}"/>
                    </span>
                </div>
            </li>--}%
            <li class="live">
                <label class="reg_tit"><g:message code="student.number.label"/>： <span class="required-indicator">*</span>
                </label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:textField name="number" value="${student?.number}" class="txt"/>
                    </span>
                </div>
            </li>

          %{--  <li class="password">
                <label class="reg_tit"><g:message code="user.password.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="password" name="password" class="txt" data-result="">
                    </span>
                </div>
            </li>--}%
            <li class="name">
                <label class="reg_tit"><g:message code="student.name.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="text" name="name" class="txt" value="${student?.name}">

                    </span>
                </div>
            </li>
            <li class="code">
                <label class="reg_tit"><g:message code="student.code.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="text" name="code" class="txt" data-result="" value="${student?.code}">
                    </span>
                </div>
            </li>
            <li class="score">
                <label class="reg_tit"><g:message code="student.score.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="text" name="score" class="txt" data-result="" value="${student?.score}">
                    </span>
                </div>
            </li>
            <g:set var="sps" value="${planIds}"/>
            <li class="planId1">
                <label class="reg_tit"><g:message code="student.plans.label"/>1：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:select name="planId" id="planId1"  noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" value="${(sps && sps[0])?sps[0]:''}" />
                    </span>
                </div>
            </li>
            <li class="planId2">
                <label class="reg_tit"><g:message code="student.plans.label"/>2：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:select name="planId" id="planId2"  noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" value="${(sps && sps[1])?sps[1]:''}"/>
                    </span>
                </div>
            </li>
            <li class="planId3">
                <label class="reg_tit"><g:message code="student.plans.label"/>3：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:select name="planId" id="planId3"  noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" value="${(sps && sps[2])?sps[2]:''}"/>
                    </span>
                </div>
            </li>

            <li class="middleSchoolId">
                <label class="reg_tit"><g:message code="middleSchool.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  value="${student?.province?.code}" noSelection="['': '请选择']" class="many-to-one"/>
                        <g:select id="city" name="cityId" from="${[]}"  value="${student?.city?.code}" class="many-to-one"/>
                        <g:select id="district" name="districtId" from="${[]}"  value="${student?.district?.code}" class="many-to-one"/>
                        <g:select name="middleSchoolId" from="${[]}"  noSelection="['': '请选择']"/>
                    </span>
                </div>
            </li>

            <li class="phone">
                <label class="reg_tit"><g:message code="student.phone.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="text" name="phone" class="txt" value="${student?.phone}">
                    </span>
                </div>
            </li>
            <li class="qq">
                <label class="reg_tit"><g:message code="student.qq.label"/>：<span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="text" name="qq" class="txt" value="${student?.qq}">
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
            <button class="btn-large btn btn-primary" type="submit">注册</button>
            <a href="javascript:history.back(-1)" >返回</a>
        </div>
    </g:form>
</div>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${student?.city?.code}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${student?.district?.code}" />
<g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${student?.middleSchool?.id}" />

</body>
</html>