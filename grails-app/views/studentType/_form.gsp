<%@ page import="com.baoming.StudentType" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="studentType.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${studentTypeInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="studentType.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${studentTypeInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="code">
        <g:message code="default.orderValue.label" default="Order" />
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${studentTypeInstance?.orderValue}"/>
    </div>
</div>


