<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'default.sys.name', default: 'Plan')}" />
		<title>${entityName}</title>
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

    <div class="row-fluid sortable">
        <g:if test="${teachers}">
        <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i> <g:message code="home.student.teacher.more.label"/> </h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'teacher',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list">
                    <g:each in="${teachers}" var="tea" status="tc">
                    <li>
                        <a href="${createLink(controller: 'student',action: 'list',params: [teacherId:tea.id,year:params.year?:year])}">
                            <span class="green">${tc+1}</span>
                            ${tea.name}<strong style="padding-left: 10px;">${tea.cc}</strong>
                        </a>
                    </li>
                    </g:each>
                </ul>
            </div>
        </div><!--/span-->
        </g:if>
        <g:if test="${citys}">
            <div class="box span4">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-th"></i>  <g:message code="home.student.city.more.label"/></h2>
                    <div style="float: right;">
                        <a href="${createLink(controller: 'home',action: 'rank',params: [t:'city',year:params.year?:year])}" class=" btn-mini">more</a>
                    </div>
                </div>
                <div class="box-content">
                    <ul class="dashboard-list">
                        <g:each in="${citys}" var="city" status="tc">
                            <li>
                                <a href="${createLink(controller: 'student',action: 'list',params: [provinceId:city?.provinceId,cityId:city?.id,year:params.year?:year])}">
                                    <span class="green">${tc+1}</span>
                                    ${city.name}<strong style="padding-left: 10px;">${city.cc}</strong>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div><!--/span-->
        </g:if>
        <g:if test="${districts}">
        <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i>  <g:message code="home.student.district.more.label"/></h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'district',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list">
                    <g:each in="${districts}" var="district" status="tc">
                        <li>
                            <a href="${createLink(controller: 'student',action: 'list',params: [provinceId:district?.provinceCode,cityId:district?.cityCode,districtId:district.code,year:params.year?:year])}">
                                <span class="green">${tc+1}</span>
                                ${district.cityName}${district.name}<strong style="padding-left: 10px;">${district.cc}</strong>
                            </a>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div><!--/span-->
        </g:if>
    </div>
        <div class="row-fluid sortable">
        <g:if test="${middleSchools}">
            <div class="box span6">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-th"></i>  <g:message code="home.student.middleSchool.more.message"/></h2>
                    <div style="float: right;">
                        <a href="${createLink(controller: 'home',action: 'rank',params: [t:'middleSchool',year:params.year?:year])}" class=" btn-mini">more</a>
                    </div>
                </div>
                <div class="box-content">
                    <ul class="dashboard-list">
                        <g:each in="${middleSchools}" var="ms" status="tc">
                            <li>
                                <a href="${createLink(controller: 'student',action: 'list',params: [middleSchoolId:ms.id,year:params.year?:year])}">
                                    <span class="green">${tc+1}</span>
                                    ${ms.name}<strong style="padding-left: 10px;">${ms.cc}</strong>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div><!--/span-->
        </g:if>
        <g:if test="${plans}">
            <div class="box span6">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-th"></i>  <g:message code="home.student.plan.more.label"/></h2>
                    <div style="float: right;">
                        <a href="${createLink(controller: 'home',action: 'rank',params: [t:'plan',year:params.year?:year])}" class=" btn-mini">more</a>
                    </div>
                </div>
                <div class="box-content">
                    <ul class="dashboard-list">
                        <g:each in="${plans}" var="plan" status="tc">
                            <li>
                                <a href="${createLink(controller: 'student',action: 'list',params: [planId:plan.id,year:params.year?:year])}">
                                    <span class="green">${tc+1}</span>
                                    ${plan.name}<strong style="padding-left: 10px;">${plan.cc}</strong>
                                </a>
                            </li>
                        </g:each>
                    </ul>
                </div>
            </div><!--/span-->
        </g:if>
    </div><!--/row-->

	</body>
</html>
