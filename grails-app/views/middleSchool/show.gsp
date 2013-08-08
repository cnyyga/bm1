
<%@ page import="com.baoming.account.Role; com.baoming.MiddleSchool" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'middleSchool.label', default: 'MiddleSchool')}" />
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
                    
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="middleSchool.city.label" default="City" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="city-label">${middleSchoolInstance?.district?.city?.province?.name} ${middleSchoolInstance?.district?.city?.name} ${middleSchoolInstance?.district?.name}</span>
                            
                        </div>
                    </div>
                    <g:if test="${middleSchoolInstance?.name}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="middleSchool.name.label" default="Name" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${middleSchoolInstance}" field="name"/></span>

                            </div>
                        </div>
                    </g:if>
                    <g:if test="${middleSchoolInstance?.code}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="middleSchool.code.label" default="Code" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${middleSchoolInstance}" field="code"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${middleSchoolInstance?.contact}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="middleSchool.contact.label" default="Contact" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="contact-label"><g:fieldValue bean="${middleSchoolInstance}" field="contact"/></span>
                            
                        </div>
                    </div>
                    </g:if>

                    <g:if test="${middleSchoolInstance?.tel}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="middleSchool.tel.label" default="Tel" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${middleSchoolInstance}" field="tel"/></span>

                            </div>
                        </div>
                    </g:if>
                    <g:if test="${middleSchoolInstance?.description}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="middleSchool.description.label" default="Description" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${middleSchoolInstance}" field="description"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${middleSchoolInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${middleSchoolInstance?.id}">
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
