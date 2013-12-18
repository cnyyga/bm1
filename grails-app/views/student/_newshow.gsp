<div class="form-horizontal">
<fieldset>

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
        <g:message code="student.number.label" default="身份证号"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${studentInstance}"
                                                                                  field="number"/></span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.district.label" default="District"/>
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

    <div class="control-group">
        <label class="control-label">
            <g:message code="student.recommend.teacher.label" default="recommend"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="dateCreated-label">
                ${studentInstance?.teacher?.name}
            </span>

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
</fieldset></div>