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

<div class="control-group">
    <label class="control-label" for="code">
           使用范围
    </label>
    <g:set var="planUses" value="${(planInstance && planInstance.id)?com.baoming.PlanUse.findAllByPlan(planInstance):null}"/>
    <g:set var="planUses" value="${planUses?planUses*.flg:[]}"/>

    <div class="controls">
    <label  class="checkbox-inline"><g:message code="student.label"/> <input type="checkbox" name="flg" value="1" <g:if test="${planUses.count(1)>0}">checked="checked"</g:if> /> </label>
    <label  class="checkbox-inline"><g:message code="medium.label"/><input type="checkbox" name="flg" value="2" <g:if test="${planUses.count(2)>0}">checked="checked"</g:if> /></label>
    <label  class="checkbox-inline"><g:message code="preppy.label"/><input type="checkbox" name="flg" value="3" <g:if test="${planUses.count(3)>0}">checked="checked"</g:if> /></label>
   %{-- <div>
        <p class="red">旁听生</p>
    <g:each in="${(4..11)}" var="st">
            <label  class="checkbox-inline"><g:message code="studentType.${st}.label"/><input type="checkbox" name="flg" value="${st}" <g:if test="${planUses.count(st)>0}">checked="checked"</g:if> /> </label>
        </g:each>
    </div>--}%
    </div>
</div>


