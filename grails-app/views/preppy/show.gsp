
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


                    <g:if test="${preppyInstance?.name}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.name.label" default="Name" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${preppyInstance}" field="name"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.number}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.number.label" default="Number" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${preppyInstance}" field="number"/></span>

                            </div>
                        </div>
                    </g:if>

                    <g:if test="${preppyInstance?.gender}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.gender.label" default="Gender" />
                            </label>
                            <div class="controls">

                                <span class="property-value" aria-labelledby="gender-label">${preppyInstance?.gender?.label}</span>

                            </div>
                        </div>
                    </g:if>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.birthday.label" default="Plan" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="plan-label">
                            <g:formatDate format="yyyy-MM-dd" date="${preppyInstance.birthday}"/>
                        </span>

                    </div>
                </div>

                <g:if test="${preppyInstance?.district}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.district.label" default="District" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="district-label">${preppyInstance?.province?.name}${preppyInstance?.city?.name}${preppyInstance?.district?.name}</span>
                        </span>

                        </div>
                    </div>
                </g:if>

                <g:if test="${preppyInstance?.studentDistrict}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="medium.studentDistrict.label" default="Student District" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="studentDistrict-label">
                                ${preppyInstance?.studentProvince?.name}${preppyInstance?.studentCity?.name} ${preppyInstance?.studentDistrict?.name}</span>

                        </div>
                    </div>
                </g:if>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.type.label" default="type" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="gender-label">${preppyInstance?.type?.label}</span>

                    </div>
                </div>



                <g:if test="${preppyInstance?.studentCateories?.name() == Preppy.StudentCateories.SG.name()}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.academicYear.label" default="Plan" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="plan-label">
                                   ${preppyInstance.academicYear?:'未参加'}
                            </span>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.academicScore.label" default="Plan" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="plan-label">
                                <g:set var="academicScore" value="${preppyInstance.academicScore}"  />
                                <g:set var="academicScoreList" value="${academicScore?academicScore.tokenize(','):['A','A','A','A','A','A']}"  />
                                物理${academicScoreList[0]}
                                化学${academicScoreList[1]}
                                生物${academicScoreList[2]}
                                地理${academicScoreList[3]}
                                历史${academicScoreList[4]}
                                政治${academicScoreList[5]}
                            </span>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.skill.label" default="Plan" />
                        </label>
                        <div class="controls">
                            <span class="property-value" aria-labelledby="plan-label">
                                ${preppyInstance.skill?.label}
                            </span>

                        </div>
                    </div>
                </g:if>
                <g:else>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.schoolType.label" default="schoolType" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="gender-label">${preppyInstance?.schoolType?.label}</span>

                        </div>
                    </div>
                </g:else>

                <g:if test="${preppyInstance?.studentCateories?.name() == Preppy.StudentCateories.WG.name()}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.middlePlan.label" default="type" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="gender-label">${preppyInstance?.middlePlan}</span>

                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppyPlan.label" default="type" />
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="gender-label">

                                <%
                                       try{
                                           preppyInstance.preppyPlan.name
                                       }catch(Exception e){}
                                    %>
                            </span>

                        </div>
                    </div>
                </g:if>
                    
                    <g:if test="${preppyInstance?.plan}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="preppy.plan.label" default="Plan" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="plan-label"><g:link controller="plan" action="show" id="${preppyInstance?.plan?.id}">${preppyInstance?.plan?.name}</g:link></span>
                            
                        </div>
                    </div>
                    </g:if>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.deposit.label" default="Plan" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="plan-label">
                            ${preppyInstance?.deposit}
                        </span>

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.phone.label" default="Plan" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="plan-label">
                            ${preppyInstance?.phone}
                        </span>

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.parentPhone.label" default="Plan" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="plan-label">
                            ${preppyInstance?.parentPhone}
                        </span>

                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="preppy.address.label" default="Plan" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="plan-label">
                            ${preppyInstance?.address}
                        </span>

                    </div>
                </div>
                    

                <g:if test="${preppyInstance?.studentCateories}">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="studentType.label"/>
                        </label>
                        <div class="controls">

                            <span class="property-value" aria-labelledby="qq-label">${preppyInstance?.studentCateories?.label}</span>

                        </div>
                    </div>
                </g:if>
                    <sec:ifAllGranted roles="ROLE_ADMIN">
                        <g:if test="${preppyInstance?.reviewStatus}">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="medium.reviewStatus.label" default="Review Status" />
                                </label>
                                <div class="controls">

                                    <span class="property-value" aria-labelledby="reviewStatus-label">${preppyInstance.reviewStatus?.label}</span>

                                </div>
                            </div>
                        </g:if>



                        <g:if test="${preppyInstance?.reviewPerson}">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="medium.reviewPerson.label" default="Review Person" />
                                </label>
                                <div class="controls">

                                    <span class="property-value" aria-labelledby="reviewPerson-label">
                                        ${preppyInstance?.reviewPerson?.name}</span>

                                </div>
                            </div>
                        </g:if>
                        <g:if test="${preppyInstance?.reviewDate}">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="medium.reviewDate.label" default="Review Date" />
                                </label>
                                <div class="controls">

                                    <span class="property-value" aria-labelledby="reviewDate-label"><g:formatDate date="${preppyInstance?.reviewDate}" format="yyyy-MM-dd HH:mm:ss" /></span>

                                </div>
                            </div>
                        </g:if>
                        <%
                            def ttt
                            try {
                                ttt = preppyInstance?.teacher
                            } catch (Exception e) {

                            }
                            %>
                    <g:if test="${ttt}">
                        <div class="control-group">
                            <label class="control-label">
                                <g:message code="preppy.teacher.label" default="Teacher" />
                            </label>
                            <div class="controls">
                                <span class="property-value" aria-labelledby="teacher-label"><g:link controller="teacher" action="show" id="${ttt?.id}">${ttt?.name}</g:link></span>
                            </div>
                        </div>
                    </g:if>
                        </sec:ifAllGranted>
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="dateCreated" />
                        </label>
                        <div class="controls">
                            <span class="property-value" aria-labelledby="teacher-label"><g:formatDate
                                    date="${preppyInstance?.dateCreated}" format="yyyy-MM-dd HH:mm"/></span>
                        </div>
                    </div>

                    <div class="form-actions">
                        <sec:ifNotGranted roles="${Role.AUTHORITY_FINANCE}">
                        <g:form>
                                <g:hiddenField name="id" value="${preppyInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${preppyInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                            <g:hiddenField name="act" value="1" />
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                            </sec:ifNotGranted>
                    </div>
                </fieldset>
                    </div>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
