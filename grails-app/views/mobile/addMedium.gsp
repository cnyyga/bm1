<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.create.medium.title"/></title>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="tj.js"/>
    <g:javascript src="medium.js"/>
    <style>
        .select-body{
            background:none;
            border:0;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.mobile.create.medium.title"/></h2>
</div>

<div class="page-content gradient" >
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div class="page-body select-body">
        <g:uploadForm  action="save" controller="medium" name="editForm" >

            <g:render template="/medium/form"/>

            <div>
                <button type="submit" class="btn btn-primary btn-lg btn-block">${message(code: 'default.button.update.label')}</button>
                <g:set var="entityName" value="${message(code: 'medium.label', default: 'Student')}" />
                <button type="button" class="btn btn-info btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'medium',action: 'list')}'">${message(code: 'default.button.back.label')}<g:message code="default.list.label" args="[entityName]" /> </button>
                <button type="button" class="btn btn-default btn-lg btn-block" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'createStu')}'">${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')} </button>

            </div>
         </g:uploadForm>
    </div>
</div>
</body>
</html>
