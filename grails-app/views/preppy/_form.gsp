<%@ page import="com.baoming.Plan; com.baoming.PreppyPlan; com.baoming.Preppy" %>
<style>
    .select-min,#age{
        width: 50px;
    }
    #birthday_year,#birthday_month,#birthday_day,#deposit{
        width: 80px;
    }
</style>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="preppy.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${preppyInstance?.name}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="number">
        <g:message code="preppy.number.label" default="Number" />
    </label>

    <div class="controls">
        <g:textField name="number" value="${preppyInstance?.number}"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="password">
        <g:message code="springSecurity.login.password.label" default="Password" />
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:passwordField name="password"  value=""/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="deposit">
        <g:message code="preppy.deposit.label" default="deposit" />
    </label>

    <div class="controls">
        <g:textField name="deposit" value="${preppyInstance?.deposit}"/>  元
    </div>
</div>

<sec:ifNotGranted roles="ROLE_TEACHER">
<div class="control-group">
    <label class="control-label" for="family"><g:message code="preppy.family.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select name="family" from="${Preppy.Family.values()}" optionValue="label" value="${preppyInstance?.family}"/>

    </div>
</div>

<div class="control-group">
    <label class="control-label" for="studentCateories"><g:message code="preppy.studentCateories.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select name="studentCateories" from="${Preppy.StudentCateories.values()}" optionValue="label" value="${preppyInstance?.studentCateories}" attr-sel="${preppyInstance?.studentCateories}"/>

    </div>
</div>

<div class="control-group">
    <label class="control-label" for="gender">
        <g:message code="preppy.gender.label" default="Gender" />
    </label>

    <div class="controls">
        <g:select name="gender" from="${com.baoming.account.User$Gender?.values()}" keys="${com.baoming.account.User$Gender.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.gender?.name()}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="gender">
        <g:message code="nation.label" default="nation" />
    </label>

    <div class="controls">
        <g:select name="nation" from="${com.baoming.Nation.findAll()}"  optionValue="name" required="" value="${preppyInstance?.nation?.id}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="birthday">
        <g:message code="preppy.birthday.label" default="birthday" />
    </label>

    <div class="controls">
        <%
            def cal = Calendar.instance
            def year = cal.get(Calendar.YEAR)
            cal.add(Calendar.YEAR,-10);
        %>
        <g:set var="startYear" value="${year-25}"/>
        <g:datePicker name="birthday" value="${preppyInstance?.birthday ?: cal.time}" precision="day"
                      years="${startYear..(year-10)}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="district">
        <g:message code="medium.district.label" default="District" />
    </label>

    <div class="controls">
        <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${preppyInstance?.province?.code}" class="many-to-one"/>
        <g:select id="city" name="cityId" from="" optionKey="id" required="" class="many-to-one"/>
        <g:select id="district" name="districtId" from="" optionKey="id" required="" class="many-to-one"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="address">
        <g:message code="preppy.address.label" default="Tel" />
    </label>

    <div class="controls">
        <g:textField name="address" value="${preppyInstance?.address}"/>
    </div>
</div>
<div class="control-group ">
    <label class="control-label" for="planId">
        <g:message code="preppy.plan.label" default="Plan" />
    </label>

    <div class="controls plan-area">
        <select id="planId" name="plan.id"></select>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="phone">
        <g:message code="preppy.phone.label" default="Phone" />
    </label>

    <div class="controls">
        <g:textField name="phone" value="${preppyInstance?.phone}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.parentPhone.label" default="parentPhone" />
    </label>

    <div class="controls">
        <g:textField name="parentPhone" value="${preppyInstance?.parentPhone}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.qq.label" default="qq" />
    </label>

    <div class="controls">
        <g:textField name="qq" value="${preppyInstance?.qq}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.resume.label" default="qq" />
    </label>

    <div class="controls">
        <g:textArea cols="200" rows="3" name="resume" >${preppyInstance?.resume}</g:textArea>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="reviewStatus">
        <g:message code="preppy.reviewStatus.label" default="ReviewStatus" />
    </label>

    <div class="controls">
        <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" required="" value="${preppyInstance?.reviewStatus?.name()}"/>
    </div>
</div>

    <div class="control-group zhongzhi">
        <label class="control-label" for="collegeSignUp">
            高考报名地
        </label>

        <div class="controls">
            <g:select name="collegeSignUp" from="${com.baoming.Preppy$CollegeSignUp?.values()}"  optionValue="label" required="" value="${preppyInstance?.collegeSignUp?.name()}"/>
        </div>
    </div>

    <div class="control-group zhongzhi">
        <label class="control-label" for="preppyPlan">
            <g:message code="preppyPlan.label" default="preppyPlan" />
        </label>

        <div class="controls">
            <g:select id="preppyPlan" name="preppyPlan.id" from="${preppyPlans}" optionKey="id" optionValue="name" value="${preppyInstance.preppyPlan?.id}" class="many-to-one" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="remark">
            <g:message code="preppy.remark.label" default="remark" />1
        </label>
        <div class="controls">
            <g:textArea name="remark" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark}</g:textArea>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="remark">
            <g:message code="preppy.remark.label" default="remark" />2
        </label>
        <div class="controls">
            <g:textArea name="remark1" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark1}</g:textArea>
        </div>
    </div>


    <div class="control-group">
        <label class="control-label" for="remark">
            <g:message code="preppy.remark.label" default="remark" />3
        </label>
        <div class="controls">
            <g:textArea name="remark2" rows="3" cols="15" style="width: 300px;">${preppyInstance?.remark2}</g:textArea>
        </div>
    </div>

<div class="control-group">
	<label class="control-label" for="combobox">
		<g:message code="preppy.teacher.label" default="Teacher" />
	</label>

    <div class="controls">

    <%
        def userService = grailsApplication.mainContext.getBean("userService");
    %>
            <select id="combobox" name="teacherId">
                <option value="">请选择</option>

        <g:set var="studTeacherId" value="${preppyInstance.teacher?.id}"/>
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
</sec:ifNotGranted>




<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="preppyPlanUrl" value="${createLink(action: 'getPlans1',controller: 'preppyPlan')}"  title="${preppyInstance?.plan?.id}" />
