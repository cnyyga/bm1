<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#info"><g:message code="reg.student.info.label"/></a></li>
    <li><a href="#plansInfo"><g:message code="student.plans.label"/></a></li>
    <li><a href="#paymentInfo"><g:message code="student.payment.label"/></a></li>
    <li><a href="#reviewInfo"><g:message code="student.review.label"/></a></li>
</ul>
<div class="tab-content">
    <div class="tab-pane active" id="info">

        <g:render template="infoForm"/>

    </div>
    <div class="tab-pane" id="plansInfo">
        <g:render template="planForm"/>
    </div>
    <div class="tab-pane" id="paymentInfo">
        <g:render template="paymentForm"/>
    </div>
    <div class="tab-pane" id="reviewInfo">
        <g:render template="reviewForm"/>
    </div>
</div>
%{--
<%@ page import="com.baoming.account.Student" %>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${studentInstance?.city?.code}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${studentInstance?.district?.code}" />
<g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${studentInstance?.city?.code}" />

<div class="control-group">
	<label class="control-label" for="username">
		<g:message code="springSecurity.login.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="username"  value="${studentInstance?.username}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="password">
		<g:message code="springSecurity.login.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:passwordField name="password"  value="${studentInstance?.password}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="name">
		<g:message code="student.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="name" maxlength="32"  value="${studentInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="gender">
		<g:message code="student.gender.label" default="Gender" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:select name="gender" from="${com.baoming.account.User$Gender?.values()}" keys="${com.baoming.account.User$Gender.values()*.name()}" optionValue="label"  value="${studentInstance?.gender?.name()}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="student.code.label" default="Code" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="code" maxlength="14" value="${studentInstance?.code}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="admissionTicketNumber">
		<g:message code="student.admissionTicketNumber.label" default="Admission Ticket Number" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="admissionTicketNumber" maxlength="9" value="${studentInstance?.admissionTicketNumber}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="number">
		<g:message code="student.number.label" default="Number" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="number" maxlength="18"  value="${studentInstance?.number}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="birthday">
        <g:message code="student.birthday.label" default="Birthday" />
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">

        <g:textField name="birthdayDate" id="birthday" class="datepicker" value="${studentInstance?.birthday?.format('yyyy-MM-dd')}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="politicalStatus">
		<g:message code="politicalStatus.label" default="Political Status" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:select id="politicalStatus" name="politicalStatus.id" from="${com.baoming.PoliticalStatus.list()}" optionKey="id"  optionValue="name" value="${studentInstance?.politicalStatus?.id}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="nation">
		<g:message code="nation.label" default="Nation" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:select id="nation" name="nation.id" from="${com.baoming.Nation.list()}" optionKey="id" optionValue="name" value="${studentInstance?.nation?.id}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="address">
		<g:message code="student.address.label" default="Address" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
        <g:textField name="address" value="${studentInstance?.address}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="postcode">
		<g:message code="student.postcode.label" default="Postcode" />

	</label>

    <div class="controls">
	<g:textField name="postcode" value="${studentInstance?.postcode}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="tel">
		<g:message code="student.tel.label" default="Tel" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="tel" maxlength="32"  value="${studentInstance?.tel}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="email">
		<g:message code="student.email.label" default="Email" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="email" maxlength="64" value="${studentInstance?.email}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="qq">
		<g:message code="student.qq.label" default="Qq" />

	</label>

    <div class="controls">
	<g:textField name="qq" maxlength="16" value="${studentInstance?.qq}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="district">
		<g:message code="student.district.label" default="District" />
		<span class="required-indicator">*</span>
	</label>

    <div class="controls">
        <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  value="${studentInstance?.province?.code}" class="many-to-one"/>
        <g:select id="city" name="cityId" from="${[]}"  value="${studentInstance?.city?.code}" class="many-to-one"/>
	    <g:select id="district" name="districtId" from="${[]}"  value="${studentInstance?.district?.code}" class="many-to-one"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="middleSchooleId">
        <g:message code="middleSchool.label" default="Middle School" />
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select id="middleSchooleId" name="middleSchool.id" from="${com.baoming.MiddleSchool.list()}" optionKey="id" optionValue="name" value="${studentInstance?.middleSchool?.id}"  noSelection="['null': '']"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="description">
		<g:message code="student.description.label" default="Description" />

	</label>

    <div class="controls">
	<g:textArea name="description" cols="40" rows="5" maxlength="1024" value="${studentInstance?.description}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />

	</label>

    <div class="controls">
	<g:checkBox name="enabled" value="${studentInstance?.enabled}" />
    </div>
</div>

<h3 class="student-split"><g:message code="studentPlans.label" default="专业"/> </h3>
<div class="control-group">
    <label class="control-label" for="studentType.id">
        <g:message code="studentType.label" default="StudentType" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select from="${com.baoming.StudentType.list()}" name="studentType.id" optionKey="id" optionValue="name" value="${studentInstance?.studentType?.id}" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="score">
        <g:message code="student.score.label" default="Score" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="score" value="${studentInstance?.score}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="level">
        <g:message code="student.level.label" default="level" />
    </label>
    <div class="controls">
        <g:textField name="level" value="${studentInstance?.level}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="artsScore">
        <g:message code="student.artsScore.label" default="artsScore" />
    </label>
    <div class="controls">
        <g:textField name="artsScore" value="${studentInstance?.artsScore}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="artsScore">
        <g:message code="student.sportsScore.label" default="sportsScore" />
    </label>
    <div class="controls">
        <g:textField name="sportsScore" value="${studentInstance?.sportsScore}"/>
    </div>
</div>
<g:if test ="${studentInstance && studentInstance?.id}">
    <g:set var="sps" value="${studentInstance?.plans?.collect{it?.id}}"/>
</g:if>
<g:else>
    <g:set var="sps" value="${planIds}"/>
</g:else>
<div class="control-group">
	<label class="control-label" for="planId1">
		<g:message code="student.plans.label" default="Student Plans" />
        <span class="required-indicator">*</span>
	</label>
    <div class="controls">
        <g:select name="planId" id="planId1" data-rel="chosen"  multiple="" value="${sps}" from="${com.baoming.Plan.list()}" optionValue="name" optionKey="id" />
    </div>
</div>

<h3 class="student-split"><g:message code="student.payment.label" default="缴费"/></h3>
<div class="control-group">
    <label class="control-label" for="payment.type">
        <g:message code="student.payment.type.label" default="type" />
    </label>
    <div class="controls">
        <g:select name="payment.type" value="${studentInstance?.payment?.type}" from="${com.baoming.account.Payment.Type.values()}" optionValue="label" noSelection="${['':'未缴费']}" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.name">
        <g:message code="student.payment.name.label" default="name" />
    </label>
    <div class="controls">
        <g:textField name="payment.name" value="${studentInstance?.payment?.name}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.account">
        <g:message code="student.payment.account.label" default="account" />
    </label>
    <div class="controls">
        <g:textField name="payment.account" value="${studentInstance?.payment?.account}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.amount">
        <g:message code="student.payment.amount.label" default="amount" />
    </label>
    <div class="controls">
        <g:textField name="payment.amount" value="${studentInstance?.payment?.amount}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="paymentDate">
        <g:message code="student.payment.date.label" default="date" />
    </label>
    <div class="controls">
        <g:textField name="paymentDate" class="datepicker" value="${studentInstance?.payment?.date?.format('yyyy-MM-dd')}"/>
    </div>
</div>

<sec:ifAnyGranted roles="${com.baoming.account.Role.AUTHORITY_ADMIN},${com.baoming.account.Role.AUTHORITY_FINANCE}">
    <h3 class="student-split"><g:message code="student.review.label" default="Audit"/></h3>

    <div class="control-group">
    <label class="control-label" for="reviewStatus">
        <g:message code="student.review.status.label" default="account" />
    </label>
    <div class="controls">
        <g:select name="reviewStatus" from="${Student.ReviewStatus.values()}" value="${studentInstance?.reviewStatus}" optionValue="label"></g:select>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="reviewDescription">
        <g:message code="student.review.description.label" default="description" />
    </label>
    <div class="controls">
        <g:textArea name="reviewDescription" rows="5" cols="50">
            ${studentInstance?.reviewDescription}</g:textArea>

    </div>
</div>
</sec:ifAnyGranted>

--}%
