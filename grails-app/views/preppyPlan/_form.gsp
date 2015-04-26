<%@ page import="com.baoming.PreppyPlan" %>



<div class="control-group">
	<label class="control-label" for="name">
		<g:message code="preppyPlan.name.label" default="Name" />
	</label>

    <div class="controls">
	<g:textField name="name" value="${preppyPlanInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="status">
		<g:message code="preppyPlan.status.label" default="Status" />
	</label>

    <div class="controls">
	<g:select name="status" from="${com.baoming.PreppyPlan$Status?.values()}" optionValue="label" required="" value="${preppyPlanInstance?.status?.name()}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="status">
        <g:message code="plan.label" default="Status" />
    </label>

    <div class="controls">
        <g:set var="planIds" value="${preppyPlanInstance.plans?preppyPlanInstance.plans*.id:[]}"/>
        <g:each in="${plans}" var="plan">
            <label class="checkbox-inline">
                <input type="checkbox" id="plan${plan.id}" name="plan" <g:if test="${planIds.count(plan.id) > 0}">checked="checked" </g:if> value="${plan.id}">${plan.name}
            </label>
        </g:each>
    </div>
</div>
