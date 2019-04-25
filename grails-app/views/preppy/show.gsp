
<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
        <g:javascript src="jquery-1.8.3.js"/>
        <g:javascript src="jquery-ui-1.9.2.custom.min.js"  />
        <g:javascript src="jquery.chosen.min.js"  />
        <g:javascript src="jquery.validate.min.js"/>
        <g:javascript src="card.js"/>
        <g:javascript src="additional-methods.js"/>
        <g:javascript src="messages_zh.js"/>
        <g:javascript src="tj.js"/>
        <g:javascript src="app-preppy.js"/>
        <style type="text/css">
        .sel_gray1 {font-size:14px; font-family:"微软雅黑";}
        .sel_gray1 {font-size:14px; font-family:"微软雅黑";}
        .tianxie{ font-family:"微软雅黑"; font-size:18px;  }
        .tianxie td{ border-bottom:1px dashed #cccccc; padding:3px 0;}
        .inp_gray{ font-size:14px; color:#000000; border:#d1d1d1 1px solid; height:24px;  font-family:"微软雅黑";  }
        .sel_gray{ font-size:14px; font-family:"微软雅黑";}
        .ui-combobox {
            position: relative;
            display: inline-block;
        }
        .ui-combobox-toggle {
            position: absolute;
            top: 0;
            bottom: 0;
            margin-left: -1px;
            padding: 0;
            /* adjust styles for IE 6/7 */
            *height: 1.7em;
            *top: 0.1em;
        }
        .ui-combobox-input {
            margin: 0;
            padding: 0.3em;
        }
        .ui-widget-content {
            text-align: left;
        }
        ul.ui-widget-content {
            height: 200px;
            overflow: auto;
        }
        .tab-content {
            overflow: visible;
        }
        label.error {
            color: red;
            font-weight: bold;
            margin-top: 2px;
            padding: 2px 8px;
        }
        .alert {
            padding: 8px 35px 8px 14px;
            margin-bottom: 18px;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
            background-color: #8bc5e8;
            border: 1px solid #7ed0e5;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            color: #1c628b;
        }
        .alert-error {
            background-color: #eddbe3;
            border-color: #e8d1df;
            color: #bd4247;
        }label.error {
             color: red;
             font-weight: bold;
             margin-top: 2px;
             padding: 2px 8px;
         }
        .alert {
            padding: 8px 35px 8px 14px;
            margin-bottom: 18px;
            text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
            background-color: #8bc5e8;
            border: 1px solid #7ed0e5;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            color: #1c628b;
        }
        .alert-error {
            background-color: #eddbe3;
            border-color: #e8d1df;
            color: #bd4247;
        }
        </style>
        <script>

        </script>
	</head>
	<body>
    <%
        def cal = Calendar.instance
        def year = cal.get(Calendar.YEAR)
    %>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>

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
            <g:select id="receiverProvince" name="receiverProvinceId" from="${provinces}" optionKey="code" optionValue="name"  value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
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
                <g:textField name="receiverAddress" value="${preppyInstance?.receiverAddress}"  size="40" class="sel_gray1" /></td>
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
            <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" required="" value="${preppyInstance?.reviewStatus?.name()}"  class="sel_gray1" noSelection="['':'请选择']"/>

            </td>
        </tr>
        <tr>
            <td height="50" align="left" ><p ><g:message code="preppy.exStatus.label" default="Name" />：
            <g:select name="exStatus" from="${com.baoming.Preppy$ExStatus?.values()}"  optionValue="label" required="" value="${preppyInstance?.exStatus?.name()}" class="sel_gray1" noSelection="['':'请选择']"/>
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

    </table>

    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie sccl">
        <tr>
            <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 报名补充材料 ☆☆☆</strong></td>
        </tr>

        <tr>
            <td height="50">民<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>族：
            <g:select name="nation.id" from="${com.baoming.Nation.findAll()}" class="sel_gray" optionValue="name" optionKey="id" required="" value="${preppyInstance?.nation?.id}" noSelection="['':'请选择']"/>
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
            <g:select name="politicalStatus.id" from="${com.baoming.PoliticalStatus.findAll()}" class="sel_gray" optionValue="name" optionKey="id" required="" value="${preppyInstance?.politicalStatus?.id}" noSelection="['':'请选择']"/>
            </td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.familyType.label"/>：
            <g:select name="familyType" from="${com.baoming.Preppy.FamilyType.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.familyType}" noSelection="['':'请选择']"/>
            </td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.family.label"/>：
            <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
            省&nbsp;
            <g:select id="city" name="cityId" from="" optionKey="id" required="" class="many-to-one"/>
            &nbsp;市&nbsp;
            <g:select id="district" name="districtId" from="" optionKey="id" required="" class="many-to-one"/>
            县（区）
            <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
            乡镇</td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.address.label"/>：
            <g:textField name="address" value="${preppyInstance?.address}" size="80" class="sel_gray" />
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

    <div style="text-align: center">
        <sec:ifAllGranted roles="${Role.AUTHORITY_ADMIN}">
            <g:hiddenField name="id" value="${preppyInstance?.id}" />
            <g:link class="btn btn-info" action="edit" id="${preppyInstance?.id}">
                <i class="icon-edit icon-white"></i>
                <g:message code="default.button.edit.label" default="Edit" />
            </g:link>
            <g:hiddenField name="act" value="1" />
            <g:actionSubmit class="btn btn-primary" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
        </sec:ifAllGranted>
        <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
            <g:if test="${!preppyInstance.reviewStatus || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">
                <g:link class="btn btn-info" action="edit" id="${preppyInstance?.id}">
                    <i class="icon-edit icon-white"></i>
                    <g:message code="default.button.edit.label" default="Edit" />
                </g:link>
            </g:if>

        </sec:ifAllGranted>
        <g:link class="btn btn-success" action="xyPrint1" id="${preppyInstance.id}">
            <i class="icon-zoom-in  icon-white"></i>
            <g:message code="default.button.print.label" default="Xy" />
        </g:link>
<g:link class="btn btn-success" action="list">
        <g:message code="default.button.back.label" default="back" />
    </g:link>
    </div>


    <g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
    <g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
    <g:hiddenField name="preppyPlanUrl" select-txt="请选择" value="${createLink(action: 'getPlans1',controller: 'preppyPlan')}"  title="${preppyInstance?.plan?.id}" />

	</body>
</html>
