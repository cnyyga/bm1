
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
                <div class="form-horizontal">
                <fieldset>
                    
                    <g:if test="${mediumInstance?.name}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.name.label" default="Name" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${mediumInstance}" field="name"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.code}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.code.label" default="Code" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${mediumInstance}" field="code"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.number}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.number.label" default="Number" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${mediumInstance}" field="number"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.gender}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.gender.label" default="Gender" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="gender-label">${mediumInstance.gender?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.mediumPlan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.mediumPlan.label" default="Medium Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="mediumPlan-label">${mediumInstance?.mediumPlan?.name}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.plan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.plan.label" default="Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="plan-label">${mediumInstance?.plan?.name}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.teacher}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.teacher.label" default="Teacher" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="teacher-label">
                                ${mediumInstance?.teacher?.name}</span>
                            
                        </div>
                    </div>
                    </g:if>
                <g:if test="${mediumInstance?.district}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.district.label" default="District" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="district-label">${mediumInstance?.province?.name}${mediumInstance?.city?.name}${mediumInstance?.district?.name}</span>
                        </span>

                        </div>
                    </div>
                </g:if>

                <g:if test="${mediumInstance?.studentDistrict}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.studentDistrict.label" default="Student District" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="studentDistrict-label">
                                ${mediumInstance?.studentProvince?.name}${mediumInstance?.studentCity?.name} ${mediumInstance?.studentDistrict?.name}</span>

                        </div>
                    </div>
                </g:if>
                    <g:if test="${mediumInstance?.voucherPath}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.voucherPath.label" default="Voucher Path" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="voucherPath-label">
                                <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.voucherPath)}" style="height: 100px;"/>
                            </span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.admission}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.admission.label" default="Admission" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="admission-label">${mediumInstance.admission?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.registration}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.registration.label" default="Registration" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="registration-label">${mediumInstance.registration?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${mediumInstance?.reviewStatus}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.reviewStatus.label" default="Review Status" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="reviewStatus-label">${mediumInstance.reviewStatus?.label}</span>
                            
                        </div>
                    </div>
                    </g:if>
                    


                <g:if test="${mediumInstance?.reviewPerson}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.reviewPerson.label" default="Review Person" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="reviewPerson-label">
                                ${mediumInstance?.reviewPerson?.name}</span>

                        </div>
                    </div>
                </g:if>
                    <g:if test="${mediumInstance?.reviewDate}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.reviewDate.label" default="Review Date" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="reviewDate-label"><g:formatDate date="${mediumInstance?.reviewDate}" format="yyyy-MM-dd HH:mm:ss" /></span>
                            
                        </div>
                    </div>
                    </g:if>
                <g:if test="${mediumInstance?.description}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.description.label" default="Description" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${mediumInstance}" field="description"/></span>

                        </div>
                    </div>
                </g:if>


                <g:if test="${mediumInstance?.dateCreated}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="Date Created" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${mediumInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>

                        </div>
                    </div>
                </g:if>
<sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
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
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
