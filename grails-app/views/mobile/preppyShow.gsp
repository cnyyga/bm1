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
                <span class="required-indicator">*</span>
            </label>

            <div class="controls">
                ${preppyInstance?.name}
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="name">
                <g:message code="preppy.number.label" default="Name" />
                <span class="required-indicator">*</span>
            </label>

            <div class="controls">
                ${preppyInstance?.number}
            </div>
        </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.family.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.province?.name}
                        ${preppyInstance?.city?.name}
                        ${preppyInstance?.district?.name}
                        ${preppyInstance?.town}
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.gender.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.gender?.label}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.depositType.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.depositType?.label}
                    </div>
                </div>

                <div class="control-group">
            <label class="control-label" for="name">
                <g:message code="preppy.deposit.label" default="Name" />
                <span class="required-indicator">*</span>
            </label>

            <div class="controls">
                ${preppyInstance?.deposit}元
            </div>
        </div>
                </fieldset></div>
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
