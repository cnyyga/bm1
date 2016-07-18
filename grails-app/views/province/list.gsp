
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'province.label', default: 'Province')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>

                <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>

                <g:if test="${ params.t == 'city'}">
                    <span class="divider">/</span>
                    <a href="javascript:void 0">${obj?.name}</a>
                    <g:set var="pid" value="${obj?.code}"/>

                </g:if>
                <g:if test="${params.t == 'district'}">
                    <span class="divider">/</span>
                    <g:link action="list" params="${[id:obj?.province?.code,t:'city']}">${obj?.province?.name}</g:link>
                    <span class="divider">/</span>
                    <a href="javascript:void 0">${obj?.name}</a>
                    <g:set var="pid" value="${obj?.code}"/>
                </g:if>
            </li>
        </ul>
    </div>

    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div>
         <g:link action="create" params="${[id: params.id, t:params.t]}"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i>
             <g:if test="${params.t == 'district'}">
                 <g:set var="entityName" value="${message(code: 'district.label')}"/>
              </g:if>
             <g:if test="${params.t == 'city'}">
                 <g:set var="entityName" value="${message(code: 'city.label')}"/>
             </g:if>
             <g:message code="default.add.label" args="[entityName]" />
         </g:link>
    </div>
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>

            <div class="box-content">
                <div class="span12 well">
                    <g:form action="list" name="searchForm"  >
                        <div class="bm-search">
                            <label class="search-lb">状态 ：</label>
                            <g:select name="status" value="${params.status?:'ENABLED'}" optionValue="label" from="${com.baoming.Province.Status.values()}" />
                        </div>
                        <div class="span2">
                            <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
                        </div>
                    </g:form>
                </div><!--/span-->
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th><g:message code="default.orderValue.label" default="Order" /></th>

                        <th><g:message code="province.name.label" default="Name" /></th>

                        <th><g:message code="province.code.label" default="Code" /></th>

                        <g:if test="${!params.t || params.t == 'province'}">
                            <th><g:message code="mediumPlan.status.label" default="status" /></th>
                        </g:if>
                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${instanceList}" status="i" var="instance">
                        <tr>
                            <td class="center">${instance.orderValue}</td>

                            <td class="center">${fieldValue(bean: instance, field: "name")}</td>

                            <td class="center">${instance?.number?:instance?.code}</td>
                            <g:if test="${!params.t || params.t == 'province'}">
                                <td class="center">${instance?.status?.label}</td>
                            </g:if>
                            <td class="center">

                                    <g:if test="${params.t != 'district'}">
                                    <g:link class="btn btn-success" action="list" params="${[id:instance.code,t:(params.t == 'city'?'district':'city')]}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" /><g:message code="${params.t == 'city'?'district.label':'city.label'}" default="View" />
                                    </g:link>
                                    </g:if>

                                    <g:link class="btn btn-info" action="edit" params="${[id:instance?.code,t:params.t,pid:pid]}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" params="${[id:instance?.code,t:params.t,pid:pid]}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${provinceInstanceTotal}" params="${[id:params.id,t:params.t,status:params.status]}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
