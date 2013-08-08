<%@ page import="com.baoming.Nation" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="nation.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${nationInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="nation.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${nationInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="code">
        <g:message code="default.orderValue.label" default="Order" />
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${nationInstance?.orderValue}"/>
    </div>
</div>


