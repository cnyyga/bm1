
<%@ page import="com.baoming.account.Role; com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'student.label', default: 'Student')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>

        <style type="text/css">
        span.property-value{
            display: block;
            padding-top: 5px;
        }
        </style>
        <script>
            $(function () {

                $('#myTab').tab('show');
                <g:if test="${params.t}">
                    $('#myTab a:last').tab('show')  ;
                </g:if>
                <g:else>
                    $('#myTab a:first').tab('show')  ;
                </g:else>
                $(".payment-del-pic").click(function(){
                    var t = $(this);
                    var parent = t.parent()
                    var url = t.attr("rel")
                    $.get(url,function(data){
                        if(data.status == 1){
                            parent.empty();
                            parent.append("<span class='label label-success'>删除成功</span>");
                            return
                        }
                        parent.append("<span class='label label-warning'>删除失败</span>");
                    },'json')
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
            <div class="box-content ">
            <ul id="myTab" class="nav nav-tabs">
                <li class="active"><a href="#info"><g:message code="reg.student.info.label"/></a></li>
                <li><a href="#plansInfo"><g:message code="student.plans.label"/></a></li>
                <li><a href="#paymentInfo"><g:message code="student.payment.label"/></a></li>
                <li><a href="#reviewInfo"><g:message code="student.review.label"/></a></li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane active" id="info">

                    <g:render template="infoShow"/>

                </div>
                <div class="tab-pane" id="plansInfo">
                    <g:render template="planShow"/>
                </div>
                <div class="tab-pane" id="paymentInfo">
                    <g:render template="paymentShow"/>
                </div>
                <div class="tab-pane" id="reviewInfo">
                    <g:if test="${params.t}">
                        <g:form action="audit">
                            <g:hiddenField name="id" value="${studentInstance?.id}" />
                            <fieldset>
                        <g:render template="reviewForm"/>
                                <div class="form-actions">
                                    <button type="submit" class="btn btn-primary">
                                        <g:message code="default.button.update.label" default="Save changes" />
                                    </button>
                                </div>
                            </fieldset>

                        </g:form>

                    </g:if>
                    <g:else>
                        <g:render template="reviewShow"/>
                    </g:else>
                </div>
            </div>
               %{-- <div class="form-horizontal">
                <fieldset>
                    
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="springSecurity.login.username.label" default="用户名" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${studentInstance}" field="username"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group" style="display: none">
                        <label class="control-label">
                            <g:message code="springSecurity.login.password.label" default="密码" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${studentInstance}" field="password"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.name.label" default="姓名" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${studentInstance}" field="name"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.gender.label" default="性别" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="gender-label">${studentInstance?.gender?.label}</span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.code.label" default="考生号" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${studentInstance}" field="code"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.admissionTicketNumber.label" default="准考证号" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="admissionTicketNumber-label"><g:fieldValue bean="${studentInstance}" field="admissionTicketNumber"/></span>
                            
                        </div>
                    </div>


                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.number.label" default="身份证号" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${studentInstance}" field="number"/></span>
                            
                        </div>
                    </div>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.birthday.label" default="出生年月" />
                    </label>
                    <div class="controls">

                        <span class="property-value" aria-labelledby="birthday-label">${studentInstance?.birthday?.format('yyyy-MM-dd')}</span>

                    </div>
                </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="politicalStatus.label" default="政治面貌" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="politicalStatus-label">
                                ${studentInstance?.politicalStatus?.name}
                            </span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="nation.label" default="Nation" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="nation-label">
                                ${studentInstance?.nation?.name}</span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.address.label" default="Address" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${studentInstance}" field="address"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.postcode.label" default="Postcode" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="postcode-label"><g:fieldValue bean="${studentInstance}" field="postcode"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.tel.label" default="Tel" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${studentInstance}" field="tel"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.email.label" default="Email" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${studentInstance}" field="email"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.qq.label" default="Qq" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="qq-label"><g:fieldValue bean="${studentInstance}" field="qq"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="middleSchool.label" default="Middle School" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="middleSchool-label">${studentInstance?.middleSchool?.name}</span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="district.label" default="District" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="district-label">
                                ${studentInstance?.province?.name}
                                ${studentInstance?.city?.name}
                                ${studentInstance?.district?.name}</span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.description.label" default="Description" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${studentInstance}" field="description"/></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.accountExpired.label" default="Account Expired" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="accountExpired-label"><g:formatBoolean boolean="${studentInstance?.accountExpired}" /></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.accountLocked.label" default="Account Locked" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="accountLocked-label"><g:formatBoolean boolean="${studentInstance?.accountLocked}" /></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="default.dateCreated.label" default="Date Created" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${studentInstance?.dateCreated}" format="yyyy-MM-dd" /></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.enabled.label" default="Enabled" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean boolean="${studentInstance?.enabled}" /></span>
                            
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="user.passwordExpired.label" default="Password Expired" />
                        </label>
                        <div class="controls">
                            
                            <span class="property-value" aria-labelledby="passwordExpired-label"><g:formatBoolean boolean="${studentInstance?.passwordExpired}" /></span>
                            
                        </div>
                    </div>

                <h3 class="student-split"><g:message code="studentPlans.label" default="专业"/> </h3>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="studentType.label" default="StudentType" />
                    </label>
                    <div class="controls">
                        <span class="property-value" aria-labelledby="middleSchool-label">
                            ${studentInstance?.studentType?.name}
                        </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" >
                        <g:message code="student.score.label" default="Score" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.score}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" >
                        <g:message code="student.level.label" default="level" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                       ${studentInstance?.level}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.artsScore.label" default="artsScore" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.artsScore}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.sportsScore.label" default="sportsScore" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.sportsScore}
                            </span>
                    </div>
                </div>

                <g:each in="${studentInstance.plans}" var="plan" status="i">
                    <div class="control-group">
                        <label class="control-label">
                            <g:message code="student.plans.label" default="Student Plans" />${i+1}
                        </label>
                        <div class="controls">
                            <span class="property-value">
                            ${plan.name}
                                </span>
                        </div>
                    </div>
                </g:each>

                <h3 class="student-split"><g:message code="student.payment.label" default="缴费"/></h3>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.payment.type.label" default="type" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.payment?.type?.label}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" >
                        <g:message code="student.payment.name.label" default="name" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                       ${studentInstance?.payment?.name}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.payment.account.label" default="account" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                       ${studentInstance?.payment?.account}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.payment.amount.label" default="amount" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                       ${studentInstance?.payment?.amount}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.payment.date.label" default="date" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                       ${studentInstance?.payment?.date?.format('yyyy-MM-dd')}
                            </span>
                    </div>
                </div>
                <h3 class="student-split"><g:message code="student.review.label" default="Audit"/></h3>

                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.review.status.label" default="status" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.reviewStatus?.label}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.review.user.label" default="user" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.reviewPerson?.username}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.review.date.label" default="date" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                        ${studentInstance?.reviewDate?.format('yyyy-MM-dd HH:mm:ss')}
                            </span>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">
                        <g:message code="student.review.description.label" default="description" />
                    </label>
                    <div class="controls">
                        <span class="property-value">
                            ${studentInstance?.reviewDescription}
                        </span>
                    </div>
                </div>

                    <div class="form-actions">
                        <g:form>
                                <g:hiddenField name="id" value="${studentInstance?.id}" />
                                <g:link class="btn btn-info" action="edit" id="${studentInstance?.id}">
                                    <i class="icon-edit icon-white"></i>
                                    <g:message code="default.button.edit.label" default="Edit" />
                                </g:link>
                                <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </div>
                </fieldset>
            </div>--}%
<sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
            <div class="form-actions">
                <g:form>
                    <g:hiddenField name="id" value="${studentInstance?.id}" />
                    <g:link class="btn btn-info" action="edit" id="${studentInstance?.id}">
                        <i class="icon-edit icon-white"></i>
                        <g:message code="default.button.edit.label" default="Edit" />
                    </g:link>
                    <g:hiddenField name="act" value="1" />
                    <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                </g:form>
            </div>
    </sec:ifAllGranted>
            </div>
        </div><!--/span-->

    </div><!--/row-->

	</body>
</html>
