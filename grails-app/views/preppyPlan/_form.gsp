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

