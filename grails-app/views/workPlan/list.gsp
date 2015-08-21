
<%@ page import="com.baoming.WorkPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlan.label', default: 'WorkPlan')}" />
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
         <g:link action="exp"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.button.export.label" /></g:link>
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
                        
                        <th><g:message code="workPlan.name.label" default="Name" /></th>
                        
                        <th><g:message code="workPlan.area.label" default="Area" /></th>
                        
                        <th><g:message code="workPlan.num.label" default="Num" /></th>
                        
                        <th><g:message code="workPlan.date.label" default="Start Date" /></th>

                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${workPlanInstanceList}" status="i" var="workPlanInstance">
                        <tr>
                            
                            <td class="center"><g:link action="show" id="${workPlanInstance.id}">${fieldValue(bean: workPlanInstance, field: "name")}</g:link> </td>
                            
                            <td class="center">${fieldValue(bean: workPlanInstance, field: "area")}</td>
                            
                            <td class="center">${fieldValue(bean: workPlanInstance, field: "num")}</td>
                            
                            <td class="center"><g:formatDate date="${workPlanInstance.startDate}" format="yyyy-MM-dd"  />至<g:formatDate date="${workPlanInstance.endDate}"  format="yyyy-MM-dd"  /></td>

                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${workPlanInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                    <g:link class="btn btn-info" action="edit" id="${workPlanInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${workPlanInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${workPlanInstanceTotal}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
