<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>

		<g:set var="entityName" value="${message(code: 'reg.student.info.label', default: 'Student')}" />
		<title>旁听生信息采集</title>
		<g:javascript src="jquery-1.8.3.js"/>
        <g:javascript src="jquery.validate.min.js"/>
		<g:javascript src="card.js"/>
		<g:javascript src="additional-methods.js"/>
		<g:javascript src="messages_zh.js"/>
		<g:javascript src="app-preppy_stu.js"/>
		<style>
	.sel_gray1 {font-size:14px; font-family:"微软雅黑";}
	.sel_gray1 {font-size:14px; font-family:"微软雅黑";}
	.tianxie{ font-family:"微软雅黑"; font-size:18px;  }
	.tianxie td{ border-bottom:1px dashed #cccccc; padding:3px 0;}
	.inp_gray{ font-size:14px; color:#000000; border:#d1d1d1 1px solid; height:24px;  font-family:"微软雅黑";  }
	.sel_gray{ font-size:14px; font-family:"微软雅黑";}

	label.error {
		color: red;
		font-weight: bold;
		margin-top: 2px;
		padding: 2px 8px;
	}

	.alert {
		padding: 8px 35px 8px 14px;
		margin-bottom: 18px;
		text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
		background-color: #8bc5e8;
		border: 1px solid #7ed0e5;
		-webkit-border-radius: 4px;
		-moz-border-radius: 4px;
		border-radius: 4px;
		color: #1c628b;
	}
	.alert-error {
		background-color: #eddbe3;
		border-color: #e8d1df;
		color: #bd4247;
	}
	</style>
		<script>
			$(function(){
				$(".lstx input").attr("disabled",true);
				$(".lstx select").attr("disabled",true);
				$(".zbsh input").attr("disabled",true);
				$(".zbsh select").attr("disabled",true);
			})
		</script>
	</head>
	<body>
		<sec:ifAllGranted roles='ROLE_STUDENT'>
			<div style="text-align: right;padding-left: 5px;font-size: 12px;">
				<g:link action="rePassword" controller="profile">修改密码</g:link>
				<g:link controller="logout">退出</g:link>
			</div>
		</sec:ifAllGranted>

	<g:if test="${flash.message}">
		<div class="alert alert-error">${flash.message}</div>
	</g:if>
	<g:hasErrors bean="${preppyInstance}">
		<ul class="alert alert-error" >
			<g:eachError bean="${preppyInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
			</g:eachError>
		</ul>
	</g:hasErrors>
			<g:form method="post"  action="savePreppy" name="preppyForm">
		        <g:render template="/preppy/form"/>
				<div style="text-align: center;margin: 10px auto;">
				<g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
				<g:submitButton name="subbtn" class="input-submit"  value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</g:if>
				<button onclick="javascript:history.back()"type="button" >返回</button>
				</div>
			</g:form>
	</body>
</html>
