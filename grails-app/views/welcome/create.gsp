<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'welcome.label', default: 'Welcome')}" />
    <title>${entityName}</title>
</head>
<body>
<div>
    <ul class="breadcrumb">
        <li>
            <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
        </li>
        <li>
            <a href="javascript:void 0">${entityName}</a>
        </li>
    </ul>
</div>
<g:if test="${flash.message}">
    <div class="alert alert-error">${flash.message}</div>
</g:if>
<g:hasErrors bean="${studentInstance}">
    <ul class="alert alert-error" >
        <g:eachError bean="${studentInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
    </ul>
</g:hasErrors>

<div class="row-fluid sortable">
    <div class="box span12">
        <div class="box-header well" data-original-title>
            <h2><i class="icon-edit"></i> ${entityName}</h2>
        </div>
        <div class="box-content">
            <g:form class="form-horizontal" action="save" name="editForm" >
                <fieldset>
                    <div class="control-group">
                        <div class="controls">
                            <textarea class="cleditor" id="content" name="content" rows="3" >${welcomeInstance?.content}</textarea>
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">${message(code: 'default.button.update.label')}</button>
                    </div>
                </fieldset>
            </g:form>

        </div>
    </div><!--/span-->

</div><!--/row-->

</body>
</html>
