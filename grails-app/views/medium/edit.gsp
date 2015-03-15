<%@ page import="com.baoming.Medium" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'medium.label', default: 'Medium')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript src="jquery.validate.min.js"/>
        <g:javascript src="card.js"/>
        <g:javascript src="additional-methods.js"/>
        <g:javascript src="messages_zh.js"/>
        <g:javascript src="tj.js"/>
        <g:javascript src="medium.js"/>
        <style>
        .ui-combobox {
            position: relative;
            display: inline-block;
        }
        .ui-combobox-toggle {
            position: absolute;
            top: 0;
            bottom: 0;
            margin-left: -1px;
            padding: 0;
            /* adjust styles for IE 6/7 */
            *height: 1.7em;
            *top: 0.1em;
        }
        .ui-combobox-input {
            margin: 0;
            padding: 0.3em;
        }
        .ui-widget-content {
            text-align: left;
        }
        ul.ui-widget-content {
            height: 200px;
            overflow: auto;
        }
        .tab-content {
            overflow: visible;
        }
        </style>
	</head>
	<body>
        <div>
            <ul class="breadcrumb">
                <li>
                    <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
                </li>
                <li>
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                </li>
            </ul>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${mediumInstance}">
            <ul class="alert alert-error" >
                <g:eachError bean="${mediumInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-edit"></i> <g:message code="default.edit.label" args="[entityName]" /></h2>
                </div>
                <div class="box-content">
                    <g:uploadForm class="form-horizontal" action="update" name="editForm">
                    <g:hiddenField name="id" value="${mediumInstance?.id}" />
                    <g:hiddenField name="version" value="${mediumInstance?.version}" />
                    <fieldset>
                        <g:render template="form"/>
                        <div class="form-actions">

                    <button type="submit" class="btn btn-primary"><g:message code="default.button.update.label" /> </button>
                    <button type="reset" class="btn"><g:message code="default.button.reset.label" /> </button>
                        </div>
                    </fieldset>
                    </g:uploadForm>

                </div>
            </div><!--/span-->

        </div><!--/row-->

	</body>
</html>
