<%@ page import="com.baoming.account.Role" %>
<div class="span2 main-menu-span">
    <div class="well nav-collapse sidebar-nav">
        <ul class="nav nav-tabs nav-stacked main-menu">
            <li class="nav-header hidden-tablet">Main</li>
            <sec:access url="/student/createNew">
                <li class="${(params.controller == 'student' && params.action == 'createNew')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student',action: 'createNew')}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'student.create.new.label')}</span></a></li>
            </sec:access>
            <sec:access controller="preppy">
                <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                <li class="${(params.controller == 'preppy' && params.action == 'create')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'preppy',action:'create')}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'preppy.create.label')}</span></a></li>
                </sec:ifNotGranted>
            </sec:access>
            <sec:access controller="medium">
                <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                    <li class="${(params.controller == 'medium' && params.action == 'create')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'medium',action:'create')}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'medium.create.label')}</span></a></li>
                </sec:ifNotGranted>
            </sec:access>
            <sec:access controller="student">
                <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
                    <li class="${(params.controller == 'student'&& params.action != 'createNew'&& params.action != 'imp' && params.regType!= '0')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student' ,params: [regType:1])}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'student.label')}"])}</span></a></li>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
                    <li class="${(params.controller == 'student'&& params.action != 'createNew'&& params.action != 'imp')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student')}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'student.label')}"])}</span></a></li>
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="${Role.AUTHORITY_FINANCE}">
                    <li class="${(params.controller == 'student'&& params.action != 'createNew'&& params.action != 'imp' && params.regType!= '0')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student')}"><i class="icon-user"></i><span class="hidden-tablet">
                        <g:message code='student.label' /><g:message code='student.review.label' /></span></a></li>
                </sec:ifAllGranted>
            </sec:access>
            <sec:access controller="preppy">
                <li class="${(params.controller == 'preppy' && params.action != 'create')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'preppy')}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'preppy.label')}"])}</span></a></li>
            </sec:access>
            <sec:access controller="medium">
                <li class="${(params.controller == 'medium' && params.action != 'create')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'medium')}"><i class="icon-user"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'medium.label')}"])}</span></a></li>
            </sec:access>
            <sec:access controller="student">
            <li class="${(params.controller == 'student'&& params.action != 'createNew'&& params.action != 'imp' && params.regType== '0')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student' ,params: [regType:0])}"><i class="icon-user"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'student.reg.label')}"])}</span></a></li>
            </sec:access>

            <sec:access url="/student/imp" >
                <li class="${(params.controller == 'student' && params.action == 'imp')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'student',action: 'imp')}"><i class="icon-tag"></i><span class="hidden-tablet"> ${message(code: 'default.button.import.label')}</span></a></li>
            </sec:access>
            <sec:access controller="comparison" >
                <li class="${(params.controller == 'comparison')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'comparison')}"><i class="icon-tag"></i><span class="hidden-tablet"> ${message(code: 'comparison.label')}</span></a></li>
            </sec:access>

            <sec:access controller="statistics">
            <li class="${(params.controller == 'statistics' && params.action == 'index')?'active':''}"><a class="ajax-link" href="${createLink(controller: 'statistics')}"><i class="icon-tag"></i><span class="hidden-tablet"> ${message(code: 'statistics.label')}</span></a></li>
            </sec:access>
            <sec:access controller="statistics">
                <li class="${params.action == 'teacherStat'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'statistics',action: 'teacherStat')}"><i class="icon-tag"></i><span class="hidden-tablet"> ${message(code: 'statistics.teacher.label')}</span></a></li>
            </sec:access>
            <sec:access controller="statistics">
                <li class="${params.action == 'departmentStat'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'statistics',action: 'departmentStat')}"><i class="icon-tag"></i><span class="hidden-tablet"> ${message(code: 'statistics.department.label')}</span></a></li>
            </sec:access>
            <li class="${params.controller == 'workPlan'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'workPlan')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'workPlan.label')}</span></a></li>

            <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
            <li class="nav-header hidden-tablet">
                ${message(code: 'default.manager.label',args: ["${message(code: 'user.label')}"])}
            </li>

            <sec:access controller="admin">
                <li class="${params.controller == 'admin'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'admin')}"><i class="icon-user"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'admin.label')}"])}</span></a></li>
            </sec:access>
            <sec:access controller="teacher">
                <li class="${params.controller == 'teacher'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'teacher')}"><i class="icon-user"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'teacher.label')}"])}</span></a></li>
            </sec:access>
            <sec:access controller="finance">
                <li class="${params.controller == 'finance'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'finance')}"><i class="icon-user"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'finance.label')}"])}</span></a></li>
            </sec:access>
                <sec:access controller="department">
                    <li class="${params.controller == 'department'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'department')}"><i class="icon-user"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'department.label')}"])}</span></a></li>
                </sec:access>


            <li class="nav-header hidden-tablet">
                ${message(code: 'default.manager.label',args: ["${message(code: 'default.menu.sys.label')}"])}
            </li>
            <li class="${params.controller == 'plan'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'plan')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'plan.label')}"])}</span></a></li>
            <li class="${params.controller == 'mediumPlan'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'mediumPlan')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'mediumPlan.label')}"])}</span></a></li>
            <li class="${params.controller == 'preppyPlan'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'preppyPlan')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'preppyPlan.label')}"])}</span></a></li>
            <li class="${params.controller == 'material'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'material')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'material.label')}"])}</span></a></li>
            <li class="${params.controller == 'province'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'province')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'district.label')}"])}</span></a></li>
            <li class="${params.controller == 'nation'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'nation')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'nation.label')}"])}</span></a></li>
            <li class="${params.controller == 'politicalStatus'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'politicalStatus')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'default.manager.label',args: ["${message(code: 'politicalStatus.label')}"])}</span></a></li>
            <li class="${params.controller == 'studentType'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'studentType')}"><i class="icon-flag"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'studentType.label')}"])}</span></a></li>
            <li class="${params.controller == 'middleSchool'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'middleSchool')}"><i class="icon-flag"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'middleSchool.label')}"])}</span></a></li>
                <li class="${params.controller == 'welcome'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'welcome')}"><i class="icon-flag"></i><span class="hidden-tablet"> ${message(code: 'default.manager.label',args: ["${message(code: 'welcome.label')}"])}</span></a></li>
            </sec:ifAllGranted>
            <sec:access controller="download">
                <li class="${params.controller == 'download'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'download')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'download.label',args: ["${message(code: 'finance.label')}"])}</span></a></li>
            </sec:access>
            <sec:access controller="profile"  url="rePassword">
                <li class="${params.controller == 'profile'?'active':''}"><a class="ajax-link" href="${createLink(controller: 'profile',action: 'rePassword')}"><i class="icon-flag"></i><span class="hidden-tablet">  ${message(code: 'operator.changepassword.label')}</span></a></li>
            </sec:access>
        </ul>
        <label id="for-is-ajax" class="hidden-tablet" for="is-ajax"><input id="is-ajax" type="checkbox"> Ajax on menu</label>
    </div><!--/.well -->
</div><!--/span-->
			<!-- left menu ends -->

<noscript>
    <div class="alert alert-block span10">
        <h4 class="alert-heading">Warning!</h4>
        <p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
    </div>
</noscript>