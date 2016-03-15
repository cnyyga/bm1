<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
        <g:javascript src="jquery.validate.min.js"/>
        <g:javascript src="additional-methods.js"/>
        <g:javascript src="messages_zh.js"/>
        <g:javascript src="tj.js"/>
        <g:javascript src="app-preppy.js"/>
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
        .tab-content {
            overflow: visible;
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
                    <g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link>
                </li>
            </ul>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
        </g:if>
        <g:hasErrors bean="${preppyInstance}">
            <ul class="alert alert-error" >
                <g:eachError bean="${preppyInstance}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>

        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-edit"></i> <g:message code="default.edit.label" args="[entityName]" /></h2>
                </div>
                <div class="box-content">
                    <g:uploadForm class="form-horizontal" action="update" >
                    <g:hiddenField name="id" value="${preppyInstance?.id}" />
                    <g:hiddenField name="version" value="${preppyInstance?.version}" />
                    <fieldset>
                        <g:render template="form"/>
                        %{--<div class="control-group">
                        <label class="control-label red" style="padding-left:140px;" >
                            <%
                                def cal = Calendar.instance
                                def year = cal.get(Calendar.YEAR)
                            %>
                            <g:set var="thisYear" value="${year}"/>
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
                        </label>

                        </div>--}%
                        <div class="form-actions">

                            <sec:ifNotGranted roles="${Role.AUTHORITY_TEACHER}">

                                <button type="submit" class="btn btn-primary">保存<g:message code="preppy.label" /> </button>
                            </sec:ifNotGranted>
                            <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
                                <g:if test="${!preppyInstance.reviewStatus || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">
                                    <button type="submit" class="btn btn-primary"><g:message code="default.button.update.label" /> </button>

                                </g:if>
                            </sec:ifAllGranted>
                            <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}">
                                <i class="icon-zoom-in  icon-white"></i>
                                <g:message code="default.button.print.label" default="Xy" />
                            </g:link>

                    </div>
                    </fieldset>
                    </g:uploadForm>

                </div>
            </div><!--/span-->

        </div><!--/row-->

	</body>
</html>
