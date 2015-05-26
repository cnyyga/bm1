
<%@ page import="com.baoming.WorkPlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'workPlan.label', default: 'WorkPlan')}" />
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
                    
                    <g:if test="${workPlanInstance?.name}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.name.label" default="Name" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${workPlanInstance}" field="name"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.area}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.area.label" default="Area" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="area-label"><g:fieldValue bean="${workPlanInstance}" field="area"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.num}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.num.label" default="Num" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="num-label"><g:fieldValue bean="${workPlanInstance}" field="num"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.date.label" default="Start Date" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${workPlanInstance?.startDate}" format="yyyy-MM-dd" />-
                            <g:formatDate date="${workPlanInstance?.endDate}" format="yyyy-MM-dd" /></span>
                        </div>
                    </div>

                    
                    <g:if test="${workPlanInstance?.middleSchools}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.middleSchools.label" default="Middle Schools" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="middleSchools-label"><g:fieldValue bean="${workPlanInstance}" field="middleSchools"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.tel}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.tel.label" default="Tel" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${workPlanInstance}" field="tel"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.result}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.result.label" default="Result" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="result-label"><g:fieldValue bean="${workPlanInstance}" field="result"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.opinion}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.opinion.label" default="Opinion" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="opinion-label"><g:fieldValue bean="${workPlanInstance}" field="opinion"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.materialObject}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.materialObject.label" default="Material Object" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="materialObject-label"><g:fieldValue bean="${workPlanInstance}" field="materialObject"/></span>
                            
                        </div>
                    </div>
                    </g:if>

                    <g:if test="${workPlanInstance?.materialNum}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="workPlan.materialNum.label" default="Material Num" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="materialNum-label"><g:fieldValue bean="${workPlanInstance}" field="materialNum"/></span>

                            </div>
                        </div>
                    </g:if>
                    <g:if test="${workPlanInstance?.materialTel}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.materialTel.label" default="Material Tel" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="materialTel-label"><g:fieldValue bean="${workPlanInstance}" field="materialTel"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.questions}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.questions.label" default="Questions" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="questions-label"><g:fieldValue bean="${workPlanInstance}" field="questions"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.hasOpinion}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.hasOpinion.label" default="Has Opinion" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="hasOpinion-label"><g:fieldValue bean="${workPlanInstance}" field="hasOpinion"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.pic}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.pic.label" default="Pic" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="pic-label"><g:fieldValue bean="${workPlanInstance}" field="pic"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.carFare}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.carFare.label" default="Car Fare" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="carFare-label"><g:fieldValue bean="${workPlanInstance}" field="carFare"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.cityCarFare}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.cityCarFare.label" default="City Car Fare" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="cityCarFare-label"><g:fieldValue bean="${workPlanInstance}" field="cityCarFare"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.accommodation}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.accommodation.label" default="Accommodation" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="accommodation-label"><g:fieldValue bean="${workPlanInstance}" field="accommodation"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.entertainment}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.entertainment.label" default="Entertainment" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="entertainment-label"><g:fieldValue bean="${workPlanInstance}" field="entertainment"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.amount}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.amount.label" default="Amount" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${workPlanInstance}" field="amount"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.attendSeminar}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.attendSeminar.label" default="Attend Seminar" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="attendSeminar-label"><g:fieldValue bean="${workPlanInstance}" field="attendSeminar"/></span>
                            
                        </div>
                    </div>
                    </g:if>
                    
                    <g:if test="${workPlanInstance?.workPlan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="workPlan.workPlan.label" default="Work Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="workPlan-label"><g:fieldValue bean="${workPlanInstance}" field="workPlan"/></span>
                            
                        </div>
                    </div>
                    </g:if>



                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${workPlanInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${workPlanInstance?.id}">
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
