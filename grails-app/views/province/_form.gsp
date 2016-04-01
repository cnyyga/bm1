<g:hiddenField name="code" value="${instance?.code}"/>
<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="province.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${instance?.name}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="number">
        <g:message code="province.code.label" default="Code" />
    </label>

    <div class="controls">
        <g:textField name="number" value="${instance?.number?:instance?.code}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="orderValue">
        <g:message code="default.orderValue.label" default="Order" />
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${instance?.orderValue?:0}" />
    </div>
</div>
<g:if test="${!params.t || params.t == 'province'}">

<div class="control-group">
    <label class="control-label" for="status">
        <g:message code="mediumPlan.status.label" default="Status" />
    </label>
    <div class="controls">
        <g:select name="status" from="${com.baoming.Province.Status?.values()}" optionValue="label" required="" value="${instance?.status?.name()}"/>
    </div>
</div>
</g:if>