
<%@ page import="com.baoming.Admission" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'admission.label', default: 'Admission')}" />
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

<div class="row-fluid sortable">
    <div class="box span12">
        <div class="box-header well" data-original-title>
            <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <div class="span12 well">
<g:form action="list" name="searchForm"  >
    <g:hiddenField name="regType" value="${params.regType}"/>
    <div class="bm-search">
        <label class="search-lb"><g:message code="student.name.label"/>/<g:message code="student.number.label"/> ：</label>
        <g:textField name="name"  value="${params.name}"/>
    </div>
    <div class="span2">

        <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
    </div>
</g:form></div></div></div></div>

    <div>
         <g:link action="create"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
        <g:link  action="importFile" class="btn btn-small btn-primary import"><i class="icon-book icon-white"></i><g:message code="default.button.import.label" /></g:link>

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
                        
                        <th><g:message code="admission.idNo.label" default="Id No" /></th>
                        
                        <th><g:message code="admission.name.label" default="Name" /></th>
                        
                        <th><g:message code="admission.sex.label" default="Sex" /></th>
                        
                        <th><g:message code="admission.ksh.label" default="Ksh" /></th>
                        
                        <th><g:message code="admission.bkzy.label" default="Bkzy" /></th>
                        
                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${admissionInstanceList}" status="i" var="admissionInstance">
                        <tr>
                            
                            <td class="center">${fieldValue(bean: admissionInstance, field: "idNo")}</td>
                            
                            <td class="center">${fieldValue(bean: admissionInstance, field: "name")}</td>
                            
                            <td class="center">${fieldValue(bean: admissionInstance, field: "sex")}</td>
                            
                            <td class="center">${fieldValue(bean: admissionInstance, field: "ksh")}</td>
                            
                            <td class="center">${fieldValue(bean: admissionInstance, field: "bkzy")}</td>
                            
                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${admissionInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                    <g:link class="btn btn-info" action="edit" id="${admissionInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${admissionInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${admissionInstanceTotal}" params="[name:params.name]" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
	</body>
</html>
