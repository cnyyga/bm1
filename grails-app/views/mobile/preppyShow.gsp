<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.preppy.show.title"/></title>

    <style>
        .select-body{
            background:none;
            border:0;
        }
        .form-horizontal .control-label {
            width: 100px;
        }
        .form-horizontal .controls {
            margin-left: 120px;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.mobile.preppy.show.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body select-body">
        <div class="form-horizontal">
            <fieldset>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.name.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.name}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.gender.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.gender?.label }
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.number.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.number}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.phone.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.phone}
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.parentPhone.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.parentPhone}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.school.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.school}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.sendType.label" default="Name" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.sendType?.label}
                        </label>
                    </div>
                </div>
                <g:if test="${preppyInstance?.sendType == com.baoming.Preppy.SendType.EXPRESS}">
                <div class="control-group receiver-ele">
                    <label class="control-label" for="name">
                        <g:message code="preppy.receiverFamily.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.receiverProvince?.name} 省&nbsp;
                        ${preppyInstance?.receiverCity?.name} &nbsp;市&nbsp;
                        ${preppyInstance?.receiverDistrict?.name}县（区）
                        ${preppyInstance?.receiverTown}乡镇                </div>
                </div>

                <div class="control-group receiver-ele">
                    <label class="control-label" for="name">
                        <g:message code="preppy.receiverAddress.label" default="receiverAddress" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.receiverAddress}
                    </div>
                </div>
                <div class="control-group receiver-ele">
                    <label class="control-label" for="name">
                        <g:message code="preppy.receiver.label" default="receiver" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.receiver}
                    </div>
                </div>
                <div class="control-group receiver-ele">
                    <label class="control-label" for="name">
                        <g:message code="preppy.receivePhone.label" default="receivePhone" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.receivePhone}
                    </div>
                </div>
                </g:if>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.cardPhotoPath.label" default="Name" />
                    </label>

                    <div class="controls">
                        <g:if test="${preppyInstance.cardPhotoPath}">
                            <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                        </g:if>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.cardBackgroundPhotoPath.label" default="Name" />
                    </label>

                    <div class="controls">
                        <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                            <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                        </g:if>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.payPhoto.label" default="Name" />
                    </label>
                    <div class="controls">
                        <g:if test="${preppyInstance.payPhoto}">
                            <g:link action="img1"  controller="api" params="[path:preppyInstance?.payPhoto]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.payPhoto])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                        </g:if>
                    </div>
                </div>
                <!--审核后可填写-->
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="nation.label" default="nation" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.nation?.name}                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.birthday.label" default="nation" />
                    </label>

                    <div class="controls">
                        <label>
                            <g:formatDate date="${preppyInstance?.birthday}" format="yyyy-MM-dd"/>  </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="politicalStatus.label" default="politicalStatus" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.politicalStatus?.name}                           </label>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.familyType.label" default="familyType" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.familyType?.label}
                        </label>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.family.label" default="family" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.province?.name}省&nbsp;
                            ${preppyInstance?.city?.name}&nbsp;市&nbsp;
                            ${preppyInstance?.district?.name}县（区）
                            ${preppyInstance?.town}乡镇</label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.address.label" default="address" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.address}
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.resume.juniorSchoolName.label" default="address" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.resume?.juniorSchool}
                        </label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.resume.juniorAuth.label" default="address" />
                    </label>

                    <div class="controls">
                        <label>
                            ${preppyInstance?.resume?.juniorAuthenticator}
                        </label>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.hkbPath.label" default="Name" />
                    </label>

                    <div class="controls">
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
                        <g:if test="${preppyInstance.xjzmPath}">
                            <g:link action="img1"  controller="api" params="[path:preppyInstance?.xjzmPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.xjzmPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                        </g:if>
                    </div>
                </div>
            </fieldset>
        </div>
        <div>
            <button type="button" class="btn btn-primary btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'addPreppy')}'"><g:message code="student.mobile.create.preppy.title"/> </button>
            <g:set var="entityName" value="${message(code: 'preppy.label', default: 'Student')}" />
            <button type="button" class="btn btn-primary btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'editPreppy',id: preppyInstance.id)}'"><g:message code="default.edit.label" args="[entityName]"/> </button>
            <button type="button" class="btn btn-info btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'preppy',action: 'list')}'">${message(code: 'default.button.back.label')}<g:message code="default.list.label" args="[entityName]" /> </button>
            <button type="button" class="btn btn-default btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'createStu')}'">${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')} </button>
        </div>
    </div>
</div>
</body>
</html>
