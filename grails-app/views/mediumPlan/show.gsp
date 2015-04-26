
<%@ page import="com.baoming.MediumPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'mediumPlan.label', default: 'MediumPlan')}" />
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
                <div class="form-horizontal">
                <fieldset>
                    
                    <g:if test="${mediumPlanInstance?.code}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="mediumPlan.code.label" default="Code" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${mediumPlanInstance}" field="code"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                   %{-- <g:if test="${mediumPlanInstance?.dateCreated}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="mediumPlan.dateCreated.label" default="Date Created" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${mediumPlanInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>
                            
                        </div>
                    </div>
                    </g:if>--}%
                    
                    <g:if test="${mediumPlanInstance?.name}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="mediumPlan.name.label" default="Name" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${mediumPlanInstance}" field="name"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                %{--    <g:if test="${mediumPlanInstance?.orderValue}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="mediumPlan.orderValue.label" default="Order Value" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="orderValue-label"><g:fieldValue bean="${mediumPlanInstance}" field="orderValue"/></span>
                            
                        </div>
                    </div>
                    </g:if>--}%
                    
                    <g:if test="${mediumPlanInstance?.status}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="mediumPlan.status.label" default="Status" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="status-label">${mediumPlanInstance.status?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="plan.label" default="Status" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="status-label">${mediumPlanInstance.plans?mediumPlanInstance.plans*.name.join(','):''}</span>

                        </div>
                    </div>
                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${mediumPlanInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${mediumPlanInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
%{--
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
--}%
                        </g:form>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
