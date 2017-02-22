
<%@ page import="com.baoming.account.Student; com.baoming.account.Role; com.baoming.Medium" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'medium.label', default: 'Medium')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <script>
            $(function(){
                $("#exportBtn").click(function(){
                    var _year = $("#year").val();
                    var _url = "${createLink(action: 'exp')}?year="+_year
                    window.open(_url)
                })

            })
        </script>
        <g:javascript src="student-review.js"/>
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
<sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
    <div>
         <g:link action="create"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
    </div>
    </sec:ifNotGranted>
    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2> <g:message code="default.list.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <div class="span12 well">
                    <g:form action="list" >
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.year.label"/>：</label>
                            <%
                                def cal = Calendar.instance
                                def year = cal.get(Calendar.YEAR)
                            %>
                            <g:select name="year" from="${(year-10)..year}" value="${params.year?:year}" class="input-small"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.name.label"/> ：</label>
                            <g:textField name="name"  value="${params.name}"/>
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
                        
                        <th><g:message code="medium.name.label" default="Name" /></th>
                        
                        <th><g:message code="medium.code.label" default="Code" /></th>
                        
                        <th><g:message code="medium.number.label" default="Number" /></th>
                        
                        <th><g:message code="medium.gender.label" default="Gender" /></th>
                        
                        <th><g:message code="medium.mediumPlan.label" default="Medium Plan" /></th>
                        
                        <th><g:message code="medium.plan.label" default="Plan" /></th>
                        <th><g:message code="medium.teacher.label" default="Plan" /></th>
                        <th><g:message code="medium.reviewStatus.label" default="Plan" /></th>

                        <th><g:message code="default.operator.label" default="Actions" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${mediumInstanceList}" status="i" var="mediumInstance">
                        <tr>
                            
                            <td class="center">${fieldValue(bean: mediumInstance, field: "name")}</td>
                            
                            <td class="center">${fieldValue(bean: mediumInstance, field: "code")}</td>
                            
                            <td class="center">${fieldValue(bean: mediumInstance, field: "number")}</td>
                            
                            <td class="center">${mediumInstance.gender?.label}</td>
                            
                            <td class="center">${mediumInstance.mediumPlan?.name}</td>
                            
                            <td class="center">${mediumInstance.plan?.name}</td>
                            <td class="center">
                                <%
                                    try{
                                        println( mediumInstance.teacher?.name)
                                    }catch (e){

                                    }
                                    %>
                            </td>
                            <td class="center" id="studentTd${mediumInstance.id}">
                                <span class="label  ${mediumInstance.reviewStatus == com.baoming.account.Student.ReviewStatus.NO_AUDIT ?'label-important':(mediumInstance.reviewStatus == Student.ReviewStatus.PASS?'label-success':'label-warning')}">
                                    ${mediumInstance.reviewStatus?.label}
                                </span></td>

                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${mediumInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>
                        <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                                    <g:link class="btn btn-info" action="edit" id="${mediumInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>

                                    <g:link class="btn btn-danger" action="delete" id="${mediumInstance.id}">
                                        <i class="icon-trash icon-white"></i>
                                        <g:message code="default.button.delete.label" default="Delete" />
                                    </g:link>

                            </sec:ifNotGranted>
                                <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                                    <g:link class="btn btn-info btn-stu-review" action="ajaxAudit" rel="${mediumInstance.id}" id="${mediumInstance.id}" params="${[t:'au']}">
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
                    <g:paginate total="${mediumInstanceTotal}" params="[year:params.year]" />
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
                            <g:select name="reviewStatus" from="${Student.ReviewStatus.values()}"   optionValue="label"></g:select>
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
