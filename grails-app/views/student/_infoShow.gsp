<div class="form-horizontal">
<fieldset>
<div class="control-group">
    <label class="control-label">
        <g:message code="springSecurity.login.username.label" default="用户名"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="username-label"><g:fieldValue bean="${studentInstance}"
                                                                                    field="username"/></span>

    </div>
</div>

<div class="control-group" style="display: none">
    <label class="control-label">
        <g:message code="springSecurity.login.password.label" default="密码"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="password-label"><g:fieldValue bean="${studentInstance}"
                                                                                    field="password"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.name.label" default="姓名"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${studentInstance}"
                                                                                field="name"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.gender.label" default="性别"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="gender-label">${studentInstance?.gender?.label}</span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.code.label" default="考生号"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${studentInstance}"
                                                                                field="code"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.admissionTicketNumber.label" default="准考证号"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="admissionTicketNumber-label"><g:fieldValue
                bean="${studentInstance}" field="admissionTicketNumber"/></span>

    </div>
</div>


<div class="control-group">
    <label class="control-label">
        <g:message code="student.number.label" default="身份证号"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${studentInstance}"
                                                                                  field="number"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.birthday.label" default="出生年月"/>
    </label>

    <div class="controls">

        <span class="property-value"
              aria-labelledby="birthday-label">${studentInstance?.birthday?.format('yyyy-MM-dd')}</span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="politicalStatus.label" default="政治面貌"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="politicalStatus-label">
            ${studentInstance?.politicalStatus?.name}
        </span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="nation.label" default="Nation"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="nation-label">
            ${studentInstance?.nation?.name}</span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="district.label" default="District"/>
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
        <g:message code="middleSchool.label" default="Middle School"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="middleSchool-label">${studentInstance?.middleSchool?.name}</span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.address.label" default="Address"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${studentInstance}"
                                                                                   field="address"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.postcode.label" default="Postcode"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="postcode-label"><g:fieldValue bean="${studentInstance}"
                                                                                    field="postcode"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.tel.label" default="Tel"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${studentInstance}"
                                                                               field="tel"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.phone.label" default="phone"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="tel-label"><g:fieldValue bean="${studentInstance}"
                                                                               field="phone"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.email.label" default="Email"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="email-label"><g:fieldValue bean="${studentInstance}"
                                                                                 field="email"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.qq.label" default="Qq"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="qq-label"><g:fieldValue bean="${studentInstance}"
                                                                              field="qq"/></span>

    </div>
</div>



<div class="control-group">
    <label class="control-label">
        <g:message code="user.enabled.label" default="Enabled"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="enabled-label"><g:formatBoolean
                boolean="${studentInstance?.enabled}"/></span>

    </div>
</div>


<div class="control-group">
    <label class="control-label">
        <g:message code="default.dateCreated.label" default="Date Created"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                date="${studentInstance?.dateCreated}" format="yyyy-MM-dd"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.recommend.teacher.label" default="Date Created"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="dateCreated-label">
            ${studentInstance?.teacher?.name}
        </span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.description.label" default="Description"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${studentInstance}"
                                                                                       field="description"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.admissionTicketNumber.pic.label" default="Pic"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="description-label">
            <g:if test="${studentInstance?.admissionTicketPic}">
                <div style="position: relative;height: 100px;">
                    <g:link action="img"  controller="api" id="${studentInstance?.admissionTicketPic}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.admissionTicketPic)}" title="点击查看原图" style="height: 100px;" />
                    </g:link>
                </div>
            </g:if>
        </span>

    </div>
</div>
</fieldset></div>