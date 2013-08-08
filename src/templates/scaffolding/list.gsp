<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="\${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <a href="javascript:void 0">\${entityName}</a>
            </li>
        </ul>
    </div>
    <g:if test="\${flash.message}">
        <div class="alert alert-error">\${flash.message}</div>
    </g:if>
    <div>
         <g:link action="create"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
    </div>
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
                        allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                        props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
                        Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                        props.eachWithIndex { p, i ->
                            if (i < 6) {
                                 %>
                        <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                        <%  }   } %>
                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                        <tr>
                            <%  props.eachWithIndex { p, i ->
                                if (i < 6) {
                                if (p.type == Boolean || p.type == boolean) { %>
                            <td class="center"><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                            <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                            <td class="center"><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
                            <%          } else { %>
                            <td class="center">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                            <%  }   }   } %>
                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="\${${propertyName}.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                    <g:link class="btn btn-info" action="edit" id="\${${propertyName}.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="\${${propertyName}.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="\${${propertyName}Total}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
