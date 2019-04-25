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
