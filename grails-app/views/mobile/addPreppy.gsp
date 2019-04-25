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
                    <g:textField name="name" maxlength="32" require=""  value="${preppyInstance?.name}"/>
                </div>
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
                    <g:message code="preppy.number.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
                        <g:textField name="number" value="${preppyInstance?.number}"   size="40" require=""/>
                    </g:if>
                    <g:else>
                        <g:textField name="number" value="${preppyInstance?.number} " size="40"  readonly="readonly"/>
                    </g:else>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.phone.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:textField name="phone" maxlength="32" require="" value="${preppyInstance?.phone}"/>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.parentPhone.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:textField name="parentPhone" maxlength="32"  require="" value="${preppyInstance?.parentPhone}"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.school.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <g:textField name="school" maxlength="32" require="" value="${preppyInstance?.school}"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.sendType.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <label>
                        <g:select  name="sendType" from="${com.baoming.Preppy.SendType.values()}" optionValue="label" required="" value="${preppyInstance?.sendType}" noSelection="['':'请选择']"/>
                    </label>
                </div>
            </div>

            <div class="control-group receiver-ele">
                <label class="control-label" for="name">
                    <g:message code="preppy.receiverFamily.label" default="Name" />
                </label>

                <div class="controls">
                    <g:hiddenField name="receiverCityVal" value="${preppyInstance?.receiverCity?.code}"/>
                    <g:hiddenField name="receiverDistrictVal" value="${preppyInstance?.receiverDistrict?.code}"/>
                    <g:select id="receiverProvince" name="receiverProvinceId" from="${provinces}" optionKey="code" optionValue="name" value="${preppyInstance?.receiverProvince?.code}" noSelection="['':'请选择']"/>
                    省&nbsp;
                    <g:select id="receiverCity" name="receiverCityId" from="" optionKey="id"  class="many-to-one"/>
                    &nbsp;市&nbsp;
                    <g:select id="receiverDistrict" name="receiverDistrictId" from="" optionKey="id"  class="many-to-one"/>
                    县（区）
                    <g:textField name="receiverTown" value="${preppyInstance?.receiverTown}" placeholder="${message(code: 'preppy.town.label')}"/>
                    乡镇                </div>
            </div>

            <div class="control-group receiver-ele">
                <label class="control-label" for="name">
                    <g:message code="preppy.receiverAddress.label" default="receiverAddress" />
                </label>

                <div class="controls">
                    <g:textField name="receiverAddress"  value="${preppyInstance?.receiverAddress}"/>
                </div>
            </div>
            <div class="control-group receiver-ele">
                <label class="control-label" for="name">
                    <g:message code="preppy.receiver.label" default="receiver" />
                </label>

                <div class="controls">
                    <g:textField name="receiver" maxlength="32"  value="${preppyInstance?.receiver}"/>
                </div>
            </div>
            <div class="control-group receiver-ele">
                <label class="control-label" for="name">
                    <g:message code="preppy.receivePhone.label" default="receivePhone" />
                </label>

                <div class="controls">
                    <g:textField name="receivePhone" maxlength="32"  value="${preppyInstance?.receivePhone}"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.cardPhotoPath.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <input type="file" name="cardPhotoPathInp">
                    <g:if test="${preppyInstance.cardPhotoPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.cardBackgroundPhotoPath.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <input type="file" name="cardBackgroundPhotoPathInp">
                    <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.payPhoto.label" default="Name" />
                    <span class="required-indicator">*</span>
                </label>

                <div class="controls">
                    <input type="file" name="payPhotoPathInp">
                    <g:if test="${preppyInstance.payPhoto}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.payPhoto]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.payPhoto])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
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
