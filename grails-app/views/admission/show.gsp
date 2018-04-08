
<%@ page import="com.baoming.Admission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'admission.label', default: 'Admission')}" />
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
                    
                    <g:if test="${admissionInstance?.idNo}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.idNo.label" default="Id No" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="idNo-label"><g:fieldValue bean="${admissionInstance}" field="idNo"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.name}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.name.label" default="Name" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${admissionInstance}" field="name"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.sex}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.sex.label" default="Sex" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="sex-label"><g:fieldValue bean="${admissionInstance}" field="sex"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.ksh}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.ksh.label" default="Ksh" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="ksh-label"><g:fieldValue bean="${admissionInstance}" field="ksh"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.bkzy}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.bkzy.label" default="Bkzy" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="bkzy-label"><g:fieldValue bean="${admissionInstance}" field="bkzy"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.jtdz}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.jtdz.label" default="Jtdz" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="jtdz-label"><g:fieldValue bean="${admissionInstance}" field="jtdz"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.lxdh}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.lxdh.label" default="Lxdh" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="lxdh-label"><g:fieldValue bean="${admissionInstance}" field="lxdh"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.kd}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.kd.label" default="Kd" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="kd-label"><g:fieldValue bean="${admissionInstance}" field="kd"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.kddh}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.kddh.label" default="Kddh" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="kddh-label"><g:fieldValue bean="${admissionInstance}" field="kddh"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.bz}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="admission.bz.label" default="Bz" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="bz-label"><g:fieldValue bean="${admissionInstance}" field="bz"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.dateCreated}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="Date Created" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${admissionInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${admissionInstance?.lastUpdated}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.lastUpdated.label" default="Last Updated" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${admissionInstance?.lastUpdated}" format="yyyy-MM-dd HH:mm:ss" /></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${admissionInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${admissionInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
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
