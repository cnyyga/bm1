
<%@ page import="com.baoming.StudentType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'studentType.label', default: 'StudentType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <a href="javascript:void 0">${entityName}</a>
            </li>
        </ul>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div>
         <g:link action="create"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
    </div>
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th><g:message code="default.orderValue.label" default="Order" /></th>

                        <th><g:message code="studentType.name.label" default="Name" /></th>

                        <th><g:message code="studentType.code.label" default="Code" /></th>

                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${studentTypeInstanceList}" status="i" var="studentTypeInstance">
                        <tr>

                            <td class="center">${studentTypeInstance.orderValue}</td>

                            <td class="center">${fieldValue(bean: studentTypeInstance, field: "name")}</td>

                            <td class="center">${fieldValue(bean: studentTypeInstance, field: "code")}</td>
                            
                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${studentTypeInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                    <g:link class="btn btn-info" action="edit" id="${studentTypeInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${studentTypeInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${studentTypeInstanceTotal}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
