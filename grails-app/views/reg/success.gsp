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
                    <h3>恭喜您，注册成功！请尽快登陆完善您的信息！</h3>
                    <p><g:link action="index" controller="login">跳转到登录页面</g:link></p>
                </div>

		</div>
	</body>
</html>