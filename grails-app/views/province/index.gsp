
<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'district.label', default: 'district')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.treeview.css')}" type="text/css">
        <g:javascript src="jquery.treeview.js"/>
        <g:javascript src="jquery.validate.min.js"/>
        <g:javascript src="messages_zh.js" />
       <g:javascript src="province.js"/>
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
                <h2><i class="icon-th"></i> ${entityName}</h2>
                <div class="box-icon">
                    <a href="#" class="btn btn-round area-add-root" rel="${createLink(controller: 'province',action: 'create')}"><i class="icon-edit"></i></a>
                </div>
            </div>
            <div class="box-content">
                <div class="row-fluid">
                    <ul id="tree">
                         <g:include action="tree"/>
                    </ul>
                </div>
            </div>
        </div><!--/span-->

        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2 class="area-th"><i class="icon-th"></i>Create/Edit</h2>

                <div class="box-icon">
                    <a href="#" class="btn btn-round area-add" rel="${createLink(controller: 'province',action: 'create')}"><i class="icon-edit"></i></a>
                    <a href="#" rel="${createLink(action: 'delete')}" class="btn btn-round area-remove"><i class="icon-remove"></i></a>
                </div>
            </div>
            <div class="box-content">
                <div class="row-fluid tree-form">
                     <g:include action="create"/>
                </div>
            </div>
        </div><!--/span-->
    </div><!--/row-->

	</body>
</html>
