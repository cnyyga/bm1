<%@ page import="com.baoming.account.Role" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'default.sys.name', default: 'Plan')}" />
		<title>${entityName}</title>
        <g:javascript src="student-home.js"  />
        <g:javascript src="excanvas.js"  />
        <g:javascript src="jquery.dataTables.min.js"  />
        <g:javascript src="jquery.flot.min.js"  />
        <g:javascript src="jquery.flot.stack.js"  />
        <g:javascript src="jquery.flot.resize.min.js"  />
	</head>
	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="#">Home</a>
            </li>

        </ul>
    </div>
    <div class="span12 well">
        <g:form action="index" >

            <div class="bm-search">
                <label class="search-lb"><g:message code="student.year.label"/>：</label>
                <%
                    def cal = Calendar.instance
                    def year = cal.get(Calendar.YEAR)
                %>
                <g:select name="year" from="${(year-10)..year}" value="${params.year?:year}" class="input-small"/>
            </div>
            <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
        </g:form>
    </div>
    %{--审核记录--}%
    <div class="sortable row-fluid">
        <a class="well span3 top-block" href="${createLink(controller: 'student',action: 'list',params: [year:params.year?:year])}">
            <span class="icon32 icon-red icon-user"></span>
            <div><g:message code="home.student.label"/></div>
            <div>${total}</div>
        </a>

        <a class="well span3 top-block" href="${createLink(controller: 'student',action: 'list',params: [year:params.year?:year,audit:com.baoming.account.Student.ReviewStatus.PASS])}">
            <span class="icon32 icon-green icon-user"></span>
            <div><g:message code="home.student.audit.message"/></div>
            <div>${pass}</div>
        </a>

        <a class="well span3 top-block" href="${createLink(controller: 'student',action: 'list',params: [year:params.year?:year,audit:com.baoming.account.Student.ReviewStatus.NO_AUDIT])}">
            <span class="icon32 icon-color icon-user"></span>
            <div><g:message code="home.student.auditing.message"/></div>
            <div>${audit}</div>
        </a>

        <a class="well span3 top-block" href="${createLink(controller: 'student',action: 'list',params: [year:params.year?:year,audit:com.baoming.account.Student.ReviewStatus.NO_PASS])}">
            <span class="icon32 icon-darkgray icon-user"></span>
            <div><g:message code="home.student.no.audit.message"/></div>
            <div>${noPass}</div>
        </a>
    </div>
    %{--审核记录结束 --}%
    <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
        %{--老师统计 --}%
          <g:render template="teacherSt"  />
    </sec:ifAllGranted>
    <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
    %{--管理员统计 --}%
         <g:render template="adminSt"  />
    </sec:ifAllGranted>
    <sec:ifAllGranted roles="${Role.AUTHORITY_FINANCE}">
    %{--管理员统计 --}%
        <g:render template="adminSt"  />
    </sec:ifAllGranted>
	</body>
</html>
