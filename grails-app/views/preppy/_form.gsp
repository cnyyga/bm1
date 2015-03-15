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
    <label class="control-label" for="studentCateories"><g:message code="preppy.studentCateories.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select name="studentCateories" from="${Preppy.StudentCateories.values()}" optionValue="label" value="${preppyInstance?.studentCateories}"/>

    </div>
</div>

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
    <label class="control-label" for="gender">
        <g:message code="preppy.gender.label" default="Gender" />
    </label>

    <div class="controls">
        <g:select name="gender" from="${com.baoming.account.User$Gender?.values()}" keys="${com.baoming.account.User$Gender.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.gender?.name()}"/>
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
        <g:message code="preppy.age.label" default="birthday" />
        <g:textField name="age" this-year-attr="${year}"  readonly=""/>
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
    <label class="control-label" for="studentDistrict">
        <g:message code="medium.studentDistrict.label" default="Student District" />
    </label>

    <div class="controls">
        <g:select id="studentProvince" name="studentProvinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${preppyInstance?.studentProvince?.code}" class="many-to-one"/>
        <g:select id="studentCity" name="studentCityId" from="" optionKey="id" required=""/>
            <g:hiddenField name="studentCityVal" value="${preppyInstance?.studentCity?.code}"  />
        <g:select id="studentDistrict" name="studentDistrictId" from="" optionKey="id" required=""/>
            <g:hiddenField name="studentDistrictVal" value="${preppyInstance?.studentDistrict?.code}"  />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="school">
        <g:message code="preppy.school.label" default="school" />
    </label>

    <div class="controls">

        <g:textField name="school" value="${preppyInstance?.school}"/>

    </div>
</div>

<div class="control-group ">
    <label class="control-label" for="type">
        <g:message code="preppy.type.label" default="type" />
    </label>

    <div class="controls">
        <g:select name="type" from="${com.baoming.Preppy$Type?.values()}"  optionValue="label" required="" value="${preppyInstance?.type?.name()}"/>
    </div>
</div>

<div class="control-group zhongzhi  waisheng">
	<label class="control-label" for="schoolType">
		<g:message code="preppy.schoolType.label" default="schoolType" />
	</label>

    <div class="controls">
	<g:select name="schoolType" from="${com.baoming.Preppy$SchoolType?.values()}" optionValue="label" required="" value="${preppyInstance?.schoolType?.name()}"/>
    </div>
</div>


<div class="control-group pugao">
    <label class="control-label" for="academicYear">
        <g:message code="preppy.academicYear.label" default="academicYear" />
    </label>

    <div class="controls">
        <g:select name="academicYear" from="${startYear..(year-1)}" noSelection="['':'未参加']" value="${preppyInstance?.academicYear}"/>

    </div>
</div>

<div class="control-group pugao">
    <label class="control-label" for="academicScore1">
        <g:message code="preppy.academicScore.label" default="academicScore" />
    </label>

    <div class="controls">
        <g:set var="academicScore" value="${preppyInstance.academicScore}"  />
        <g:set var="academicScoreList" value="${academicScore?academicScore.tokenize(','):['A','A','A','A','A','A']}"  />
        物理<g:select name="academicScore" id="academicScore1" value="${academicScoreList[0]}" class="select-min" from="${['A','B','C','D']}"/>
        化学<g:select name="academicScore" id="academicScore2" value="${academicScoreList[1]}" class="select-min" from="${['A','B','C','D']}"/>
        生物<g:select name="academicScore" id="academicScore3" value="${academicScoreList[2]}" class="select-min" from="${['A','B','C','D']}"/>
        地理<g:select name="academicScore" id="academicScore4" value="${academicScoreList[3]}" class="select-min" from="${['A','B','C','D']}"/>
        历史<g:select name="academicScore" id="academicScore5" value="${academicScoreList[4]}" class="select-min" from="${['A','B','C','D']}"/>
        政治<g:select name="academicScore" id="academicScore6" value="${academicScoreList[5]}" class="select-min" from="${['A','B','C','D']}"/>
    </div>
</div>

<div class="control-group pugao">
    <label class="control-label" for="skill">
        <g:message code="preppy.skill.label" default="skill" />
    </label>

    <div class="controls">
        <g:select name="skill" from="${com.baoming.Preppy$Skill?.values()}" optionValue="label" required="" value="${preppyInstance?.skill?.name()}"/>
    </div>
</div>

<div class="control-group zhongzhi">
    <label class="control-label" for="middlePlan">
        <g:message code="preppy.middlePlan.label" default="Middle Plan" />
    </label>

    <div class="controls">
        <g:textField name="middlePlan" value="${preppyInstance?.middlePlan}"/>
    </div>
</div>

<div class="control-group zhongzhi">
    <label class="control-label" for="preppyPlan">
        <g:message code="preppyPlan.label" default="preppyPlan" />
    </label>

    <div class="controls">
        <g:select id="preppyPlan" name="preppyPlan.id" from="${preppyPlans}" optionKey="id" optionValue="name" value="${preppyInstance?.preppyPlan?.id}" class="many-to-one" />
    </div>
</div>

<div class="control-group ">
    <label class="control-label" for="plan">
        <g:message code="preppy.plan.label" default="Plan" />
    </label>

    <div class="controls plan-area">
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
    <label class="control-label" for="address">
        <g:message code="preppy.address.label" default="Tel" />
    </label>

    <div class="controls">
        <g:textField name="address" value="${preppyInstance?.address}"/>
    </div>
</div>

<sec:ifAllGranted roles="ROLE_ADMIN">
<div class="control-group">
    <label class="control-label" for="reviewStatus">
        <g:message code="preppy.reviewStatus.label" default="ReviewStatus" />
    </label>

    <div class="controls">
        <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" required="" value="${preppyInstance?.reviewStatus?.name()}"/>
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
</div>
</sec:ifAllGranted>

<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
<g:textArea name="pugaoArea" rows="1" cols="1">
    <g:select id="plan" name="plan.id" from="${plans}" optionKey="id" optionValue="name" value="${preppyInstance?.plan?.id}" class="many-to-one" />
</g:textArea>
<g:textArea name="zhongzhiArea" rows="1" cols="1">
    <g:select id="plan" name="plan.id" from="${zhongPlans}" optionKey="id" optionValue="name" value="${preppyInstance?.plan?.id}" class="many-to-one" />
</g:textArea>
<g:textArea name="waiArea" rows="1" cols="1">
    <g:select id="plan" name="plan.id" from="${waiPlans}" optionKey="id" optionValue="name" value="${preppyInstance?.plan?.id}" class="many-to-one" />
</g:textArea>