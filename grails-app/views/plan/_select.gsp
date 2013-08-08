<h3 style="border-bottom: 1px solid #E8E8E8">专业</h3>
<ul class="reg_box">
    <li class="live">
        <label class="reg_tit">考生类型：</label>

        <div class="reg_element">

            <span class="inp_box">
                <g:select from="${com.baoming.StudentType.list()}" name="studentType.id" optionKey="id" optionValue="name" value="${student?.studentType?.id}" />
            </span>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">高考成绩：</label>

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
    <g:each in="${(1..3)}" var="s" status="i">
<li class="live">
<label class="reg_tit">拟报专业${s}：</label>

<div class="reg_element">

        <span class="inp_box">
            <g:select from="${com.baoming.Plan.list()}" name="planId" optionKey="id" optionValue="name" value="${sps?sps[i]:-1}" noSelection="${['':'请选择']}" />
        </span>
    </div>

</li>
    </g:each>
</ul>

<h3 style="border-bottom: 1px solid #E8E8E8">缴费</h3>
<ul class="reg_box">
    <li class="live">
        <label class="reg_tit">汇款方式：</label>

        <div class="reg_element">
              <g:select name="payment.type" value="${student?.payment?.type}" from="${com.baoming.account.Payment.Type.values()}" optionValue="label" noSelection="${['':'未缴费']}" />
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">汇款人：</label>

        <div class="reg_element">
            <g:textField name="payment.name" class="txt" value="${student?.payment?.name}"/>
        </div>

    </li>

    <li class="live">
        <label class="reg_tit">汇款帐号：</label>

        <div class="reg_element">
            <g:textField name="payment.account" class="txt" value="${student?.payment?.account}"/>
        </div>

    </li>

    <li class="live">
        <label class="reg_tit">汇款金额：</label>

        <div class="reg_element">
            <g:textField name="payment.amount" class="txt" value="${student?.payment?.amount}"/>
        </div>

    </li>
    <li class="live">
        <label class="reg_tit">汇款日期：</label>

        <div class="reg_element">
            <%
                def cal = Calendar.instance
                def year = cal.get(Calendar.YEAR)
            %>
            <g:datePicker name="payment.date" value="${student?.payment?.date}" precision="day"
                          years="${1900..year}"/>

        </div>

    </li>
</ul>