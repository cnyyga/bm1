<%@ page import="com.baoming.Plan; com.baoming.PreppyPlan; com.baoming.Preppy" %>
<style>
.select-min,#age{
    width: 50px;
}
#birthday_year,#birthday_month,#birthday_day,
#juniorStart_year,#juniorStart_month,#juniorStart_day,
#juniorEnd_year,#juniorEnd_month,#juniorEnd_day,
#highStart_year,#highStart_month,#highStart_day,
#highEnd_year,#highEnd_month,#highEndday,
#deposit{
    width: 80px;
}
</style>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="preppy.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" readonly="readonly" value="${preppyInstance?.name}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="number">
        <g:message code="preppy.number.label" default="Number" />
    </label>

    <div class="controls">
        <g:textField name="number" readonly="readonly" value="${preppyInstance?.number}"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="gender">
        <g:message code="nation.label" default="nation" />
    </label>

    <div class="controls">
        <g:select name="nation" from="${com.baoming.Nation.findAll()}"  optionValue="name" optionKey="id" required="" value="${preppyInstance?.nation?.id}"/>
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
    <label class="control-label" for="family"><g:message code="preppy.family.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:each in="${com.baoming.Preppy.Family.values()}" var="t">
            <label class="radio-inline">
                <input type="radio" name="family" id="family" value="${t.name()}" <g:if test="${preppyInstance?.family?.id==t.id}">checked</g:if>/>  ${t.label}
            </label>
        </g:each>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="family"><g:message code="preppy.type.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:each in="${com.baoming.Preppy.Type.values()}" var="t">
            <label class="radio-inline">
                <input type="radio" name="type" id="type" value="${t.name()}" <g:if test="${preppyInstance?.type?.id==t.id}">checked</g:if>/>  ${t.label}
            </label>
        </g:each>

    </div>
</div>

<div class="control-group">
    <label class="control-label" for="family"><g:message code="preppy.leiBei.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:each in="${com.baoming.Preppy.LeiBie.values()}" var="t">
            <label class="radio-inline">
                <input type="radio" name="leiBie" id="leiBie" value="${t.name()}" <g:if test="${preppyInstance?.leiBie?.id==t.id}">checked</g:if>/>  ${t.label}
            </label>
        </g:each>

    </div>
</div>

<div class="control-group">
    <label class="control-label" for="family"><g:message code="preppy.beforeFamily.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <label class="radio-inline">
            <input type="radio" name="beforeFamily" id="beforeFamily" value="1" <g:if test="${preppyInstance?.beforeFamily}">checked</g:if>/> <g:message code="default.boolean.true"/>
        </label>
        <label class="radio-inline">
            <input type="radio" name="beforeFamily" id="beforeFamily1" value="0" <g:if test="${!preppyInstance?.beforeFamily}">checked</g:if>/> <g:message code="default.boolean.false"/>
        </label>

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
        <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
    </div>
</div>


%{--<div class="control-group">
    <label class="control-label" for="studentCateories"><g:message code="preppy.studentCateories.label"/> <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:select name="studentCateories" from="${Preppy.StudentCateories.values()}" optionValue="label" value="${preppyInstance?.studentCateories}" attr-sel="${preppyInstance?.studentCateories}"/>

    </div>
</div>--}%

%{--<div class="control-group">
    <label class="control-label" for="gender">
        <g:message code="preppy.gender.label" default="Gender" />
    </label>

    <div class="controls">
        <g:select name="gender" from="${com.baoming.account.User$Gender?.values()}" keys="${com.baoming.account.User$Gender.values()*.name()}" optionValue="label" required="" value="${preppyInstance?.gender?.name()}"/>
    </div>
</div>--}%






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
        <g:select name="plan.id" id="planId" from="${com.baoming.Plan.findAllByStatus(com.baoming.Plan.Status.RUNNING)}" value="${preppyInstance?.plan?.id}" optionValue="name" optionKey="id"/>
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="phone">
        <g:message code="preppy.phone.label" default="Phone" />
    </label>

    <div class="controls">
        <g:textField name="phone" value="${preppyInstance?.phone}" maxlength="11"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.parentPhone.label" default="parentPhone" />
    </label>

    <div class="controls">
        <g:textField name="parentPhone" value="${preppyInstance?.parentPhone}"  maxlength="11"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.qq.label" default="qq"  />
    </label>

    <div class="controls">
        <g:textField name="qq" value="${preppyInstance?.qq}" maxlength="16"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="parentPhone">
        <g:message code="preppy.resume.label" default="resume" />
    </label>

    <div class="controls p-resume">
        <div>
            <%
                cal.add(Calendar.YEAR,4);
                cal.set(Calendar.MONTH,8)
            %>
            <g:message code="preppy.resume.junior.label" default="junior" />
            <g:datePicker name="juniorStart" value="${preppyInstance?.resume?.juniorStart ?: cal.time}" precision="month"
                          years="${startYear..year}"/>起--
            <%
                cal.add(Calendar.YEAR,3);
                cal.set(Calendar.MONTH,6)
            %>
            <g:datePicker name="juniorEnd" value="${preppyInstance?.resume?.juniorEnd ?: cal.time}" precision="month"
                          years="${startYear..year}"/>止
            <g:textField name="juniorSchool" value="${preppyInstance?.resume?.juniorSchool}"  placeholder="学校名称（中职须注明专业）"/>
            <g:textField name="juniorAuthenticator" value="${preppyInstance?.resume?.juniorAuthenticator}"  placeholder="证明人"/>
        </div>

        <div>
            <%

                cal.set(Calendar.MONTH,8)
            %>
            <g:message code="preppy.resume.high.label" default="high" />(中职)
            <g:datePicker name="highStart" value="${preppyInstance?.resume?.highStart ?: cal.time}" precision="month"
                          years="${startYear..year}"/>起--
            <%
                cal.add(Calendar.YEAR,3);
                cal.set(Calendar.MONTH,6)
            %>
            <g:datePicker name="highEnd" value="${preppyInstance?.resume?.highEnd ?: cal.time}" precision="month"
                          years="${startYear..year}"/>止
            <g:textField name="highSchool" value="${preppyInstance?.resume?.highSchool}"  placeholder="学校名称"/>
            <g:textField name="highAuthenticator" value="${preppyInstance?.resume?.highAuthenticator}"  placeholder="证明人"/>
        </div>

    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            中职专业
        </label>

        <div class="controls">
            <g:textField name="zzzy" value="${preppyInstance?.resume?.zzzy}" maxlength="16"/>（注：中职学生填写此项）
        </div>
    </div>
    <h5 style="text-align: center">上传证明</h5>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            身份证正面照片
        </label>

        <div class="controls">
            <input type="file" name="cardPhotoPathInp">
            <g:if test="${preppyInstance.cardPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            身份证反面照片
        </label>

        <div class="controls">
            <input type="file" name="cardBackgroundPhotoPathInp">
            <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            户口本首页照片
        </label>

        <div class="controls">
            <input type="file" name="hkbPathInp">
            <g:if test="${preppyInstance.hkbPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            户口本本人页照片
        </label>

        <div class="controls">
            <input type="file" name="hkbksyPathInp">
            <g:if test="${preppyInstance.hkbksyPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbksyPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbksyPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            <g:message code="preppy.byzsPath.label"/>
        </label>

        <div class="controls">
            <input type="file" name="byzsPathInp">
            <g:if test="${preppyInstance.byzsPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.byzsPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.byzsPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            <g:message code="preppy.xjzmPath.label"/>
        </label>

        <div class="controls">
            <input type="file" name="xjzmPathInp">
            <g:if test="${preppyInstance.xjzmPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.xjzmPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.xjzmPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="parentPhone">
            <g:message code="preppy.otherPhotoPath.label"/>
        </label>

        <div class="controls">
            <input type="file" name="otherPhotoPathInp">
            <g:if test="${preppyInstance.otherPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.otherPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.otherPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
            <p>
                <img src=""/>
                <g:img file="preppy_cardno.png"/>
            </p>
        </div>
    </div>
</div>

<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="preppyPlanUrl" select-txt="请选择" value="${createLink(action: 'getPlans1',controller: 'preppyPlan')}"  title="${preppyInstance?.plan?.id}" />
