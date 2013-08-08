<%@ page import="com.baoming.Plan" %>
<ul class="reg_box">
    <li class="live">
        <label class="reg_tit">考生类型：        <span class="required-indicator">*</span>
        </label>

        <div class="reg_element">

            <span class="inp_box">
                <g:select from="${com.baoming.StudentType.list()}" name="studentType.id" optionKey="id" optionValue="name" value="${student?.studentType?.id}" />
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">高考成绩：
        </label>

        <div class="reg_element">

            <span class="inp_box">
                <g:textField name="score" value="${student?.score}" class="txt"/>
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">学业水平测试等级：</label>

        <div class="reg_element">

            <span class="inp_box">
                <g:textField name="level" value="${student?.level}" class="txt"/>
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">美术省统考成绩：</label>

        <div class="reg_element">

            <span class="inp_box">
                <g:textField name="artsScore" value="${student?.artsScore}" class="txt"/>
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">体育省统考成绩：</label>

        <div class="reg_element">

            <span class="inp_box">
                <g:textField name="sportsScore" value="${student?.sportsScore}" class="txt"/>
            </span>
        </div>

    </li>
    <g:if test ="${student && student?.id}">
        <g:set var="sps" value="${student?.plans?.collect{it?.id}}"/>
    </g:if>
    <g:else>
        <g:set var="sps" value="${planIds}"/>
    </g:else>

        <li class="live">
        <label class="reg_tit"><g:message code="student.plans.label"/>1：
        </label>

        <div class="reg_element">

                <span class="inp_box">
                    <g:select from="${com.baoming.Plan.findAllByStatus(com.baoming.Plan.Status.RUNNING)}" name="planId" id="planId" optionKey="id"  optionValue="name" value="${(sps && sps[0])?sps[0]:''}" noSelection="${['':'请选择']}" />
                </span>
            </div>

        </li>
    <li class="live">
        <label class="reg_tit"><g:message code="student.plans.label"/>2：
        </label>

        <div class="reg_element">

            <span class="inp_box">
                <g:select from="${com.baoming.Plan.findAllByStatus(com.baoming.Plan.Status.RUNNING)}" name="planId" id="planId1" optionKey="id"   optionValue="name" value="${(sps && sps[1])?sps[1]:''}" noSelection="${['':'请选择']}" />
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit"><g:message code="student.plans.label"/>3：
        </label>

        <div class="reg_element">

            <span class="inp_box">
                <g:select from="${com.baoming.Plan.findAllByStatus(com.baoming.Plan.Status.RUNNING)}" name="planId" id="planId2" optionKey="id"   optionValue="name" value="${(sps && sps[2])?sps[2]:''}" noSelection="${['':'请选择']}"/>
            </span>
        </div>

    </li>

</ul>
