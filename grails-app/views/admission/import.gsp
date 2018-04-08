<%@ page import="com.baoming.Admission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'admission.label', default: 'Admission')}" />
		<title><g:message code="default.button.import.label" /></title>
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
    <g:hasErrors bean="${admissionInstance}">
        <ul class="alert alert-error" >
            <g:eachError bean="${admissionInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>

        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-edit"></i> <g:message code="default.button.import.label" /></h2>
                </div>
                <div class="box-content">
                    <g:uploadForm class="form-horizontal" action="saveImport" >

                    <fieldset>
                        <input type="file" name="file"/>
                            <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><g:message code="default.button.confirm.label" /> </button>
                            </div>
                        </fieldset>
                    </g:uploadForm>
                    <p class="alert-danger">请选择Excel格式文件，目前只支持97-2003以xls结尾</p>
                </div>
            </div><!--/span-->

        </div><!--/row-->

	</body>
</html>
