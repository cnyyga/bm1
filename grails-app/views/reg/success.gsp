<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainReg">
		<g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<div class="reg-content">
            <div class="reg-header">
                报名成功
            </div>

                <div class="info-success">
                    <h3>恭喜您，注册成功！</h3>
                    <p><g:link action="index" controller="reg">重新注册</g:link></p>
                </div>

		</div>
	</body>
</html>