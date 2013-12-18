<%@ page import="com.baoming.Plan; com.baoming.account.Student; com.baoming.account.Role" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript src="district_select.js"/>
        <g:javascript src="export.js"/>
        <g:javascript src="remove-more.js"/>
        <g:javascript src="tj.js"/>
        <style>
        .ui-combobox {
            position: relative;
            display: inline-block;
        }
        .ui-combobox-toggle {
            position: absolute;
            top: 0;
            bottom: 0;
            margin-left: -1px;
            padding: 0;
            /* adjust styles for IE 6/7 */
            *height: 1.7em;
            *top: 0.1em;
        }
        .ui-combobox-input {
            margin: 0;
            padding: 0.3em;
        }
        .ui-widget-content {
            text-align: left;
        }
        ul.ui-widget-content {
            height: 200px;
            overflow: auto;
        }
        </style>
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
         <g:link action="createNew"  class="btn btn-small btn-primary"><i class="icon-chevron-left icon-white"></i><g:message code="default.add.label" args="[entityName]" /></g:link>
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
                            <label class="search-lb"><g:message code="student.name.label"/> ：</label>
                            <g:textField name="name"  value="${params.name}"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.year.label"/>：</label>
                            <%
                                def cal = Calendar.instance
                                def year = cal.get(Calendar.YEAR)
                                %>
                            <g:select name="year" from="${(year-10)..year}" value="${params.year?:year}" class="input-small"/>
                        </div>
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="student.review.label"/>：</label>
                            <g:select name="audit"  from="${com.baoming.account.Student.ReviewStatus.values()}" optionValue="label" value="${params.audit}" noSelection="${['':'请选择']}"/>
                        </div>
                        <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                        <div class="bm-search bm-search3">
                            <label class="search-lb"><g:message code="district.label"/>： </label>
                            <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  value="${params?.provinceId}" class="many-to-one" noSelection="${['':'请选择']}"/>
                            <g:select id="city" name="cityId" from="${[]}"  />
                            <g:select id="district" name="districtId" from="${[]}" />
                        </div>
                        </sec:ifNotGranted>

                        <div class="bm-search ">
                            <label class="search-lb"><g:message code="plan.label"/>：</label>
                            <g:select name="planId" from="${com.baoming.Plan.findAllByStatus(Plan.Status.RUNNING)}" data-rel="chosen"  optionValue="name" optionKey="id"  value="${params?.planId}"  noSelection="${['':'请选择']}"/>
                        </div>
                        <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">
                        <div class="bm-search">
                            <label class="search-lb"><g:message code="department.label"/> ：</label>
                            <g:select name="departmentId" from="${com.baoming.Department.list()}"  optionKey="id" optionValue="name" value="${params.departmentId}" data-rel="chosen" noSelection="${['':'请选择']}"/>
                        </div>
                                   <div class="span12" style="margin-left: 0">
                                   <div class="bm-search">
                                       <label class="search-lb"><g:message code="teacher.label"/>： </label>
                                       %{--<g:select name="teacherId" from="${teachers}"  optionValue="name" optionKey="id"  value="${params?.teacherId}"  noSelection="${['':'请选择']}"/>--}%
                                   <div class="ui-widget">
                                       <select id="combobox" name="teacherId">
                                           <option value="">请选择</option>
                                           <g:each in="${teachers}" var="teah">
                                               <g:if test="${params?.teacherId == teah.id as String }">
                                                   <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" selected="true" >${teah.name}</option>
                                               </g:if>
                                               <g:else>
                                                   <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" >${teah.name}</option>
                                               </g:else>
                                           </g:each>
                                       </select>
                                   </div> </div>
                                   </div>
                               </sec:ifNotGranted>

                      <div class="span2">

                       <g:submitButton name="sub" value="${message(code:'default.button.search.label')}" class="btn btn-small btn-primary" />
                            <input type="button" name='exportBtn' id="exportBtn" value="${message(code:'default.button.export.label')}" class="btn btn-small btn-inverse"   />
                       </div>
                   </g:form>
                </div><!--/span-->
                <div> <input type="button" name='delAllBtn' id="delAllBtn" value="${message(code:'default.button.more.delete.label')}"
                             class="btn btn-small btn-warning" url="${createLink(action: 'delMore')}" /></div>
                <table class="table table-bordered table-striped table-condensed">
                    <thead>
                    <tr>
                        <th><g:checkBox name="chk_all" value="1" checked="false"/>
                           </th>
                        <th><g:message code="student.name.label" default="姓名" /></th>

                        <th><g:message code="student.gender.label" default="性别" /></th>

                        <th><g:message code="student.code.label" default="考生号" /></th>

                        <th><g:message code="student.number.label" default="身份证号" /></th>

                        <th><g:message code="student.recommend.teacher.label" default="Teacher" /></th>

                        <th><g:message code="student.district.label" default="地区" /></th>

                        <th><g:message code="student.review.label" default="Audit" /></th>

                        <th><g:message code="default.operator.label" default="操作" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${studentInstanceList}" status="i" var="studentInstance">
                        <tr>
                            <td class="center" ><g:checkBox name="chk_student_id" class="student-chk" checked="false" value="${studentInstance?.id}"/></td>
                            <td class="center">${fieldValue(bean: studentInstance, field: "name")}</td>

                            <td class="center">${studentInstance?.gender?.label}</td>

                            <td class="center">${studentInstance.code}</td>

                            <td class="center">${studentInstance.number}</td>

                            <td class="center">${studentInstance.teacher?.name}</td>

                            <td class="center">
                                ${studentInstance.province?.name}
                                ${studentInstance.city?.name}
                                ${studentInstance.district?.name}
                            </td>

                            <td class="center">
                                <span class="label  ${studentInstance.reviewStatus == Student.ReviewStatus.NO_AUDIT ?'label-important':(studentInstance.reviewStatus == Student.ReviewStatus.PASS?'label-success':'label-warning')}">
                                    ${studentInstance.reviewStatus?.label}
                                </span>
                            </td>

                            <td class="center">
                                    <g:link class="btn btn-success" action="show" id="${studentInstance.id}">
                                        <i class="icon-zoom-in icon-white"></i>
                                        <g:message code="default.button.view.label" default="View" />
                                    </g:link>

                            <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
                                    <g:link class="btn btn-info" action="createNew" id="${studentInstance.id}">
                                        <i class="icon-edit icon-white"></i>
                                        <g:message code="default.button.edit.label" default="Edit" />
                                    </g:link>
                                <g:link class="btn btn-danger" action="delete" id="${studentInstance.id}">
                                    <i class="icon-trash icon-white"></i>
                                    <g:message code="default.button.delete.label" default="Delete" />
                                </g:link>

                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="${Role.AUTHORITY_FINANCE}">
                                <g:link class="btn btn-info" action="show" id="${studentInstance.id}" params="${[t:'au']}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="student.review.label" default="Edit" />
                                </g:link>
                            </sec:ifAllGranted>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <div class="pagination pagination-centered">
                    <g:paginate total="${studentInstanceTotal}" params="${params}" />
                </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->


		</div>
    <g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${params?.cityId}"  />
    <g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${params?.districtId}" />
    <g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${params.middleSchoolId}" />
    <g:hiddenField name="exportUrl" value="${createLink(action: 'export',controller: 'student')}" />

    <div id="dialog-export">
       <g:render template="dialogContent"/>
        <div style="float: right;">
        <label class="checkbox">
            <input type="checkbox" name="all" value="1" class="export-all">
            <g:message code="default.checkbox.all.label" default="All" />
        </label>
        </div>
    </div>
    <div id="dialog-del">
    </div>
    </body>
</html>
