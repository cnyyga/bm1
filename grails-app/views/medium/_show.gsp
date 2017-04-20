<%@ page import="com.baoming.account.Role" %>
<div class="form-horizontal">
    <fieldset>

        <g:if test="${mediumInstance?.name}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.name.label" default="Name" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${mediumInstance}" field="name"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.code}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.code.label" default="Code" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${mediumInstance}" field="code"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.number}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.number.label" default="Number" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${mediumInstance}" field="number"/></span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.gender}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.gender.label" default="Gender" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="gender-label">${mediumInstance.gender?.label}</span>

                </div>
            </div>
        </g:if>

            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.secondaryPlan.label" default="Medium Plan" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="mediumPlan-label">${mediumInstance?.secondaryPlan}</span>

                </div>
            </div>

        <g:if test="${mediumInstance?.mediumPlan}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.mediumPlan.label" default="Medium Plan" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="mediumPlan-label">${mediumInstance?.mediumPlan?.name}</span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.plan}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.plan.label" default="Plan" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="plan-label">${mediumInstance?.plan?.name}</span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.teacher}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.teacher.label" default="Teacher" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="teacher-label">
                        <%
                            try {
                                out.print(mediumInstance.teacher?.name)
                            }catch (Exception e){}

                        %>
                    </span>

                </div>
            </div>
        </g:if>
        <g:if test="${mediumInstance?.district}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.district.label" default="District" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="district-label">${mediumInstance?.province?.name}${mediumInstance?.city?.name}${mediumInstance?.district?.name}</span>
                </span>

                </div>
            </div>
        </g:if>

        <g:if test="${mediumInstance?.studentDistrict}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.studentDistrict.label" default="Student District" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="studentDistrict-label">
                        <%
                            try {
                                out.print(mediumInstance?.studentProvince?.name)
                            } catch (Exception e) {
                            }
                            try {
                                out.print(mediumInstance?.studentCity?.name)
                            } catch (Exception e) {
                            }
                            try {
                                out.print(mediumInstance?.studentDistrict?.name)
                            } catch (Exception e) {
                            }
                        %>
                    </span>

                </div>
            </div>
        </g:if>

        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.qq.label" default="qq" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${mediumInstance}" field="qq"/></span>

            </div>
        </div>


        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.phone.label" default="phone" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="number-label"><g:fieldValue bean="${mediumInstance}" field="phone"/></span>

            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="gender">
                <g:message code="medium.depositType.label" default="Gender" />
            </label>

            <div class="controls">
                ${mediumInstance?.depositType?.label}
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="gender">
                <g:message code="medium.deposit.label" default="Gender" />
            </label>

            <div class="controls">
                ${mediumInstance?.deposit}
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.cardNoPath.label" default="Voucher Path" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="cardNoPath-label">
                    <g:link action="img"  controller="api" id="${mediumInstance?.cardNoPath}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.cardNoPath)}" style="height: 100px;"/>
                    </g:link>
                </span>

            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.admissionPath.label" default="Voucher Path" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="admissionPath-label">
                    <g:link action="img"  controller="api" id="${mediumInstance?.admissionPath}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.admissionPath)}" style="height: 100px;"/>
                    </g:link>
                </span>

            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.voucherPath.label" default="Voucher Path" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="voucherPath-label">
                    <g:link action="img"  controller="api" id="${mediumInstance?.voucherPath}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.voucherPath)}" style="height: 100px;"/>
                    </g:link>
                </span>

            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.agreementPath.label" default="Voucher Path" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="agreementPath-label">
                    <g:link action="img"  controller="api" id="${mediumInstance?.agreementPath}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.agreementPath)}" style="height: 100px;"/>
                    </g:link>
                </span>

            </div>
        </div>
    %{--
        <g:if test="${mediumInstance?.admission}">
        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.admission.label" default="Admission" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="admission-label">${mediumInstance.admission?.label}</span>

            </div>
        </div>
        </g:if>

        <g:if test="${mediumInstance?.registration}">
        <div class="control-group">
            <label class="control-label">
                <g:message code="medium.registration.label" default="Registration" />
            </label>
            <div class="controls">

                <span class="property-value" aria-labelledby="registration-label">${mediumInstance.registration?.label}</span>

            </div>
        </div>
        </g:if>--}%

        <g:if test="${mediumInstance?.reviewStatus}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.reviewStatus.label" default="Review Status" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="reviewStatus-label">${mediumInstance.reviewStatus?.label}</span>

                </div>
            </div>
        </g:if>



        <g:if test="${mediumInstance?.reviewPerson}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.reviewPerson.label" default="Review Person" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="reviewPerson-label">
                        ${mediumInstance?.reviewPerson?.name}</span>

                </div>
            </div>
        </g:if>
        <g:if test="${mediumInstance?.reviewDate}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.reviewDate.label" default="Review Date" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="reviewDate-label"><g:formatDate date="${mediumInstance?.reviewDate}" format="yyyy-MM-dd HH:mm:ss" /></span>

                </div>
            </div>
        </g:if>
        <g:if test="${mediumInstance?.description}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="medium.description.label" default="Description" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${mediumInstance}" field="description"/></span>

                </div>
            </div>
        </g:if>


        <g:if test="${mediumInstance?.dateCreated}">
            <div class="control-group">
                <label class="control-label">
                    <g:message code="default.dateCreated.label" default="Date Created" />
                </label>
                <div class="controls">

                    <span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${mediumInstance?.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></span>

                </div>
            </div>
        </g:if>

    </fieldset>
</div>