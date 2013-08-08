<div class="form-horizontal">
    <fieldset>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.review.status.label" default="status" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.reviewStatus?.label}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.review.user.label" default="user" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.reviewPerson?.username}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.review.date.label" default="date" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.reviewDate?.format('yyyy-MM-dd HH:mm:ss')}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.review.description.label" default="description" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.reviewDescription}
        </span>
    </div>
</div>
    </fieldset></div>
               