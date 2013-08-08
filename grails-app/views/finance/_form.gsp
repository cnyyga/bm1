<%@ page import="com.baoming.account.Finance" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="user.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${financeInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="username">
		<g:message code="user.username.label" default="Username" />
	</label>

    <div class="controls">
	<g:textField name="username" required="" value="${financeInstance?.username}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="password">
		<g:message code="user.password.label" default="Password" />
	</label>

    <div class="controls">
	<g:textField name="password" required="" value="${financeInstance?.password}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
	</label>

    <div class="controls">
	<g:checkBox name="enabled" value="${financeInstance?.enabled}" />
    </div>
</div>


