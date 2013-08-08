
<%@ page import="com.baoming.Plan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'statistics.label', default: 'Statistics')}" />
		<title>${entityName}</title>
        <g:javascript src="excanvas.js"  />
        <g:javascript src="jquery.flot.min.js"  />
        <g:javascript src="jquery.flot.pie.min.js"  />
        <g:javascript src="jquery.flot.stack.js"  />
        <g:javascript src="jquery.flot.resize.min.js"  />
        <g:javascript src="statistics.js"  />
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
    </div><!--/span-->

    <div class="row-fluid sortable">
       %{-- <div class="box span3">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i><g:message code="home.student.teacher.more.label"/></h2>

            </div>
            <div class="box-content">
                <div class="row-fluid">

                </div>
            </div>
        </div><!--/span-->

        <div class="box span3">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i> <g:message code="home.student.city.more.label"/></h2>

            </div>
            <div class="box-content">
                <div class="row-fluid">

                </div>
            </div>
        </div><!--/span-->

        <div class="box span3">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i><g:message code="home.student.middleSchool.more.label"/></h2>

            </div>
            <div class="box-content">
                <div class="row-fluid">

                </div>
            </div>
        </div><!--/span-->

        <div class="box span3">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i><g:message code="plan.student.count.label"/></h2>

            </div>
            <div class="box-content">
                <div class="row-fluid">

                </div>
            </div>
        </div><!--/span-->--}%

    </div><!--/row-->

    <div class="row-fluid sortable">

        <div class="box">
            <div class="box-header well">
                <h2><i class="icon-list-alt"></i> <g:message code="home.student.year.more.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="yeaChart"  class="center" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'yearForAjax')}"></div>
            </div>
        </div>
    </div><!--/row-->

    <div class="row-fluid sortable">
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-list-alt"></i> <g:message code="student.gender.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="genderchart" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'genderForAjax')}"></div>
            </div>
        </div>

        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-list-alt"></i> <g:message code="district.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="citychart" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'cityForAjax')}"></div>
            </div>
        </div>

      %{--  <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-list-alt"></i> <g:message code="middleSchool.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="middleSchoolchart" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'middleSchoolForAjax')}"></div>
            </div>
        </div>--}%
    </div>
        <div class="row-fluid sortable">
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-list-alt"></i> <g:message code="student.payment.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="reviewStatuschart" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'reviewStatusForAjax')}"></div>
            </div>
        </div>

        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-list-alt"></i> <g:message code="home.teacher.add.label"/> </h2>

            </div>
            <div class="box-content">
                <div id="teacherStatuschart" style="height:300px" dataUrl="${createLink(controller: 'statistics',action: 'teacherForAjax')}"></div>
            </div>
        </div>

    </div><!--/row-->
	</body>
</html>
