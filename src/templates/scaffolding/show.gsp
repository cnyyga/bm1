<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style type="text/css">
        span.property-value{
            display: block;
            padding-top: 5px;
        }
        </style>
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="\${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
            </li>
        </ul>
    </div>

    <g:if test="\${flash.message}">
        <div class="alert alert-error">\${flash.message}</div>
    </g:if>

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> <g:message code="default.show.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <div class="form-horizontal">
                <fieldset>
                    <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
                    allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                    props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
                    Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                    props.each { p -> %>
                    <g:if test="\${${propertyName}?.${p.name}}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" />
                        </label>
                        <div class="controls">
                            <%  if (p.isEnum()) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
                            <%  } else if (p.oneToMany || p.manyToMany) { %>
                            <g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
                                <span class="property-value" aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></span>
                            </g:each>
                            <%  } else if (p.manyToOne || p.oneToOne) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></span>
                            <%  } else if (p.type == Boolean || p.type == boolean) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></span>
                            <%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:formatDate date="\${${propertyName}?.${p.name}}" format="yyyy-MM-dd HH:mm:ss" /></span>
                            <%  } else if(!p.type.isArray()) { %>
                            <span class="property-value" aria-labelledby="${p.name}-label"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></span>
                            <%  } %>
                        </div>
                    </div>
                    </g:if>
                    <%  } %>
                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="\${${propertyName}?.id}" />
                                <g:link class="btn btn-info" action="edit" id="\${${propertyName}?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                                <g:actionSubmit class="btn btn-primary" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
