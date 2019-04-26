<%@ page import="com.baoming.Plan; com.baoming.Preppy" %>
<%
    def cal = Calendar.instance
    def year = cal.get(Calendar.YEAR)
%>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie lstx" >
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 招生老师填写 ☆☆☆</strong></td>
    </tr>
    <tr>
        <td height="50" >姓&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
            <input name="name" type="text" id="name" size="12"  class="inp_gray" value="${preppyInstance?.name}" /></td>
    </tr>
    <tr>
        <td height="50">性<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>别：

            <label>
                <input name="gender" type="radio" id="radio" value="${com.baoming.account.User.Gender.MALE.name()}" <g:if test="${!preppyInstance?.gender?.name() || preppyInstance?.gender?.name() == com.baoming.account.User.Gender.MALE.name()}">checked="checked"</g:if> />
                ${com.baoming.account.User.Gender.MALE.label}&nbsp; &nbsp;&nbsp;
                <input type="radio" name="gender" id="radio2" value="${com.baoming.account.User.Gender.FEMALE.name()}" <g:if test="${preppyInstance?.gender?.name() == com.baoming.account.User.Gender.FEMALE.name()}">checked="checked"</g:if>/>
                ${com.baoming.account.User.Gender.FEMALE.label} </label></td>
    </tr>
    <tr>
        <td height="50">身份证号：&nbsp;
        <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
            <g:textField name="number" value="${preppyInstance?.number}"  class="inp_gray" size="40" />
        </g:if>
        <g:else>
            <g:textField name="number" value="${preppyInstance?.number} " class="inp_gray" size="40"  readonly="readonly"/>
        </g:else>
        &nbsp;</td>
    </tr>

    <tr>
        <td height="50">学生手机：
        <g:textField name="phone" value="${preppyInstance?.phone}"  size="20" class="sel_gray1" />
        家长手机：
            <g:textField name="parentPhone" value="${preppyInstance?.parentPhone}" size="20" class="sel_gray1" /></td>
    </tr>

    <tr>
        <td height="50">   <g:message code="preppy.school.label" default="Name" />：
            <g:textField name="school" value="${preppyInstance?.school}"  size="40" class="sel_gray1" /></td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.sendType.label" default="Name" />：
        <g:select  name="sendType" from="${com.baoming.Preppy.SendType.values()}" optionValue="label" class="sel_gray" value="${preppyInstance?.sendType}" noSelection="['':'请选择']"/>

        </td>
    </tr>

    <tr class="receiver-ele">
        <td height="50"><g:message code="preppy.receiverFamily.label" default="Name" />：
        <g:hiddenField name="receiverCityVal" value="${preppyInstance?.receiverCity?.code}"/>
        <g:hiddenField name="receiverDistrictVal" value="${preppyInstance?.receiverDistrict?.code}"/>
        <g:select id="receiverProvince" name="receiverProvinceId" from="${provinces}" optionKey="code" optionValue="name"  value="${preppyInstance?.receiverProvince?.code}" noSelection="['':'请选择']"/>
        省&nbsp;
        <g:select id="receiverCity" name="receiverCityId" from="" optionKey="id"  class="many-to-one"/>
        &nbsp;市&nbsp;
        <g:select id="receiverDistrict" name="receiverDistrictId" from="" optionKey="id" class="many-to-one"/>
        县（区）
        <g:textField name="receiverTown" value="${preppyInstance?.receiverTown}" placeholder="${message(code: 'preppy.town.label')}"/>
        乡镇</td>
    </tr>
    <tr class="receiver-ele">
        <td height="50">  <g:message code="preppy.receiverAddress.label" default="Name" />：
            <g:textField name="receiverAddress" value="${preppyInstance?.receiverAddress}"  size="40" class="sel_gray1" /><b class="red">(详细到门牌号)</b></td>
    </tr>
    <tr class="receiver-ele">
        <td height="50"> <g:message code="preppy.receiver.label" default="Name" />：
        <g:textField name="receiver" value="${preppyInstance?.receiver}"  size="20" class="sel_gray1" />
        <g:message code="preppy.receivePhone.label" default="receivePhone" />：
            <g:textField name="receivePhone" value="${preppyInstance?.receivePhone}" size="20" class="sel_gray1" /></td>
    </tr>

    <tr>
        <td height="50" align="left" ><g:message code="preppy.cardPhotoPath.label" default="Name" />
            <input type="file" name="cardPhotoPathInp">
            <g:if test="${preppyInstance.cardPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" ><g:message code="preppy.cardBackgroundPhotoPath.label" default="Name" />
            <input type="file" name="cardBackgroundPhotoPathInp">
            <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" ><g:message code="preppy.payPhoto.label" default="Name" />
            <input type="file" name="payPhotoPathInp">
            <g:if test="${preppyInstance.payPhoto}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.payPhoto]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.payPhoto])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
</table>

<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie zbsh">
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 招办审核 ☆☆☆</strong></td>
    </tr>
    <tr>
        <td height="50" align="left" >审核：
        <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" value="${preppyInstance?.reviewStatus?.name()}"  class="sel_gray1" noSelection="['':'请选择']"/>

        </td>
    </tr>
    <tr>
        <td height="50" align="left" ><p ><g:message code="preppy.exStatus.label" default="Name" />：
        <g:select name="exStatus" from="${com.baoming.Preppy$ExStatus?.values()}"  optionValue="label" value="${preppyInstance?.exStatus?.name()}" class="sel_gray1" noSelection="['':'请选择']"/>
        </p></td>
    </tr>

    <tr>
        <td height="50" align="left" ><g:message code="preppy.exDate.label" default="exDate" />：
        <g:datePicker name="exDate" value="${preppyInstance?.exDate}" precision="day"
                      years="${(year-5)..(year+5)}" default="none" noSelection="['':'请选择']"/>
        </td>
    </tr>

    <tr>
        <td height="50" align="left" >辅导员：
        <g:textField name="counselor" value="${preppyInstance?.counselor}" size="20" class="sel_gray1"/>
        辅导员电话： <g:textField name="counselorPhone" value="${preppyInstance?.counselorPhone}" size="20" class="sel_gray1"/>
        </td>
    </tr>

    <tr>
        <td height="50" align="left" >备注：
            <g:textField name="remark" value="${preppyInstance?.remark}" size="80" class="sel_gray1"/></td>
    </tr>
    <tr>
        <td height="50" align="left" >推荐人：
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
            <span class="f_20">&nbsp;</span></td>
    </tr>
</table>

<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie sccl">
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 报名补充材料 ☆☆☆</strong></td>
    </tr>

    <tr>
        <td height="50">民<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>族：
        <g:select name="nation.id" from="${com.baoming.Nation.findAll()}" class="sel_gray" optionValue="name" optionKey="id"  value="${preppyInstance?.nation?.id}" noSelection="['':'请选择']"/>
        </td>
    </tr>
    <tr>
        <td height="50">出生日期：

        <g:set var="startYear" value="${year-25}"/>
        <g:datePicker name="birthday" value="${preppyInstance?.birthday}" precision="day"
                      years="${startYear..(year-10)}" default="none" noSelection="['':'请选择']"/>
    </tr>

    <tr>
        <td height="50"><g:message code="politicalStatus.label"/>：
        <g:select name="politicalStatus.id" from="${com.baoming.PoliticalStatus.findAll()}" class="sel_gray" optionValue="name" optionKey="id" value="${preppyInstance?.politicalStatus?.id}" noSelection="['':'请选择']"/>
        </td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.familyType.label"/>：
        <g:select name="familyType" from="${com.baoming.Preppy.FamilyType.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.familyType}" noSelection="['':'请选择']"/>
        </td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.family.label"/>：
        <g:hiddenField name="cityVal" value="${preppyInstance?.city?.code}"/>
        <g:hiddenField name="districtVal" value="${preppyInstance?.district?.code}"/>
        <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
        省&nbsp;
        <g:select id="city" name="cityId" from="" optionKey="id"  class="many-to-one"/>
        &nbsp;市&nbsp;
        <g:select id="district" name="districtId" from="" optionKey="id"  class="many-to-one"/>
        县（区）
        <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
        乡镇</td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.address.label"/>：
        <g:textField name="address" value="${preppyInstance?.address}" size="80" class="sel_gray" /><b class="red">(详细到门牌号)</b>
        </td>
    </tr>

    <tr>
        <td  height="50">初中校名：
        <g:textField name="juniorSchool" value="${preppyInstance?.resume?.juniorSchool}"  size="40" class="sel_gray" />
        证明人：
        <g:textField name="juniorAuthenticator" value="${preppyInstance?.resume?.juniorAuthenticator}"   size="20" class="sel_gray1" />
    </tr>

    <tr>
        <td height="50" align="left" >户口本首页照片
            <input type="file" name="hkbPathInp">
            <g:if test="${preppyInstance.hkbPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >户口本本人页照片
            <input type="file" name="hkbksyPathInp">
            <g:if test="${preppyInstance.hkbksyPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbksyPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbksyPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >高中/中专毕业证书照片
            <input type="file" name="byzsPathInp">
            <g:if test="${preppyInstance.byzsPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.byzsPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.byzsPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >初中毕业证书照片
            <input type="file" name="xjzmPathInp">
            <g:if test="${preppyInstance.xjzmPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.xjzmPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.xjzmPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>

</table>


<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="preppyPlanUrl" select-txt="请选择" value="${createLink(action: 'getPlans1',controller: 'preppyPlan')}"  title="${preppyInstance?.plan?.id}" />