
<%@ page import="com.baoming.account.Role; com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
        <g:if test="${params.regType == 1 || params.regType == '1'}">
            <g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
        </g:if>
        <g:else>
            <g:set var="entityName" value="${message(code: 'student.reg.label', default: 'Student')}" />
        </g:else>
		<title><g:message code="default.show.label" args="[entityName]" /></title>

        <style type="text/css">
        span.property-value{
            display: block;
            padding-top: 5px;
        }
        </style>
        <script>
            $(function () {

                $('#myTab').tab('show');
                <g:if test="${params.t}">
                    $('#myTab a:last').tab('show')  ;
                </g:if>
                <g:else>
                    $('#myTab a:first').tab('show')  ;
                </g:else>
                $(".payment-del-pic").click(function(){
                    var t = $(this);
                    var parent = t.parent()
                    var url = t.attr("rel")
                    $.get(url,function(data){
                        if(data.status == 1){
                            parent.empty();
                            parent.append("<span class='label label-success'>删除成功</span>");
                            return
                        }
                        parent.append("<span class='label label-warning'>删除失败</span>");
                    },'json')
                })
            })
        </script>
	</head>

	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <g:link class="list" action="list" params="[regType:params.regType]"><g:message code="default.list.label" args="[entityName]" /></g:link>
            </li>
        </ul>
    </div>

    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> <g:message code="default.show.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content ">
                <g:render template="newshow"/>


        <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
            <div class="form-actions">
                <g:form>
                    <g:hiddenField name="id" value="${studentInstance?.id}" />
                    <g:link class="btn btn-info" action="createNew" id="${studentInstance?.id}"  params="[regType:params.regType]">
                        <i class="icon-edit icon-white"></i>
                        <g:message code="default.button.edit.label" default="Edit" />
                    </g:link>
                    <g:hiddenField name="act" value="1" />
                    <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </g:form>
            </div>
        </sec:ifAllGranted>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
