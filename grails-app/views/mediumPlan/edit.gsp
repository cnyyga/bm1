<%@ page import="com.baoming.MediumPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediumPlan.label', default: 'MediumPlan')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
        <div>
            <ul class="breadcrumb">
                <li>
                    <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
                </li>
                <li>
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                </li>
            </ul>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${mediumPlanInstance}">
            <ul class="alert alert-error" >
                <g:eachError bean="${mediumPlanInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-edit"></i> <g:message code="default.edit.label" args="[entityName]" /></h2>
                </div>
                <div class="box-content">
                    <g:form class="form-horizontal" action="update" >
                    <g:hiddenField name="id" value="${mediumPlanInstance?.id}" />
                    <g:hiddenField name="version" value="${mediumPlanInstance?.version}" />
                    <fieldset>
                        <g:render template="form"/>
                        <div class="form-actions">

                    <button type="submit" class="btn btn-primary"><g:message code="default.button.update.label" /> </button>
                    <button type="reset" class="btn"><g:message code="default.button.reset.label" /> </button>
                        </div>
                    </fieldset>
                    </g:form>

                </div>
            </div><!--/span-->

        </div><!--/row-->

	</body>
</html>
