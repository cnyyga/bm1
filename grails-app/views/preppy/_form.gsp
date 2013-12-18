<%@ page import="com.baoming.Preppy" %>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="preppy.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${preppyInstance?.name}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="number">
        <g:message code="preppy.number.label" default="Number" />
    </label>

    <div class="controls">
        <g:textField name="number" value="${preppyInstance?.number}"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="gender">
        <g:message code="preppy.gender.label" default="Gender" />
    </label>

    <div class="controls">
        <g:select name="gender" from="${com.baoming.account.User$Gender?.values()}" keys="${com.baoming.account.User$Gender.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.gender?.name()}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="plan">
		<g:message code="preppy.plan.label" default="Plan" />
	</label>

    <div class="controls">
	<g:select id="plan" name="plan.id" from="${com.baoming.Plan.list()}" optionKey="id" optionValue="name" value="${preppyInstance?.plan?.id}" class="many-to-one" noSelection="['': '请选择']"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="collegeType">
		<g:message code="preppy.collegeType.label" default="College Type" />
	</label>

    <div class="controls">
	<g:select name="collegeType" from="${com.baoming.Preppy$CollegeType?.values()}" keys="${com.baoming.Preppy$CollegeType.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.collegeType?.name()}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="family">
		<g:message code="preppy.family.label" default="Family" />
	</label>

    <div class="controls">
	<g:select name="family" from="${com.baoming.Preppy$Family?.values()}" keys="${com.baoming.Preppy$Family.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.family?.name()}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="middlePlan">
		<g:message code="preppy.middlePlan.label" default="Middle Plan" />
	</label>

    <div class="controls">
	<g:textField name="middlePlan" value="${preppyInstance?.middlePlan}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="phone">
		<g:message code="preppy.phone.label" default="Phone" />
	</label>

    <div class="controls">
	<g:textField name="phone" value="${preppyInstance?.phone}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="qq">
        <g:message code="preppy.qq.label" default="Qq" />
    </label>

    <div class="controls">
        <g:textField name="qq" value="${preppyInstance?.qq}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="tel">
        <g:message code="preppy.tel.label" default="Tel" />
    </label>

    <div class="controls">
        <g:textField name="tel" value="${preppyInstance?.tel}"/>
    </div>
</div>
<div class="control-group">
	<label class="control-label" for="status">
		<g:message code="preppy.status.label" default="Status" />
	</label>

    <div class="controls">
	<g:select name="status" from="${com.baoming.Preppy$Status?.values()}" keys="${com.baoming.Preppy$Status.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.status?.name()}"/>
    </div>
</div>
<sec:ifAllGranted roles="ROLE_ADMIN">
<div class="control-group">
	<label class="control-label" for="teacher">
		<g:message code="preppy.teacher.label" default="Teacher" />
	</label>

    <div class="controls">
	<g:select id="teacher" name="teacher.id" from="${com.baoming.account.Teacher.list()}" optionKey="id" optionValue="name" required="" value="${preppyInstance?.teacher?.id}" class="many-to-one"/>
    </div>
</div>
</sec:ifAllGranted>

