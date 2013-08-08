<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${label}" />
		<title><g:message code="default.rank.label" args="[entityName]" /></title>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <a href="javascript:void 0"><g:message code="default.rank.label" args="[entityName]" /></a>
            </li>
        </ul>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.rank.label" args="[entityName]" /></h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'export',params: [t:params.t])}" class=" btn-mini">
                        <g:message code="default.button.export.label"/>
                    </a>
                </div>
            </div>
            <div class="box-content">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th style="width: 30px;"><g:message code="home.more.number.label" default="Number" /></th>
                        <th><g:message code="plan.name.label" default="name" /></th>
                        <th><g:message code="default.count.label"  args="[message(code:'student.label')]" default="name" /></th>

                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${objs}" status="i" var="obj">
                        <tr>
                            <td class="center">${(params.offset?params.int('offset'):0)+i+1}</td>
                            <td class="center">
                                <g:if test="${params.t == 'district'}">
                                    ${obj.cityName} ${obj.name}
                                </g:if>
                                <g:else>
                                    ${obj.name}
                                </g:else>
                                </td>
                            <td class="center">${obj.cc}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${total}" params="${params}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
