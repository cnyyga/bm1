<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainStudent">
    <g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <g:javascript src="baoming.js"/>
</head>
<body>
<div class="reg-content">
    <div class="reg-header">
        修改密码
    </div>
    <g:if test="${flash.message}">
        <div class="info-result">
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${student}">
        <ul class="errors" role="alert">
            <g:eachError bean="${student}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form method="post" action="saveRePassword">
        <ul class="reg_box">
            <li class="accounts">
                <label class="reg_tit">密码：</label>

                <div style="z-index:1" class="reg_element">
                    <span class="inp_box">
                        <input type="password" errmsg="密码应该由6-20个字母、数字或特殊字符组成" reqmsg=" 请输入密码" maxlength="20" minlength="6"
                               reg-pattern="/^[ -~]{6,20}$/" datatype="reg" name="password" class="txt" data-result="">
                    </span>

                </div>
            </li>

            <li class="password">
                <label class="reg_tit">新密码：</label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="password" errmsg="密码应该由6-20个字母、数字或特殊字符组成" reqmsg=" 请输入密码" maxlength="20" minlength="6"
                               reg-pattern="/^[ -~]{6,20}$/" datatype="reg" name="password_new" class="txt" data-result="">
                    </span>

                    <div style="margin-left: 0px; display: none;" class="reg_tips form-valid-tip-normal">
                        <div style="display:block;" class="prompt left l">
                            <i class="img abs arrow"></i>
                            <span class="w2 account_taken_kx">由6-20个字母、数字或特殊字符组成</span>
                        </div>
                    </div>

                </div>
            </li>
            <li class="password">
                <label class="reg_tit">确认密码：</label>

                <div class="reg_element">
                    <span class="inp_box">
                        <input type="password" errmsg="密码应该由6-20个字母、数字或特殊字符组成" reqmsg=" 请输入密码" maxlength="20" minlength="6"
                               reg-pattern="/^[ -~]{6,20}$/" datatype="reg" name="password_new2" class="txt" data-result="">
                    </span>

                    <div style="margin-left: 0px; display: none;" class="reg_tips form-valid-tip-normal">
                        <div style="display:block;" class="prompt left l">
                            <i class="img abs arrow"></i>
                            <span class="w2 account_taken_kx">由6-20个字母、数字或特殊字符组成</span>
                        </div>
                    </div>

                </div>
            </li>
        </ul>

        <div style="padding: 10px;">

            <g:submitButton name="sub" class="input-submit" value="${message(code: 'operator.changepassword.label', default: 'Save')}" />
        </div>
    </g:form>
</div>
</body>
</html>