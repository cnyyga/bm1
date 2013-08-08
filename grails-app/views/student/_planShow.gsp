<div class="form-horizontal">
    <fieldset>
<div class="control-group">
    <label class="control-label">
        <g:message code="studentType.label" default="StudentType" />
    </label>
    <div class="controls">
        <span class="property-value" aria-labelledby="middleSchool-label">
            ${studentInstance?.studentType?.name}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label" >
        <g:message code="student.score.label" default="Score" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.score}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label" >
        <g:message code="student.level.label" default="level" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.level}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.artsScore.label" default="artsScore" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.artsScore}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.sportsScore.label" default="sportsScore" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.sportsScore}
        </span>
    </div>
</div>

<g:each in="${studentInstance.plans}" var="plan" status="i">
    <div class="control-group">
        <label class="control-label">
            <g:message code="student.plans.label" default="Student Plans" />${i+1}
        </label>
        <div class="controls">
            <span class="property-value">
                ${plan.name}
            </span>
        </div>
    </div>
</g:each>

    </fieldset></div>