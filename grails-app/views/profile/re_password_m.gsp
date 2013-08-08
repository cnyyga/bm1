<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'operator.changepassword.label', default: 'changepassword')}" />
    <title>${entityName}</title>
</head>
<body>
<div>
    <ul class="breadcrumb">
        <li>
            <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
        </li>
        <li>
            <g:link class="list" action="rePassword">${entityName}</g:link>
        </li>
    </ul>
</div>
<g:if test="${flash.message}">
    <div class="alert alert-error">${flash.message}</div>
</g:if>

<div class="row-fluid sortable">
    <div class="box span12">
        <div class="box-header well" data-original-title>
            <h2><i class="icon-edit"></i>${entityName}</h2>
        </div>
        <div class="box-content">
            <g:form class="form-horizontal" action="saveRePassword" >

                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="password">
                            <g:message code="operator.password.label" default="password" />
                        </label>

                        <div class="controls">
                            <g:passwordField name="password"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password">
                            <g:message code="operator.passwordnew.label" default="password" />
                        </label>

                        <div class="controls">
                            <g:passwordField name="password_new"/>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="password">
                            <g:message code="operator.passwordnew2.label" default="password" />
                        </label>

                        <div class="controls">
                            <g:passwordField name="password_new2"/>
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">${message(code: 'default.button.update.label')}</button>
                        <button type="reset" class="btn">${message(code: 'default.button.reset.label')}</button>
                    </div>
                </fieldset>
            </g:form>

        </div>
    </div><!--/span-->

</div><!--/row-->

</body>
</html>
