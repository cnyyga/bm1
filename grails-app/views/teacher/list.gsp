
<%@ page import="com.baoming.account.Teacher" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teacher.label', default: 'Teacher')}" />
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
                <a href="javascript:void 0">${entityName}</a>
            </li>
        </ul>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
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
                <div class="span12 well">
                    <g:form action="list" >
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="default.keyword.label"/> ：</label>
                            <g:textField name="name"  value="${params.name}"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="department.label"/> ：</label>
                            <g:select name="departmentId" from="${com.baoming.Department.list()}"  optionKey="id" optionValue="name" value="${params.departmentId}" data-rel="chosen" noSelection="${['':'请选择']}"/>
                        </div>
                        <div class="bm-search bm-search3">
                            <label class="search-lb"><g:message code="district.label"/>： </label>
                            <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  value="${params?.provinceId}" class="many-to-one" noSelection="${['':'请选择']}"/>
                            <g:select id="city" name="cityId" from="${[]}"  />
                            <g:select id="district" name="districtId" from="${[]}" />
                        </div>

                        <div class="span2">
                            <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
                        </div>
                    </g:form>
                </div><!--/span-->
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        
                        <th><g:message code="user.username.label" default="Username" /></th>
                        <th><g:message code="user.name.label" default="Name" /></th>
                        <th><g:message code="city.label" default="enabled" /></th>
                        <th><g:message code="department.label" default="department" /></th>
                        <th><g:message code="teacher.taskNumber.label" default="Task" /></th>
                        <th><g:message code="user.enabled.label" default="enabled" /></th>

                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${teacherInstanceList}" status="i" var="teacherInstance">
                        <tr>
                            
                            <td class="center">${fieldValue(bean: teacherInstance, field: "username")}</td>
                            <td class="center">${fieldValue(bean: teacherInstance, field: "name")}</td>
                            <td class="center">
                                <g:set var="tds" value="${teacherInstance?.teacherDistricts}"/>
                                <g:each in="${tds}" var="td">

                                    <%
                                        try{
                                            out.println(td.district?.city?.name)
                                            out.println(td.district?.name)
                                        }catch (e){

                                        }

                                        %>
                                </g:each>
                            </td>
                            <td class="center">${teacherInstance.department?.name}</td>
                            <td class="center">${teacherInstance.taskNumber}</td>
                            <td class="center">
                                <span class="label  ${teacherInstance.enabled?'label-success':''}">
                                    <g:formatBoolean boolean="${teacherInstance.enabled}" />
                                </span>
                            </td>

                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${teacherInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                    <g:link class="btn btn-info" action="edit" id="${teacherInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${teacherInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${teacherInstanceTotal}" params="${[name:params.name,districtId:params.districtId,cityId:params.cityId,provinceId:params.provinceId,departmentId:params.departmentId]}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

    <g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${params?.cityId}"  />
    <g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${params?.districtId}" />
		</div>
	</body>
</html>
