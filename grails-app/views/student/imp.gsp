
<%@ page import="com.baoming.account.Role; com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'default.button.import.label', default: 'Student')}" />
		<title>${entityName}</title>
        <g:javascript src="student-imp.js"/>

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

    <div class="row-fluid sortable">
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> ${entityName}<g:message code="student.admission.label"/> </h2>
            </div>
            <div class="box-content ">
                <g:uploadForm class="form-horizontal" action="saveImp" name="admissionForm" >
                    <g:hiddenField name="type" value="1"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="docFile">
                                <g:message code="download.upload.label" default="Description" />
                            </label>
                            <div class="controls">
                                <input type="file" name="docFile" id="docFile" />
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary btn-stu-import">${message(code: 'default.button.import.label')}</button>
                        </div>
                    </fieldset>
                </g:uploadForm>
            </div>
        </div><!--/span-->
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> ${entityName}<g:message code="student.registration.label"/></h2>
            </div>
            <div class="box-content ">
                <g:uploadForm class="form-horizontal" action="saveImp" name="registrationForm" >
                    <g:hiddenField name="type" value="2"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="docFile1">
                                <g:message code="download.upload.label" default="Description" />
                            </label>
                            <div class="controls">
                                <input type="file" name="docFile" id="docFile1" />
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary btn-stu-import">${message(code: 'default.button.import.label')}</button>
                        </div>
                    </fieldset>
                </g:uploadForm>
            </div>
        </div><!--/span-->
    </div><!--/row-->

	</body>
</html>
