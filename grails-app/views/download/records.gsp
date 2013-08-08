<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'download.record.label', default: 'record')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript src="district_select.js"/>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <g:link action="index">${message(code: 'download.label', default: 'download')}</g:link>
                <span class="divider">/</span>
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
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">

                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        
                        <th><g:message code="teacher.label" default="Teacher" /></th>
                        <th><g:message code="download.record.date.label" default="Date" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${downloadRecords}" status="i" var="dr">
                        <tr>
                            
                            <td class="center">${dr.teacher?.name}</td>
                            <td class="center">${dr.dateCreated?.format('yyyy-MM-dd HH:mm:ss')}</td>

                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${total}"/>
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

		</div>
	</body>
</html>
