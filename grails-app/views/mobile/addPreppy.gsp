<%@ page import="com.baoming.account.Role" %>
<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.create.preppy.title"/></title>
    <g:javascript src="jquery-ui-1.9.2.custom.min.js"  />
    <g:javascript src="jquery.chosen.min.js"  />
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="tj.js"/>
    <g:javascript src="app-preppy.js"/>
    <script>
        $(function(){
            <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
            $(".xstx input").attr("disabled",true);
            $(".xstx select").attr("disabled",true);
            $(".zbsh input").attr("disabled",true);
            $(".zbsh select").attr("disabled",true);
            </sec:ifAllGranted>
            <sec:ifAllGranted roles="${Role.AUTHORITY_FINANCE}">
            $(".xstx input").attr("disabled",true);
            $(".xstx select").attr("disabled",true);
            $(".lstx input").attr("disabled",true);
            $(".lstx select").attr("disabled",true);
            </sec:ifAllGranted>
        })

    </script>
    <style>
        .select-body{
            background:none;
            border:0;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.mobile.create.preppy.title"/></h2>
</div>
<div class="page-content gradient" >
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div class="page-body select-body">
        <g:uploadForm  action="save" controller="preppy" name="editForm" >

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.name.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:textField name="name" maxlength="32"  value="${preppyInstance?.name}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.number.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
                        <g:textField name="number" value="${preppyInstance?.number}"   size="40" />
                    </g:if>
                    <g:else>
                        <g:textField name="number" value="${preppyInstance?.number} " size="40"  readonly="readonly"/>
                    </g:else>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="user.password.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <input name="password" type="text"  class="inp_gray" id="password" size="40" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.deposit.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:textField name="deposit" value="${preppyInstance?.deposit}" size="10" class="sel_gray"/>元
                </div>
            </div>

            <div>
                <button type="submit" class="btn btn-primary">${message(code: 'default.button.update.label')}</button>
                <button type="reset" class="btn">${message(code: 'default.button.reset.label')}</button>
                <g:link action="createStu"  controller="mobile" class="btn">${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')}</g:link>

            </div>
         </g:uploadForm>
    </div>
</div>
</body>
</html>
