<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainStudent">
    <g:set var="entityName" value="${message(code: 'student.plans.label', default: 'Student')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="baoming.js"/>
</head>
<body>
<div class="reg-content">
    <div class="reg-header">
        <g:message code="default.edit.label" args="[entityName]" />
    </div>
    <g:if test="${flash.message}">
        <div class="info-result">
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${studentInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${studentInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form method="post"  action="update" name="regForm" params="${[v:params.v]}">
        <g:render template="select"/>
        <g:submitButton name="subbtn" class="input-submit"  value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </g:form>
</div>
</body>
</html>
