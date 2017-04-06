<%@ page import="com.baoming.account.Role" %>
<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.edit.preppy.title"/></title>
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
        <g:uploadForm  action="update" controller="preppy" name="editForm" >
            <g:hiddenField name="id" value="${preppyInstance.id}"/>
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
                </label>

                <div class="controls">
                    <input name="password" type="text"  class="inp_gray" id="password" size="40" />
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.family.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
                    省&nbsp;
                    <g:select id="city" name="cityId" from="" optionKey="id" required="" class="many-to-one"/>
                    &nbsp;市&nbsp;
                    <g:select id="district" name="districtId" from="" optionKey="id" required="" class="many-to-one"/>
                    县（区）
                    <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
                    乡镇                </div>
            </div>


            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.gender.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <label>
                        <input name="gender" type="radio" id="radio" value="${com.baoming.account.User.Gender.MALE.name()}" <g:if test="${!preppyInstance?.gender?.name() || preppyInstance?.gender?.name() == com.baoming.account.User.Gender.MALE.name()}">checked="checked"</g:if> />
                        ${com.baoming.account.User.Gender.MALE.label}&nbsp; &nbsp;&nbsp;
                        <input type="radio" name="gender" id="radio2" value="${com.baoming.account.User.Gender.FEMALE.name()}" <g:if test="${preppyInstance?.gender?.name() == com.baoming.account.User.Gender.FEMALE.name()}">checked="checked"</g:if>/>
                        ${com.baoming.account.User.Gender.FEMALE.label} </label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.depositType.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:select name="depositType" from="${com.baoming.Preppy.DepoistType.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.depositType}"/>
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
                <button type="submit" class="btn btn-primary btn-lg btn-block">${message(code: 'default.button.update.label')}</button>
                <g:set var="entityName" value="${message(code: 'preppy.label', default: 'Student')}" />
                <button type="button" class="btn btn-info btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'preppy',action: 'list')}'">${message(code: 'default.button.back.label')}<g:message code="default.list.label" args="[entityName]" /> </button>
                <button type="button" class="btn btn-default btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'createStu')}'">${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')} </button>

            </div>
         </g:uploadForm>
    </div>
</div>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
</body>
</html>
