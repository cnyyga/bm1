<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainReg">
		<g:set var="entityName" value="${message(code: 'reg.student.info.label', default: 'Student')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-cerulean.css')}" type="text/css">

		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}" type="text/css">
        <g:javascript src="jquery.validate.min.js"/>
		<g:javascript src="messages_zh.js"/>
		<g:javascript src="tj.js"/>
		<g:javascript src="app-preppy_stu.js"/>
	</head>
	<body>
    <div class="reg-content">
        <div class="reg-header">
            修改资料
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
			<g:form method="post"  action="savePreppy" name="preppyForm">

		        <g:render template="preppyForm"/>
					<g:submitButton name="subbtn" class="input-submit"  value="${message(code: 'default.button.update.label', default: 'Update')}" />
			</g:form>
		</div>
	</body>
</html>
