
<%@ page import="com.baoming.account.Role; com.baoming.Medium" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'medium.label', default: 'Medium')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style type="text/css">
        span.property-value{
            display: block;
            padding-top: 5px;
        }
        </style>
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

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> <g:message code="default.show.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <g:render template="show"/>
                <div>
                <sec:ifNotGranted roles="${com.baoming.account.Role.AUTHORITY_FINANCE}">
                    <div class="form-actions">
                        <g:form>
                            <g:hiddenField name="id" value="${mediumInstance?.id}" />
                            <g:link class="btn btn-info" action="edit" id="${mediumInstance?.id}">
                                <i class="icon-edit icon-white"></i>
                                <g:message code="default.button.edit.label" default="Edit" />
                            </g:link>
                            <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </div>
                </sec:ifNotGranted>
            </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
