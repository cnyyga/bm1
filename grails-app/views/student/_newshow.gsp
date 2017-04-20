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

<g:if test="${studentInstance.studentCateories}">
<div class="control-group">
    <label class="control-label">
        考生类型
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="name-label">
            ${studentInstance.studentCateories?.label}
        </span>

    </div>
</div>
</g:if>

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
            <%
                try {
                    out.print(studentInstance?.province?.name)
                } catch (Exception e) {
                }
                try {
                    out.print(studentInstance?.city?.name)
                } catch (Exception e) {
                }
                try {
                    out.print(studentInstance?.district?.name)
                } catch (Exception e) {
                }
                try {
                    out.print(studentInstance?.middleSchool?.name)
                } catch (Exception e) {
                }
                %>
            </span>

    </div>
</div>
%{--
<div class="control-group">
    <label class="control-label">
        <g:message code="middleSchool.label" default="Middle School"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="middleSchool-label">
            <%
                try {
                    out.print(studentInstance?.middleSchool?.name)
                } catch (Exception e) {
                }%>
            </span>

    </div>
</div>
--}%
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
            <g:message code="student.qq.label" default="Qq"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="qq-label"><g:fieldValue bean="${studentInstance}"
                                                                                  field="qq"/></span>

        </div>
    </div>


    <div class="control-group">
        <label class="control-label">
            <g:message code="studentType.label" default="StudentType" />
        </label>
        <div class="controls">
            <span class="property-value" aria-labelledby="middleSchool-label">
                <%
                    try {
                        out.print(studentInstance?.studentType?.name)
                    } catch (Exception e) {
                    }%>

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
                    <%
                        try {
                            out.print(plan?.name)
                        } catch (Exception e) {
                        }%>
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
                ${studentInstance?.payment?.type?.label?:"未缴费"}
            </span>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">
            <g:message code="student.payment.amount.label" default="type" />
        </label>
        <div class="controls">
            <span class="property-value">
                ${studentInstance?.payment?.amount}
            </span>
        </div>
    </div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.cardNo.pic.label" default="Pic"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="description-label">
            <g:if test="${studentInstance?.cardNoPic}">
                <div style="position: relative;height: 100px;">
                    <g:link action="img"  controller="api" id="${studentInstance?.cardNoPic}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.cardNoPic)}" title="点击查看原图" style="height: 100px;" />
                    </g:link>
                </div>
            </g:if>
        </span>

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
            <g:message code="student.agreement.pic.label" default="Pic"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="description-label">
                <g:if test="${studentInstance?.agreementPic}">
                    <div style="position: relative;height: 100px;">
                        <g:link action="img"  controller="api" id="${studentInstance?.agreementPic}"  target="_blank">
                            <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.agreementPic)}" title="点击查看原图" style="height: 100px;" />
                        </g:link>
                    </div>
                </g:if>
            </span>

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">
            <g:message code="student.payment.docPic.label" default="Pic"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="description-label">
                <g:if test="${studentInstance?.payment?.docPic}">
                    <div style="position: relative;height: 100px;">
                        <g:link action="img"  controller="api" id="${studentInstance?.payment?.docPic}"  target="_blank">
                            <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.payment?.docPic)}" title="点击查看原图" style="height: 100px;" />
                        </g:link>
                    </div>
                </g:if>
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
            <g:message code="student.recommend.teacher.label" default="recommend"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="dateCreated-label">
<%     try {
    out.print(studentInstance.teacher?.name)
}catch (Exception e){}%>


            </span>

        </div>
    </div>


    <div class="control-group">
        <label class="control-label">
            <g:message code="default.dateCreated.label" default="Date Created"/>
        </label>

        <div class="controls">

            <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate
                    date="${studentInstance?.dateCreated}" format="yyyy-MM-dd HH:mm"/></span>

        </div>
    </div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.admission.label" default="admission"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="dateCreated-label">
            ${studentInstance.admission?.label?: com.baoming.account.Student.Admission.NO.label}
        </span>

    </div>
</div>

<div class="control-group">
    <label class="control-label">
        <g:message code="student.registration.label" default="registration"/>
    </label>

    <div class="controls">

        <span class="property-value" aria-labelledby="dateCreated-label">${studentInstance.registration?.label?: com.baoming.account.Student.Registration.NO.label}</span>

    </div>
</div>

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

            <%     try {
                out.print(studentInstance.reviewPerson?.username)
            }catch (Exception e){}%>
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
</fieldset></div>