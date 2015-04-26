<%@ page import="com.baoming.MediumPlan; com.baoming.Medium" %>



<div class="control-group">
	<label class="control-label" for="name">
		<g:message code="medium.name.label" default="Name" />
	</label>

    <div class="controls">
	<g:textField name="name" value="${mediumInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="medium.code.label" default="Code" />
	</label>

    <div class="controls">
	<g:textField name="code" value="${mediumInstance?.code}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="number">
		<g:message code="medium.number.label" default="Number" />
	</label>

    <div class="controls">
	<g:textField name="number" value="${mediumInstance?.number}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="gender">
		<g:message code="medium.gender.label" default="Gender" />
	</label>

    <div class="controls">
	<g:select name="gender" from="${com.baoming.account.User$Gender?.values()}"  optionValue="label" value="${mediumInstance?.gender}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="mediumPlan">
		<g:message code="medium.mediumPlan.label" default="Medium Plan" />
	</label>

    <div class="controls">
	<g:select id="mediumPlan" name="mediumPlan.id" from="${mediumPlans}" optionKey="id"  optionValue="name"  value="${mediumInstance?.mediumPlan?.id}" class="many-to-one"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="plan">
		<g:message code="medium.plan.label" default="Plan" />
	</label>

    <div class="controls">
	<g:select id="plan" name="plan.id" from="${plans}" optionKey="id" optionValue="name" required="" value="${mediumInstance?.plan?.id}" class="many-to-one"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="district">
        <g:message code="medium.district.label" default="District" />
    </label>

    <div class="controls">
        <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${mediumInstance?.province?.code}" class="many-to-one"/>
        <g:select id="city" name="cityId" from="" optionKey="id" required="" class="many-to-one"/>

        <g:select id="district" name="districtId" from="" optionKey="id" required="" class="many-to-one"/>
    </div>
</div>


<div class="control-group">
<label class="control-label" for="studentDistrict">
    <g:message code="medium.studentDistrict.label" default="Student District" />
</label>

<div class="controls">
    <g:select id="studentProvince" name="studentProvinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${mediumInstance?.studentProvince?.code}" class="many-to-one"/>

    <g:select id="studentCity" name="studentCityId" from="" optionKey="id" required="" class="many-to-one"/>
    <g:hiddenField name="studentCityVal" value="${mediumInstance?.studentCity?.code}"  />
    <g:select id="studentDistrict" name="studentDistrictId" from="" optionKey="id" required=""/>
    <g:hiddenField name="studentDistrictVal" value="${mediumInstance?.studentDistrict?.code}"  />
</div>
</div>
<sec:ifAllGranted roles="ROLE_ADMIN">
<div class="control-group">
	<label class="control-label" for="teacher">
		<g:message code="medium.teacher.label" default="Teacher" />
	</label>

    <div class="controls">
        <%
            def userService = grailsApplication.mainContext.getBean("userService");
        %>
	%{--<g:select id="teacher" name="teacher.id" from="${com.baoming.account.Teacher.list()}" optionKey="id" required="" value="${mediumInstance?.teacher?.id}" class="many-to-one"/>--}%
        <div class="ui-widget">
            <select id="combobox" name="teacherId">
                <option value="">请选择</option>
                <%  def studTeacherId
                try {
                    studTeacherId = mediumInstance.teacher?.id
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
         </sec:ifAllGranted>
<div class="control-group">
	<label class="control-label" for="voucherPath">
		<g:message code="medium.voucherPath.label" default="Voucher Path" />
	</label>

    <div class="controls">

        <g:if test="${mediumInstance?.voucherPath}">
            <div style="position: relative;height: 100px;">
                <g:link action="img"  controller="api" id="${mediumInstance?.voucherPath}"  target="_blank">
                    <img src="${createLink(controller: 'api',action: 'img',id: mediumInstance?.voucherPath)}" title="点击查看原图" style="height: 100px;" />
                </g:link>
            </div>
        </g:if>
        <g:hiddenField name="voucherPath" value="${mediumInstance?.voucherPath}"/>
        <input type="file" name="voucherPathInp" id="voucherPathInp" />
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="admission">
		<g:message code="medium.admission.label" default="Admission" />
	</label>

    <div class="controls">
	<g:select name="admission" from="${com.baoming.account.Student$Admission?.values()}" optionValue="label" required="" value="${mediumInstance?.admission}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="registration">
		<g:message code="medium.registration.label" default="Registration" />
	</label>

    <div class="controls">
	<g:select name="registration" from="${com.baoming.account.Student$Registration?.values()}" optionValue="label"  required="" value="${mediumInstance?.registration}"/>
    </div>
</div>
<sec:ifAllGranted roles="ROLE_ADMIN">
<div class="control-group">
	<label class="control-label" for="reviewStatus">
		<g:message code="medium.reviewStatus.label" default="Review Status" />
	</label>

    <div class="controls">
	<g:select name="reviewStatus" from="${com.baoming.account.Student$ReviewStatus?.values()}" optionValue="label"  required="" value="${mediumInstance?.reviewStatus}"/>
    </div>
</div>
      </sec:ifAllGranted>
<div class="control-group">
	<label class="control-label" for="description">
		<g:message code="medium.description.label" default="Description" />
	</label>

    <div class="controls">
        <g:textArea name="description" rows="5" cols="" style="width: 50%">${mediumInstance?.description}</g:textArea>
    </div>
</div>


<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${mediumInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${mediumInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="mediumPlanUrl" value="${createLink(action: 'getPlans',controller: 'mediumPlan')}"  title="${mediumInstance?.plan?.id?:params['plan.id']}" />




