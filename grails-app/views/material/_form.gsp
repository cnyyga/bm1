<%@ page import="com.baoming.Material" %>



<div class="control-group">
	<label class="control-label" for="content">
		<g:message code="material.content.label" default="Content" />
	</label>

    <div class="controls">
	<g:textArea name="content" cols="40" rows="5" maxlength="1024" value="${materialInstance?.content}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="reviewStatus1">
		<g:message code="material.reviewStatus.label" default="Review Status" />
	</label>

    <div class="controls">
	<g:select multiple="" name="reviewStatus1" from="${com.baoming.Material$ReviewStatus?.values()}" optionValue="label" optionKey="id" required="" value="${materialInstance?.reviewStatus?.name()}"/>

    </div>
</div>

