<%@ page import="com.baoming.Plan" %>
<div class="control-group">
    <label class="control-label" for="studentType.id">
        <g:message code="studentType.label" default="StudentType" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select from="${com.baoming.StudentType.list()}" name="studentType.id" optionKey="id" optionValue="name" value="${studentInstance?.studentType?.id}" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="score">
        <g:message code="student.score.label" default="Score" />
    </label>
    <div class="controls">
        <g:textField name="score" value="${studentInstance?.score}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="level">
        <g:message code="student.level.label" default="level" />
    </label>
    <div class="controls">
        <g:textField name="level" value="${studentInstance?.level}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="artsScore">
        <g:message code="student.artsScore.label" default="artsScore" />
    </label>
    <div class="controls">
        <g:textField name="artsScore" value="${studentInstance?.artsScore}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="artsScore">
        <g:message code="student.sportsScore.label" default="sportsScore" />
    </label>
    <div class="controls">
        <g:textField name="sportsScore" value="${studentInstance?.sportsScore}"/>
    </div>
</div>
<g:if test ="${studentInstance && studentInstance?.id}">
    <g:set var="sps" value="${studentInstance?.plans?.collect{it?.id}}"/>
</g:if>
<g:else>
    <g:set var="sps" value="${planIds}"/>
</g:else>
<div class="control-group">
	<label class="control-label" for="planId">
		<g:message code="student.plans.label" default="Student Plans" />1
	</label>
    <div class="controls">
        <g:select name="planId" id="planId"  value="${(sps && sps[0])?sps[0]:''}" noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="planId2">
        <g:message code="student.plans.label" default="Student Plans" />2
    </label>
    <div class="controls">
        <g:select name="planId" id="planId2"  value="${(sps && sps[1])?sps[1]:''}" noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="planId3">
        <g:message code="student.plans.label" default="Student Plans" />3
    </label>
    <div class="controls">
        <g:select name="planId" id="planId3"  value="${(sps && sps[2])?sps[2]:''}" noSelection="${['':'请选择']}" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" optionValue="name" optionKey="id" />
    </div>
</div>
