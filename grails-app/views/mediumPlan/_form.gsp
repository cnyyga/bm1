<%@ page import="com.baoming.MediumPlan" %>



<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="mediumPlan.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${mediumPlanInstance?.code}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="name">
		<g:message code="mediumPlan.name.label" default="Name" />
	</label>

    <div class="controls">
	<g:textField name="name" value="${mediumPlanInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="orderValue">
		<g:message code="mediumPlan.orderValue.label" default="Order Value" />
	</label>

    <div class="controls">
	<g:field name="orderValue" type="number" value="${mediumPlanInstance.orderValue}" required=""/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="status">
		<g:message code="mediumPlan.status.label" default="Status" />
	</label>

    <div class="controls">
	<g:select name="status" from="${com.baoming.MediumPlan$Status?.values()}" optionValue="label" required="" value="${mediumPlanInstance?.status?.name()}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="status">
        <g:message code="plan.label" default="Status" />
    </label>

    <div class="controls">
        <g:set var="planIds" value="${mediumPlanInstance.plans?mediumPlanInstance.plans*.id:[]}"/>
         <g:each in="${plans}" var="plan">
             <label class="checkbox-inline">
                 <input type="checkbox" id="plan${plan.id}" name="plan" <g:if test="${planIds.count(plan.id) > 0}">checked="checked" </g:if> value="${plan.id}">${plan.name}
             </label>
         </g:each>
    </div>
</div>