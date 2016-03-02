
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
                    var _url = "${createLink(action: 'exp')}?year="+_year
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
                            <g:select name="year" from="${(year-10)..year}" value="${params.year?:year}" class="input-small"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.name.label"/> ：</label>
                            <g:textField name="name"  value="${params.name}"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="preppy.plan.label"/> ：</label>
                            <g:select name="planId" from="${com.baoming.PreppyPlanDetail.findAll()*.plan.unique()}" optionKey="id" optionValue="name" value="${params.planId}" noSelection="['':'']"/>
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
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="preppy.reviewStatus.label"/> ：</label>
                            <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" noSelection="['':'']" value="${params.reviewStatus}"/>

                        </div>

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

                        <th><g:message code="preppy.studentCateories.label" default="collegeType" /></th>
                        <th><g:message code="preppy.teacher.label" default="teacher" /></th>

                        <th><g:message code="preppy.reviewStatus.label" default="reviewStatus" /></th>

                       %{-- <th>报警</th>--}%
                        
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
                            
                            <td class="center">${preppyInstance.studentCateories?.label}</td>
                            <td class="center">
                                <%
                                    try{
                                        println(preppyInstance.teacher?.name)
                                    }catch (e){}
                                    %>
                            </td>

                            <td class="center" id="studentTd${preppyInstance.id}">
                                <span class="label  ${preppyInstance.reviewStatus == Preppy.ReviewStatus.NO_AUDIT ?'label-important':(preppyInstance.reviewStatus == Preppy.ReviewStatus.GJSZZ?'label-success':'label-warning')}">
                                    ${preppyInstance.reviewStatus?.label?:message(code: 'home.student.auditing.message')}
                                </span>
                               </td>

                            %{--<td class="center red">
                              <g:if test="${preppyInstance.studentCateories.name() == com.baoming.Preppy.StudentCateories.SG.name()}">
                                      <g:set var="joinYear" value="${preppyInstance.academicYear}"/>

                                     <g:if test="${!joinYear || (thisYear - (joinYear as int)) > 2}">
                                          学业水平测试过期<br/>
                                      </g:if>
                                    <g:if test="${preppyInstance.skill?.name() == com.baoming.Preppy.Skill.NO.name()}">
                                        计算机不合格
                                    </g:if>
                                </g:if>
                                 <g:else>
                                    <g:set var="birthdayYear" value="${preppyInstance.birthday?.format("yyyy")}"/>
                                    <g:set var="birthdayYear" value="${birthdayYear as int}"/>
                                    <g:if test="${birthdayYear < (thisYear-19) || birthdayYear > (thisYear-17)}">
                                        年龄不符<br/>
                                    </g:if>
                                    <g:if test="${preppyInstance.family == Preppy.Family.JIANGSU || preppyInstance.studentFamily == Preppy.Family.JIANGSU }">
                                        符合江苏报考条件 <br/>
                                    </g:if>
                                    <g:if test="${preppyInstance.family != Preppy.Family.JIANGSU && preppyInstance.studentFamily != Preppy.Family.JIANGSU }">
                                        挂学籍
                                    </g:if>
                                </g:else>
                            </td>
                            --}%
                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${preppyInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                                <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                                    <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}">
                                        <i class="icon-zoom-in  icon-white"></i>
                                        <g:message code="default.button.print.label" default="Xy" />
                                    </g:link>
                                </sec:ifNotGranted>
                                <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
                                    <g:link class="btn btn-success" action="xy1" id="${preppyInstance.id}">
                                        <i class="icon-zoom-in  icon-white"></i>
                                        <g:message code="default.button.preview.label" default="Xy" />
                                    </g:link>
                                    <g:if test="${!preppyInstance.reviewStatus || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">

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
                                    <g:hiddenField name="preppy_reviewStatus" value="${preppyInstance.reviewStatus}"/>
                                    <g:hiddenField name="preppy_family" value="${preppyInstance.family}"/>
                                    <g:hiddenField name="preppy_collegeSignUp" value="${preppyInstance.collegeSignUp}"/>
                                    <g:hiddenField name="preppy_preppyPlan" value="${preppyInstance.preppyPlan?.id}"/>
                                    <g:hiddenField name="preppy_remark" value="${preppyInstance.remark}"/>
                                    <g:hiddenField name="preppy_remark1" value="${preppyInstance.remark1}"/>
                                    <g:hiddenField name="preppy_remark2" value="${preppyInstance.remark2}"/>
                                    <g:link class="btn btn-info btn-stu-review" action="ajaxAudit" rel="${preppyInstance.id}" id="${preppyInstance.id}" params="${[t:'au']}">
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
                    <g:paginate total="${preppyInstanceTotal}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


    <div id="reviewModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel"><g:message code="student.review.label"/> </h3>
        </div>
        <div class="modal-body">
            <div id="reviewFormContent">
                <sec:ifAnyGranted roles="${com.baoming.account.Role.AUTHORITY_ADMIN},${com.baoming.account.Role.AUTHORITY_FINANCE}">
                    <div class="control-group">
                        <label class="control-label" for="reviewStatus">
                            <g:message code="student.review.status.label" default="account" />
                        </label>
                        <div class="controls">
                            <g:select name="reviewStatus" id="reviewStatus11" from="${Preppy.ReviewStatus.values()}"   optionValue="label"></g:select>
                        </div>
                    </div>
                    <div class="control-group zhongzhi">
                        <label class="control-label" for="collegeSignUp">
                            高考报名地
                        </label>

                        <div class="controls">
                            <g:select name="collegeSignUp" from="${com.baoming.Preppy$CollegeSignUp?.values()}"  optionValue="label" required="" value="${preppyInstance?.collegeSignUp?.name()}"/>
                        </div>
                    </div>

                    <div class="control-group zhongzhi">
                        <label class="control-label" for="preppyPlan">
                            <g:message code="preppyPlan.label" default="preppyPlan" />
                        </label>

                        <div class="controls">
                            <g:select id="preppyPlan" name="preppyPlan" from="${preppyPlans}" optionKey="id" optionValue="name" value="${preppyInstance?.preppyPlan?.id}" class="many-to-one" />
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />1
                        </label>
                        <div class="controls">
                            <g:textArea name="remark" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark}</g:textArea>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />2
                        </label>
                        <div class="controls">
                            <g:textArea name="remark1" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark1}</g:textArea>
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />3
                        </label>
                        <div class="controls">
                            <g:textArea name="remark2" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark2}</g:textArea>
                        </div>
                    </div>
                </sec:ifAnyGranted>
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" data-dismiss="modal" aria-hidden="true"><g:message code="default.button.close.label"/></button>
            <button class="btn btn-primary save-student-review" data-loading-text="Loading..."><g:message code="default.button.update.label"/></button>
        </div>
    </div>
	</body>
</html>
