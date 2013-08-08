<%@ page import="com.baoming.PoliticalStatus" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="politicalStatus.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${politicalStatusInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="politicalStatus.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${politicalStatusInstance?.code}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="code">
        <g:message code="default.orderValue.label" default="Order" />
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${politicalStatusInstance?.orderValue}"/>
    </div>
</div>

