
<%@ page import="com.baoming.Plan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'plan.label', default: 'Plan')}" />
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

                    <g:if test="${planInstance?.name}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="plan.name.label" default="Name" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${planInstance}" field="name"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${planInstance?.code}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="plan.code.label" default="Code" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${planInstance}" field="code"/></span>
                            
                        </div>
                    </div>
                    </g:if>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="plan.score.label" default="score" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="code-label">${planInstance.score}</span>

                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="plan.status.label" default="Status" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="status-label">${planInstance.status.label}</span>
                            
                        </div>
                    </div>

                    <g:if test="${planInstance?.dateCreated}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="default.dateCreated.label" default="Date Created" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${planInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>

                            </div>
                        </div>
                    </g:if>
                    <g:if test="${planInstance?.description}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="plan.description.label" default="Description" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${planInstance}" field="description"/></span>

                            </div>
                        </div>
                    </g:if>

                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${planInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${planInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                                <g:hiddenField name="act" value="1" />
                        </g:form>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
