<%@ page import="com.baoming.Plan" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="plan.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${planInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="plan.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${planInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="score">
        <g:message code="plan.score.label" default="score" />
    </label>

    <div class="controls">
        <g:textField name="score" value="${planInstance?.score}"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="status">
        <g:message code="plan.status.label" default="Status" />
    </label>

    <div class="controls">
        <g:select name="status" from="${com.baoming.Plan$Status?.values()}" optionValue="label"
                  value="${(!planInstance?.id)?(com.baoming.Plan.Status.RUNNING):(planInstance?.status?.name())}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="description">
		<g:message code="plan.description.label" default="Description" />
	</label>

    <div class="controls">
	<g:textField name="description" value="${planInstance?.description}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="code">
        <g:message code="default.orderValue.label" default="Order" />
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${planInstance?.orderValue}"/>
    </div>
</div>


