
<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
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


                    <g:if test="${preppyInstance?.name}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.name.label" default="Name" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${preppyInstance}" field="name"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.number}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.number.label" default="Number" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${preppyInstance}" field="number"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.gender}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.gender.label" default="Gender" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="gender-label">${preppyInstance?.gender?.label}</span>

                            </div>
                        </div>
                    </g:if>
                    
                    <g:if test="${preppyInstance?.plan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.plan.label" default="Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="plan-label"><g:link controller="plan" action="show" id="${preppyInstance?.plan?.id}">${preppyInstance?.plan?.name}</g:link></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${preppyInstance?.collegeType}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.collegeType.label" default="College Type" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="collegeType-label">${preppyInstance?.collegeType?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${preppyInstance?.family}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.family.label" default="Family" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="family-label">${preppyInstance?.family?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>

                    
                    <g:if test="${preppyInstance?.middlePlan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.middlePlan.label" default="Middle Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="middlePlan-label"><g:fieldValue bean="${preppyInstance}" field="middlePlan"/></span>
                            
                        </div>
                    </div>
                    </g:if>


                    <g:if test="${preppyInstance?.status}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.status.label" default="Status" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="status-label">${preppyInstance?.status?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>


                    <g:if test="${preppyInstance?.phone}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.phone.label" default="Phone" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${preppyInstance}" field="phone"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.qq}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.qq.label" default="Qq" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="qq-label"><g:fieldValue bean="${preppyInstance}" field="qq"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.tel}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.tel.label" default="Tel" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${preppyInstance}" field="tel"/></span>

                            </div>
                        </div>
                    </g:if>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <%
                            def ttt
                            try {
                                ttt = preppyInstance?.teacher
                            } catch (Exception e) {

                            }
                            %>
                    <g:if test="${ttt}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.teacher.label" default="Teacher" />
                            </label>
                            <div class="controls">
                                <span class="property-value" aria-labelledby="teacher-label"><g:link controller="teacher" action="show" id="${ttt?.id}">${ttt?.name}</g:link></span>
                            </div>
                        </div>
                    </g:if>
                        </sec:ifAllGranted>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="dateCreated" />
                        </label>
                        <div class="controls">
                            <span class="property-value" aria-labelledby="teacher-label"><g:formatDate
                                    date="${preppyInstance?.dateCreated}" format="yyyy-MM-dd HH:mm"/></span>
                        </div>
                    </div>

                    <div class="form-actions">
                        <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                        <g:form>
                                <g:hiddenField name="id" value="${preppyInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${preppyInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                            <g:hiddenField name="act" value="1" />
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                            </sec:ifNotGranted>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
