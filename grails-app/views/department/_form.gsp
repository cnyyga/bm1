<%@ page import="com.baoming.Department" %>



<div class="control-group">
    <label class="control-label" for="code">
        <g:message code="department.code.label" default="Code"/>
    </label>

    <div class="controls">
        <g:textField name="code" value="${departmentInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="department.name.label" default="Name"/>
    </label>

    <div class="controls">
        <g:textField name="name" value="${departmentInstance?.name}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="department.orderValue.label" default="Order"/>
    </label>

    <div class="controls">
        <g:textField name="orderValue" value="${departmentInstance?.orderValue?:0}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="department.taskNumber.label" default="taskNumber"/>
    </label>

    <div class="controls">
        <g:textField name="taskNumber" value="${departmentInstance?.taskNumber?:0}"/>
    </div>
</div>

