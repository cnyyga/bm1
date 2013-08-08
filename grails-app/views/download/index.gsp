
<%@ page import="com.baoming.MiddleSchool" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'download.label', default: 'download')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
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
    <div>
        <g:link action="d" class="btn btn-info btn-setting"><g:message code="download.name.label"/> </g:link>
        <g:message code="download.date.label"/> ${download?.date?.format('yyyy-MM-dd')}
    </div>
<sec:ifAllGranted roles="ROLE_ADMIN">
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="download.upload.label"/><g:message code="download.file.label"/></h2>

            </div>
            <div class="box-content">
                      <div>
                      <g:uploadForm action="upload">
                           <input type="file" name="file"/>

                          <div class="form-actions">
                              <button type="submit" class="btn btn-primary">${message(code: 'download.upload.label')}</button>
                              <g:link action="records">${message(code: 'download.record.label')}</g:link>
                          </div>
                      </g:uploadForm>
                          <div class="alert alert-error">
                              <g:message code="download.alert.label"/>
                          </div>
                      </div>



            </div>
        </div><!--/span-->

    </div><!--/row-->
                  </sec:ifAllGranted>

		</div>
	</body>
</html>
