<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="default.list.label" args="[entityName]" /></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body page-list">
        <div style="padding-bottom: 5px;">
            <g:link action="addStu" controller="mobile"  class="btn btn-primary btn-lg">
                <g:message code="default.new.label" args="[entityName]" />
            </g:link>
            <g:link action="createStu" controller="mobile" class="btn btn-lg">
                ${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')}
            </g:link>
        </div>
        <g:each in="${studentInstanceList}" status="i" var="studentInstance">
            <div class="list-group">
                <a href="${createLink(action: 'show',controller: 'student',id: studentInstance.id)}" class="list-group-item">
                    <h4 class="list-group-item-heading">${fieldValue(bean: studentInstance, field: "name")}</h4>
                    <p class="list-group-item-text">${studentInstance.number}</p>
                </a>
            </div>
        </g:each>

        <div class="pagination pagination-centered">
            <g:paginate total="${studentInstanceTotal}" params="${params}" />
        </div>
    </div>
</div>
</body>
</html>
