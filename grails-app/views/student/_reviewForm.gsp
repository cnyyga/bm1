<%@ page import="com.baoming.account.Student" %>
<sec:ifAnyGranted roles="${com.baoming.account.Role.AUTHORITY_ADMIN},${com.baoming.account.Role.AUTHORITY_FINANCE}">
    <div class="control-group">
    <label class="control-label" for="reviewStatus">
        <g:message code="student.review.status.label" default="account" />
    </label>
    <div class="controls">
        <g:select name="reviewStatus" from="${Student.ReviewStatus.values()}" value="${studentInstance?.reviewStatus}" optionValue="label"></g:select>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="reviewDescription">
        <g:message code="student.review.description.label" default="description" />
    </label>
    <div class="controls">
        <g:textArea name="reviewDescription" rows="5" cols="30" style="width: 400px;">${studentInstance?.reviewDescription}</g:textArea>
    </div>
</div>
</sec:ifAnyGranted>

