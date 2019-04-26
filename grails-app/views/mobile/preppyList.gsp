<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <g:set var="entityName" value="${message(code: 'preppy.label', default: 'Student')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="default.list.label" args="[entityName]" /></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body page-list">
        <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
        </g:if>
        <div style="padding-bottom: 5px;">
            <g:link action="addPreppy" controller="mobile"  class="btn btn-primary btn-lg">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
            <g:link action="createStu" controller="mobile" class="btn btn-lg">
                ${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')}
            </g:link>
        </div>
        <g:each in="${preppyInstanceList}" status="i" var="preppyInstance">
            <div class="list-group">
                <a href="${createLink(action: 'show',controller: 'preppy',id: preppyInstance.id)}" class="list-group-item">
                    <h4 class="list-group-item-heading">${fieldValue(bean: preppyInstance, field: "name")}</h4>
                    <p class="list-group-item-text">${preppyInstance.number}</p>
                </a>
            </div>
        </g:each>

        <div class="pagination pagination-centered">
            <g:paginate total="${preppyInstanceTotal}"/>
        </div>
    </div>
</div>
</body>
</html>
