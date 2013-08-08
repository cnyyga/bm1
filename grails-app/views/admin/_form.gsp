<%@ page import="com.baoming.account.Admin" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="user.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${adminInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="username">
		<g:message code="user.username.label" default="Username" />
	</label>

    <div class="controls">
	<g:textField name="username" value="${adminInstance?.username}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="password">
		<g:message code="user.password.label" default="Password" />
	</label>

    <div class="controls">
	<g:textField name="password" value="${adminInstance?.password}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
	</label>

    <div class="controls">
	<g:checkBox name="enabled" value="${adminInstance?.enabled}" />
    </div>
</div>



