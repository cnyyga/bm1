
<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <style type="text/css">
        span.property-value{
            display: block;
            padding-top: 5px;
        }
            .controls{
                padding-top: 5px;
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

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> <g:message code="default.show.label" args="[entityName]" /></h2>
            </div>
            <div class="box-content">
                <div class="form-horizontal">
                <fieldset>

                <div class="control-group">
                    <label class="control-label" for="name">
                        <g:message code="preppy.name.label" default="Name" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.name}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="number">
                        <g:message code="preppy.number.label" default="Number" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.number}
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label" for="deposit">
                        <g:message code="preppy.deposit.label" default="deposit" />
                    </label>

                    <div class="controls">
                        ${preppyInstance?.deposit}  元
                    </div>
                </div>

                    <div class="control-group">
                        <label class="control-label" for="family"><g:message code="preppy.family.label"/> 
                        </label>

                        <div class="controls">
                            ${preppyInstance?.family?.label}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="studentCateories"><g:message code="preppy.studentCateories.label"/> 
                        </label>

                        <div class="controls">
                            ${preppyInstance?.studentCateories?.label}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="gender">
                            <g:message code="preppy.gender.label" default="Gender" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.gender?.label}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="gender">
                            <g:message code="nation.label" default="nation" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.nation?.name}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="birthday">
                            <g:message code="preppy.birthday.label" default="birthday" />
                        </label>

                        <div class="controls">
                            <g:formatDate date="${preppyInstance?.birthday}" format="yyyy-MM-dd"/>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="district">
                            <g:message code="medium.district.label" default="District" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.province?.name}${preppyInstance?.city?.name}${preppyInstance?.district?.name}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="address">
                            <g:message code="preppy.address.label" default="Tel" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.address}
                        </div>
                    </div>
                    <div class="control-group ">
                        <label class="control-label" for="planId">
                            <g:message code="preppy.plan.label" default="Plan" />
                        </label>

                        <div class="controls plan-area">
                            ${preppyInstance?.plan?.name}
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="phone">
                            <g:message code="preppy.phone.label" default="Phone" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.phone}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="parentPhone">
                            <g:message code="preppy.parentPhone.label" default="parentPhone" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.parentPhone}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="parentPhone">
                            <g:message code="preppy.qq.label" default="qq" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.qq}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.resume.label" default="qq" />
                        </label>
                        <div class="controls">
                            <div>
                                <g:message code="preppy.resume.junior.label"/>
                                <g:formatDate format="yyyy年MM月" date="${preppyInstance?.resume?.juniorStart}"/>起--
                                <g:formatDate format="yyyy年MM月" date="${preppyInstance?.resume?.juniorEnd}"/>
                                ${preppyInstance?.resume?.juniorSchool}&nbsp;${preppyInstance?.resume?.juniorAuthenticator}
                            </div>
                            <div>
                                <g:message code="preppy.resume.high.label"/>
                                <g:formatDate format="yyyy年MM月" date="${preppyInstance?.resume?.highStart}"/>起--
                                <g:formatDate format="yyyy年MM月" date="${preppyInstance?.resume?.highEnd}"/>
                                ${preppyInstance?.resume?.highSchool}&nbsp;${preppyInstance?.resume?.highAuthenticator}
                            </div>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="reviewStatus">
                            <g:message code="preppy.reviewStatus.label" default="ReviewStatus" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.reviewStatus?.label}
                        </div>
                    </div>

                    <div class="control-group zhongzhi">
                        <label class="control-label" for="collegeSignUp">
                            高考报名地
                        </label>

                        <div class="controls">
                            ${preppyInstance?.collegeSignUp?.label}
                        </div>
                    </div>

                    <div class="control-group zhongzhi">
                        <label class="control-label" for="preppyPlan">
                            <g:message code="preppyPlan.label" default="preppyPlan" />
                        </label>

                        <div class="controls">
                            ${preppyInstance.preppyPlan?.name}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />1
                        </label>
                        <div class="controls">
                            ${preppyInstance?.remark}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />2
                        </label>
                        <div class="controls">
                            ${preppyInstance?.remark1}
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label" for="remark">
                            <g:message code="preppy.remark.label" default="remark" />3
                        </label>
                        <div class="controls">
                            ${preppyInstance?.remark2}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label" for="combobox">
                            <g:message code="preppy.teacher.label" default="Teacher" />
                        </label>

                        <div class="controls">
                            ${preppyInstance?.teacher?.name}
                        </div>
                    </div>
                    <g:if test="${preppyInstance?.code}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.code.label" default="code" />
                        </label>
                        <div class="controls">
                            ${preppyInstance?.code}
                        </div>
                    </div>
                    </g:if>
<g:if test="${preppyInstance?.csCode}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.csCode.label" default="code" />
                        </label>
                        <div class="controls">
                            ${preppyInstance?.csCode}
                        </div>
                    </div>  </g:if>
                    <div class="form-actions">
                        <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                                <g:hiddenField name="id" value="${preppyInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${preppyInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                            <g:hiddenField name="act" value="1" />
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}">
                                    <i class="icon-zoom-in  icon-white"></i>
                                    <g:message code="default.button.print.label" default="Xy" />
                                </g:link>
                         </sec:ifNotGranted>
                        <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
                            <g:if test="${preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">
                                <g:link class="btn btn-success" action="xy1" id="${preppyInstance.id}">
                                    <i class="icon-zoom-in  icon-white"></i>
                                    <g:message code="default.button.preview.label" default="Xy" />
                                </g:link>
                            </g:if>
                            <g:else>
                                <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}">
                                    <i class="icon-zoom-in  icon-white"></i>
                                    <g:message code="default.button.print.label" default="Xy" />
                                </g:link>
                            </g:else>
                        </sec:ifAllGranted>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
