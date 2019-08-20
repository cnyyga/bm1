
<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript src="tj.js"/>
        <g:javascript src="student-review.js"/>

        <script>
            $(function(){
                $("#exportBtn").click(function(){
                    var _year = $("#year").val();
                    var name = $("#name").val();
                    var _url = "${createLink(action: 'exp')}?year="+_year
                    if(name){
                        _url += "&name="+name;
                    }
                    window.open(_url)
                })

                $("#printBtn").click(function(){
                    window.print();
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
                <a href="javascript:void 0">${entityName}</a>
            </li>
        </ul>
    </div>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div>
        <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
         <g:link action="create"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
        </sec:ifNotGranted>
    </div>
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <se class="span12 well">
                    <g:form action="list" >
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.year.label"/>：</label>
                            <%
                                def cal = Calendar.instance
                                def year = cal.get(Calendar.YEAR)
                            %>
                            <g:set var="thisYear" value="${year}"/>
                            <g:select name="year" from="${(year-10)..year}" value="${params.year?:year}" class="input-small" noSelection="['':'']"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.name.label"/>/<g:message code="student.number.label"/> ：</label>
                            <g:textField name="name"  value="${params.name}"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="preppy.reviewStatus.label"/> ：</label>
                            <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" noSelection="['':'']" value="${params.reviewStatus}"/>
                        </div>
                        <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                            <div class="bm-search">
                                <label class="search-lb"><g:message code="preppy.teacher.label"/> ：</label>
                                <%
                                    def userService = grailsApplication.mainContext.getBean("userService");
                                %>
                                <select id="combobox" name="teacherId">
                                    <option value="">请选择</option>
                                    <g:set var="studTeacherId" value="${params.teacherId}"/>
                                    <g:each in="${userService.getTeachers()}" var="teah">
                                        <g:if test="${studTeacherId == teah.id}">
                                            <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" selected="true" >${teah.name}</option>
                                        </g:if>
                                        <g:else>
                                            <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" >${teah.name}</option>
                                        </g:else>
                                    </g:each>
                                </select>
                            </div></sec:ifNotGranted>
                        <div class="span2">
                            <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
                            <input type="button" name='exportBtn' id="exportBtn" value="${message(code:'default.button.export.label')}" class="btn btn-small btn-inverse"   />

                        </div>
                    </g:form>
                </div><!--/span-->
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        
                        <th><g:message code="preppy.name.label" default="name" /></th>

                        <th><g:message code="preppy.gender.label" default="gender" /></th>

                        <th><g:message code="preppy.number.label" default="number" /></th>

                        <th><g:message code="preppy.birthday.label" default="number" /></th>

                        <th><g:message code="preppy.reviewStatus.label" default="reviewStatus" /></th>
                        <th><g:message code="preppy.reviewDate.label" default="reviewDate" /></th>

                        <th><g:message code="preppy.teacher.label" default="teacher" /></th>

                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${preppyInstanceList}" status="i" var="preppyInstance">
                        <tr>
                            
                            <td class="center">${preppyInstance.name}</td>
                            
                            <td class="center">${preppyInstance.gender?.label}</td>
                            
                            <td class="center">${preppyInstance.number}</td>
                            
                            <td class="center"><g:if test="${preppyInstance.birthday}"><g:formatDate date="${preppyInstance.birthday}" format="yyyy-MM-dd"/></g:if> </td>

                            <td class="center" id="studentTd${preppyInstance.id}">
                                <span class="label  ${preppyInstance.reviewStatus == Preppy.ReviewStatus.NO_AUDIT ?'label-important':(preppyInstance.reviewStatus == Preppy.ReviewStatus.GJSZZ?'label-success':'label-warning')}">
                                    ${preppyInstance.reviewStatus?.label?:message(code: 'home.student.auditing.message')}
                                </span>
                            </td>
                            <td class="center"><g:if test="${preppyInstance.reviewDate}"><g:formatDate date="${preppyInstance.reviewDate}" format="yyyy-MM-dd HH:mm"/></g:if> </td>

                            <td class="center">
                                <%
                                    try{
                                        println(preppyInstance.teacher?.name)
                                    }catch (e){}
                                %>
                            </td>

                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${preppyInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>
                                <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}" target="_blank">
                                    <i class="icon-zoom-in  icon-white"></i>
                                    <g:message code="default.button.print.label" default="Xy" />
                                </g:link>

                                <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">

                                    <g:if test="${!preppyInstance.reviewStatus || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name() || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.GJSZZ.name()}">

                                        <g:link class="btn btn-info" action="edit" id="${preppyInstance.id}">
                                            <i class="icon-edit icon-white"></i>
                                            <g:message code="default.button.edit.label" default="Edit" />
                                        </g:link>

                                        <g:link class="btn btn-danger" action="delete" id="${preppyInstance.id}">
                                            <i class="icon-trash icon-white"></i>
                                            <g:message code="default.button.delete.label" default="Delete" />
                                        </g:link>
                                    </g:if>

                                </sec:ifAllGranted>

                                <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
                                    <g:link class="btn btn-info" action="edit" id="${preppyInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${preppyInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>
                                </sec:ifAllGranted>
                                <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                                    <g:link class="btn btn-info" action="edit" id="${preppyInstance.id}" params="[a:'audit']">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="student.review.label" default="Review" />
                                    </g:link>
                                </sec:ifNotGranted>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${preppyInstanceTotal}" params="[year:params.year,name:params.name,planId:params.planId,reviewStatus:params.reviewStatus,teacherId:params.teacherId]" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->



	</body>
</html>
