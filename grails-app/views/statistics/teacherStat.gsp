
<%@ page import="com.baoming.account.Teacher" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'statistics.teacher.label', default: 'Teacher')}" />
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
                    <g:form action="teacherStat" >
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="statistics.date.label"/> ：</label>
                            <g:textField name="date" class="datepicker" value="${params.date}"/>
                        </div>

                        <div class="span2">
                            <g:submitButton name="sub"  value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
                            <g:actionSubmit value="${message(code:'default.button.export.label')}" action="expTeacherStat" name='exportBtn'  class="btn btn-small btn-inverse"/>
                        </div>
                    </g:form>
                </div><!--/span-->
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        
                        <th><g:message code="statistics.sort.label" default="Number" /></th>
                        <th><g:message code="statistics.teacher.name.label" default="Name" /></th>
                        <th><g:message code="statistics.teacher.area.label" default="Area" /></th>
                        <th><g:message code="teacher.taskNumber.label" default="Area" /></th>
                        <th><g:message code="statistics.today.number.label" default="Today" /></th>
                        <th><g:message code="statistics.total.number.label" default="Total" /></th>
                        <th><g:message code="statistics.date.label" default="Date" /></th>
                        <th><g:message code="statistics.department.name.label" default="Department" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${teachers}" status="i" var="ts">
                        <g:set var="teacherInstance" value="${ts[0]}"/>
                        <tr>
                            <td class="center">${i+1+(params.offset?params.int('offset'):0)}</td>
                            <td class="center">${teacherInstance.name}</td>
                            <td class="center">
                                <g:set var="tds" value="${teacherInstance?.teacherDistricts}"/>
                                <g:each in="${tds}" var="td">

                                    <%
                                        try{
                                            out.println(td.district?.city?.name)
                                        }catch (e){

                                        }
                                        try{
                                            out.println(td.district?.name)
                                        }catch (e){

                                        }
                                    %>
                                </g:each>
                            </td>
                            <td class="center">${teacherInstance.taskNumber}</td>
                            <td class="center">${ts[1]}</td>
                            <td class="center">${ts[2]}</td>
                            <td class="center">${date.format('yyyy-MM-dd')}</td>
                            <td class="center">${teacherInstance.department?.name}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${total}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->
		</div>
	</body>
</html>
