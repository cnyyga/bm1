<%@ page import="com.baoming.account.Student" %>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${studentInstance?.city?.code}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${studentInstance?.district?.code}" />
<g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${studentInstance?.middleSchool?.id}" />

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
	<g:select id="politicalStatus" name="politicalStatus.id" from="${com.baoming.PoliticalStatus.list()}" optionKey="id"  optionValue="name" value="${studentInstance?.politicalStatus?.id}" noSelection="['': '请选择']" />
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="nation">
		<g:message code="nation.label" default="Nation" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:select id="nation" name="nation.id" from="${com.baoming.Nation.list()}" optionKey="id" optionValue="name" value="${studentInstance?.nation?.id}" noSelection="['': '请选择']"  />
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="address">
		<g:message code="student.address.label" default="Address" />
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
	</label>

    <div class="controls">
	<g:textField name="tel" maxlength="32"  value="${studentInstance?.tel}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="tel">
        <g:message code="student.phone.label" default="phone" />
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:textField name="phone" maxlength="11"  value="${studentInstance?.phone}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="email">
		<g:message code="student.email.label" default="Email" />
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
        <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  value="${studentInstance?.province?.code}" noSelection="['': '请选择']" class="many-to-one"/>
        <g:select id="city" name="cityId" from="${[]}"  value="${studentInstance?.city?.code}" class="many-to-one"/>
	    <g:select id="district" name="districtId" from="${[]}"  value="${studentInstance?.district?.code}" class="many-to-one"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="middleSchooleId">
        <g:message code="middleSchool.label" default="Middle School" />
    </label>

    <div class="controls">
        <g:select id="middleSchooleId" name="middleSchoolId" from="${com.baoming.MiddleSchool.list()}" optionKey="id" optionValue="name" value="${studentInstance?.middleSchool?.id}"  noSelection="['null': '']"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
		
	</label>

    <div class="controls">
	<g:checkBox name="enabled" value="${studentInstance?.enabled?:true}" />
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="combobox">
        <g:message code="student.recommend.teacher.label" default="Description" />
    </label>

    <div class="controls">
        %{--<g:select name="teacherId" from="${teachers}" data-rel="chosen" optionValue="name" optionKey="id"  value="${studentInstance?.teacher?.id}"  noSelection="${['':'请选择']}"/>--}%
        <div class="ui-widget">
            <select id="combobox" name="teacherId">
                <option value="">请选择</option>
                <g:each in="${teachers}" var="teah">
                    <g:if test="${studentInstance?.teacher?.id == teah.id}">
                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" selected="true" >${teah.name}</option>
                    </g:if>
                    <g:else>
                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" >${teah.name}</option>
                    </g:else>
                </g:each>
            </select>
        </div>

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
    <label class="control-label" for="admissionTicketPicInp">
        <g:message code="student.admissionTicketNumber.pic.label" default="admissionTicketNumberPic" />
    </label>

    <div class="controls">
        <g:if test="${studentInstance?.admissionTicketPic}">
            <div style="position: relative;height: 100px;">
            <g:link action="img"  controller="api" id="${studentInstance?.admissionTicketPic}"  target="_blank">
                <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.admissionTicketPic)}" title="点击查看原图" style="height: 100px;" />
                <a href="javascript:void 0" class="admissionTicketPic-del-pic"><g:message code="default.button.delete.label"/></a>
            </g:link>
            </div>
        </g:if>
        <g:hiddenField name="admissionTicketPic" value="${studentInstance?.admissionTicketPic}"/>
            <input type="file" name="admissionTicketPicInp" id="admissionTicketPicInp" /> <g:message code="student.admissionTicketNumber.pic.message"/>
    </div>
</div>



