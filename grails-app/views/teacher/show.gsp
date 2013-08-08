
<%@ page import="com.baoming.account.Teacher" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teacher.label', default: 'Teacher')}" />
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

                    <g:if test="${teacherInstance?.name}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="user.name.label" default="Name" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${teacherInstance}" field="name"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${teacherInstance?.username}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.username.label" default="Username" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${teacherInstance}" field="username"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="city.label" default="City" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="dateCreated-label">
                               <g:set var="tds" value="${teacherInstance?.teacherDistricts}"/>
                                <g:each in="${tds}" var="td">
                                      ${td.district?.city?.name}${td.district?.name}
                                </g:each>
                               </span>

                        </div>
                    </div>
                    <g:if test="${teacherInstance?.dateCreated}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="Date Created" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${teacherInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss"/></span>
                            
                        </div>
                    </div>
                    </g:if>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="department.label" default="Department" />
                        </label>
                        <div class="controls">
                            <span class="property-value" aria-labelledby="department-label">${teacherInstance?.department?.name}</span>
                        </div>
                    </div>
                    
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.enabled.label" default="Enabled" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${teacherInstance?.enabled}" /></span>
                            
                        </div>
                    </div>


                    
                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${teacherInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${teacherInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                            <g:hiddenField name="act" value="1" />
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
