<%@ page import="com.baoming.account.Teacher; com.baoming.Plan" %>


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
            <label class="control-label" for="number">
                <g:message code="student.number.label" default="Number" />
                <span class="required-indicator">*</span>
            </label>

            <div class="controls">
                <g:textField name="number" maxlength="18"  value="${studentInstance?.number}"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="district">
                <g:message code="student.district.label" default="District" />
                <span class="required-indicator">*</span>
            </label>

            <div class="controls">
                <g:select id="province" name="provinceId" from="${provinces}" optionValue="name" optionKey="code"  value="${studentInstance?.province?.code?:params.provinceId}" noSelection="['': '请选择']" class="many-to-one"/>
                <g:select id="city" name="cityId" from="${[]}"  value="" class="many-to-one"/>
                <g:select id="district" name="districtId" from="${[]}"  value="" class="many-to-one"/>

            </div>
        </div>

    <g:if test="${params.regType == 0 || params.regType == '0' || studentInstance?.regType == 0}">

        <div class="control-group">
            <label class="control-label" for="studentType.id">
                <g:message code="studentType.label" default="StudentType" />
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="studentCateories" from="${com.baoming.account.Student.StudentCateories.values()}" optionValue="label" value="${studentInstance?.studentCateories}"/>

            </div>
        </div>
    </g:if>
    <g:else>
        <div class="control-group">
            <label class="control-label" for="studentType.id">
                <g:message code="studentType.label" default="StudentType" />
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select from="${studentTypes}" name="studentType.id" optionKey="id" optionValue="name" value="${studentInstance?.studentType?.id}" />
            </div>
        </div>
    </g:else>

<div class="control-group">
    <label class="control-label" for="qq">
        <g:message code="student.qq.label" default="QQ" />
    </label>
    <div class="controls">
        <g:textField name="qq" value="${studentInstance?.qq}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="phone">
        <g:message code="student.phone.label" default="phone" />
    </label>
    <div class="controls">
        <g:textField name="phone" value="${studentInstance?.phone}"/>
    </div>
</div>
        <div class="control-group">
            <label class="control-label" for="score">
                <g:message code="student.score.label" default="Score" />
            </label>
            <div class="controls">
                <g:textField name="score" value="${studentInstance?.score}"/>
            </div>
        </div>
        <g:if test ="${studentInstance && studentInstance?.id}">
            <g:set var="sps" value="${studentInstance?.plans?.collect{it?.id}}"/>
        </g:if>
        <g:else>
            <g:set var="sps" value="${planIds}"/>
        </g:else>
        <div class="control-group">
            <label class="control-label" for="planId">
                <g:message code="student.plans.label" default="Student Plans" />
            </label>
            <div class="controls">
                <g:select name="planId" id="planId"  value="${(sps && sps[0])?sps[0]:''}" noSelection="${['':'请选择']}" from="${plans}" optionValue="name" optionKey="id" />
            </div>
        </div>

<div class="control-group">
    <label class="control-label" for="payment.type">
        <g:message code="topupStatus.label" default="type" />
    </label>
    <div class="controls">
        <g:select name="topupStatus" value="${studentInstance?.topupStatus}" from="${com.bm.TopupStatus.values()}" optionValue="label" noSelection="${['':'未选择']}" />
    </div>
</div>
        %{--<div class="control-group">
            <label class="control-label" for="planId2">
                <g:message code="student.plans.label" default="Student Plans" />2
            </label>
            <div class="controls">
                <g:select name="planId" id="planId2"  value="${(sps && sps[1])?sps[1]:''}" noSelection="${['':'请选择']}" from="${plans}" optionValue="name" optionKey="id" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="planId3">
                <g:message code="student.plans.label" default="Student Plans" />3
            </label>
            <div class="controls">
                <g:select name="planId" id="planId3"  value="${(sps && sps[2])?sps[2]:''}" noSelection="${['':'请选择']}" from="${plans}" optionValue="name" optionKey="id" />
            </div>
        </div>--}%
        <div class="control-group">
            <label class="control-label" for="payment.type">
                <g:message code="student.payment.type.label" default="type" />
            </label>
            <div class="controls">
                <g:select name="payment.type" value="${studentInstance?.payment?.type}" from="${com.baoming.account.Payment.Type.values()}" optionValue="label" noSelection="${['':'未缴费']}" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="payment.type">
                <g:message code="student.payment.amount.label" default="type" />
            </label>
            <div class="controls">
                <g:textField name="payment.amount" value="${studentInstance?.payment?.amount}" />
            </div>
        </div>

<div class="control-group">
    <label class="control-label" for="admissionTicketPicInp">
        <g:message code="student.cardNo.pic.label" default="admissionTicketNumberPic" />
    </label>

    <div class="controls">
        <g:if test="${studentInstance?.cardNoPic}">
            <div style="position: relative;height: 100px;">
                <g:link action="img"  controller="api" id="${studentInstance?.cardNoPic}"  target="_blank">
                    <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.cardNoPic)}" title="点击查看原图" style="height: 100px;" />
                    <a href="javascript:void 0" class="cardNo-del-pic"><g:message code="default.button.delete.label"/></a>
                </g:link>
            </div>
        </g:if>
        <g:hiddenField name="cardNoPic" value="${studentInstance?.cardNoPic}"/>
        <input type="file" name="cardNoPicInp" id="cardNoPicInp" />
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
        <input type="file" name="admissionTicketPicInp" id="admissionTicketPicInp" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="admissionTicketPicInp">
        <g:message code="student.agreement.pic.label" default="admissionTicketNumberPic" />
    </label>

    <div class="controls">
        <g:if test="${studentInstance?.agreementPic}">
            <div style="position: relative;height: 100px;">
                <g:link action="img"  controller="api" id="${studentInstance?.agreementPic}"  target="_blank">
                    <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.agreementPic)}" title="点击查看原图" style="height: 100px;" />
                    <a href="javascript:void 0" class="agreementPic-del-pic"><g:message code="default.button.delete.label"/></a>
                </g:link>
            </div>
        </g:if>
        <g:hiddenField name="agreementPic" value="${studentInstance?.agreementPic}"/>
        <input type="file" name="agreementPicInp" id="agreementPicInp" />
    </div>
</div>
        <div class="control-group">
            <label class="control-label" for="admissionTicketPicInp">
                <g:message code="student.payment.docPic.label" default="admissionTicketNumberPic" />
            </label>

            <div class="controls">
                <g:if test="${studentInstance?.payment?.docPic}">
                    <div style="position: relative;height: 100px;">
                        <g:link action="img"  controller="api" id="${studentInstance?.payment?.docPic}"  target="_blank">
                            <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.payment?.docPic)}" title="点击查看原图" style="height: 100px;" />
                            <a href="javascript:void 0" class="admissionTicketPic-del-pic"><g:message code="default.button.delete.label"/></a>
                        </g:link>
                    </div>
                </g:if>
                <g:hiddenField name="payment.docPic" value="${studentInstance?.payment?.docPic}"/>
                <input type="file" name="paymentDocPicInp" id="paymentDocPicInp" />
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
<sec:ifAnyGranted roles="${com.baoming.account.Role.AUTHORITY_ADMIN},${com.baoming.account.Role.AUTHORITY_FINANCE}">
        <div class="control-group">
            <label class="control-label" for="studentType.id">
                <g:message code="student.admission.label" default="admission" />
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="admission" from="${com.baoming.account.Student.Admission.values()}"   optionValue="label"   value="${studentInstance?.admission}"/>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label" for="studentType.id">
                <g:message code="student.registration.label" default="StudentType" />
                <span class="required-indicator">*</span>
            </label>
            <div class="controls">
                <g:select name="registration" from="${com.baoming.account.Student.Registration.values()}"   optionValue="label"   value="${studentInstance?.registration}" />
            </div>
        </div>
    </sec:ifAnyGranted>
<sec:ifNotGranted roles="ROLE_TEACHER">
    <%
        def userService = grailsApplication.mainContext.getBean("userService");
    %>
    <div class="control-group">
        <label class="control-label" for="combobox">
            <g:message code="student.recommend.teacher.label" default="Description" />
        </label>

        <div class="controls">
            %{--<g:select name="teacherId" from="${teachers}" data-rel="chosen" optionValue="name" optionKey="id"  value="${studentInstance?.teacher?.id}"  noSelection="${['':'请选择']}"/>--}%
            <div class="ui-widget">
                <select id="combobox" name="teacherId">
                    <option value="">请选择</option>
                    <%  def studTeacherId
                    try {
                        studTeacherId = studentInstance.teacher?.id
                    }catch (Exception e){

                    }%>
                    <g:each in="${userService.getTeachers()}" var="teah">
                        <g:if test="${studTeacherId == teah.id}">
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
</sec:ifNotGranted>

<g:render template="/student/reviewForm"/>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${studentInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${studentInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${studentInstance?.middleSchool?.id}" />


