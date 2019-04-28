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
<%
    def cal = Calendar.instance
    def year = cal.get(Calendar.YEAR)
%>
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
                    <g:message code="student.plans.label" default="Plan" />
                </label>

                <div class="controls">
                    <label>
                        <g:select name="plan.id" from="${plans}" value="${preppyInstance?.plan?.id}" optionValue="name" optionKey="id" required="" noSelection="['':'请选择']"/>
                    </label>
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
                    <g:textField name="receiverAddress"  value="${preppyInstance?.receiverAddress}"/><b class="red">(详细到门牌号)</b>
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
                    <input type="file" required="" name="cardPhotoPathInp">
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
                    <input type="file"  required="" name="cardBackgroundPhotoPathInp">
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
                    <input type="file"  required="" name="payPhotoPathInp">
                    <g:if test="${preppyInstance.payPhoto}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.payPhoto]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.payPhoto])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>
            <!--审核后可填写-->
            <g:if test="${preppyInstance.reviewStatus?.id == com.baoming.Preppy.ReviewStatus.GJSZZ.id}">
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="nation.label" default="nation" />
                </label>

                    <div class="controls">
                    <label>
                        <g:select name="nation.id" from="${com.baoming.Nation.findAll()}" class="sel_gray" optionValue="name" optionKey="id"  value="${preppyInstance?.nation?.id}" noSelection="['':'请选择']"/>
                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.birthday.label" default="nation" />
                </label>

                <div class="controls">
                    <label>
                        <g:set var="startYear" value="${year-25}"/>
                        <g:datePicker name="birthday" value="${preppyInstance?.birthday}" precision="day"
                                      years="${startYear..(year-10)}" default="none" noSelection="['':'请选择']"/>                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="politicalStatus.label" default="politicalStatus" />
                </label>

                <div class="controls">
                    <label>
                        <g:select name="politicalStatus.id" from="${com.baoming.PoliticalStatus.findAll()}" class="sel_gray" optionValue="name" optionKey="id" value="${preppyInstance?.politicalStatus?.id}" noSelection="['':'请选择']"/>
                    </label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.familyType.label" default="familyType" />
                </label>

                <div class="controls">
                    <label>
                        <g:select name="familyType" from="${com.baoming.Preppy.FamilyType.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.familyType}" noSelection="['':'请选择']"/>
                    </label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.family.label" default="family" />
                </label>

                <div class="controls">
                    <label>
                        <g:hiddenField name="cityVal" value="${preppyInstance?.city?.code}"/>
                        <g:hiddenField name="districtVal" value="${preppyInstance?.district?.code}"/>
                        <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
                        省&nbsp;
                        <g:select id="city" name="cityId" from="" optionKey="id"  class="many-to-one"/>
                        &nbsp;市&nbsp;
                        <g:select id="district" name="districtId" from="" optionKey="id"  class="many-to-one"/>
                        县（区）
                        <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
                        乡镇                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.address.label" default="address" /><b class="red">(详细到门牌号)</b>
                </label>

                <div class="controls">
                    <label>
                        <g:textField name="address" value="${preppyInstance?.address}"  />
                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.resume.juniorSchoolName.label" default="address" />
                </label>

                <div class="controls">
                    <label>
                        <g:textField name="juniorSchool" value="${preppyInstance?.resume?.juniorSchool}"   />
                    </label>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.resume.juniorAuth.label" default="address" />
                </label>

                <div class="controls">
                    <label>
                        <g:textField name="juniorAuthenticator" value="${preppyInstance?.resume?.juniorAuthenticator}"   />
                    </label>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.hkbPath.label" default="Name" />
                </label>

                <div class="controls">
                    <input type="file" name="hkbPathInp">
                    <g:if test="${preppyInstance.hkbPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.hkbksyPath.label" default="Name" />
                </label>

                <div class="controls">
                    <input type="file" name="hkbksyPathInp">
                    <g:if test="${preppyInstance.hkbksyPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbksyPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbksyPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.byzsPath.label" default="Name" />
                </label>

                <div class="controls">
                    <input type="file" name="byzsPathInp">
                    <g:if test="${preppyInstance.byzsPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.byzsPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.byzsPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label" for="name">
                    <g:message code="preppy.xjzmPath.label" default="Name" />
                </label>

                <div class="controls">
                    <input type="file" name="xjzmPathInp">
                    <g:if test="${preppyInstance.xjzmPath}">
                        <g:link action="img1"  controller="api" params="[path:preppyInstance?.xjzmPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.xjzmPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                    </g:if>
                </div>
            </div>
            </g:if>
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
