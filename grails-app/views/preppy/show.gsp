
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

	</head>
	<body>

    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>

    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie lstx" >
        <tr>
            <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 招生老师填写 ☆☆☆</strong></td>
        </tr>
        <tr>
            <td height="50" >姓&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
                ${preppyInstance?.name}</td>
        </tr>
        <tr>
            <td height="50">性<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>别：
                ${preppyInstance?.gender?.label}            </td>
        </tr>
        <tr>
            <td height="50">身份证号：&nbsp;
            ${preppyInstance?.number}
            &nbsp;</td>
        </tr>

        <tr>
            <td height="50">学生手机：
            ${preppyInstance?.phone}
            家长手机：${preppyInstance?.parentPhone}</td>
        </tr>

        <tr>
            <td height="50">   <g:message code="preppy.school.label" default="Name" />：
            ${preppyInstance?.school}</td>
        </tr>
        <tr>
            <td height="50"><g:message code="student.plans.label" default="Plan" />：
            ${preppyInstance?.plan?.name}            </td>
        </tr>
        <tr>
            <td height="50"><g:message code="preppy.sendType.label" default="Name" />：
            ${preppyInstance?.sendType?.label}
            </td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.receiverFamily.label" default="Name" />：
            ${preppyInstance?.receiverProvince?.name}省&nbsp;
            ${preppyInstance?.receiverCity?.name}&nbsp;市&nbsp;
            ${preppyInstance?.receiverDistrict?.name}县（区）
            ${preppyInstance?.receiverTown}乡镇</td>
        </tr>
        <tr>
            <td height="50">  <g:message code="preppy.receiverAddress.label" default="Name" />：
                ${preppyInstance?.receiverAddress}</td>
        </tr>
        <tr>
            <td height="50"> <g:message code="preppy.receiver.label" default="Name" />：
            ${preppyInstance?.receiver}
            <g:message code="preppy.receivePhone.label" default="receivePhone" />：
                ${preppyInstance?.receivePhone}</td>
        </tr>

        <tr>
            <td height="50" align="left" ><g:message code="preppy.cardPhotoPath.label" default="Name" />
                <g:if test="${preppyInstance.cardPhotoPath}">
                    <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                </g:if>
            </td>
        </tr>
        <tr>
            <td height="50" align="left" ><g:message code="preppy.cardBackgroundPhotoPath.label" default="Name" />
                <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                    <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                </g:if>
            </td>
        </tr>
        <tr>
            <td height="50" align="left" ><g:message code="preppy.payPhoto.label" default="Name" />
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
            ${preppyInstance?.reviewStatus?.label}
            </td>
        </tr>
        <tr>
            <td height="50" align="left" ><g:message code="preppy.exStatus.label" default="Name" />：
            ${preppyInstance?.exStatus?.label}</td>
        </tr>

        <tr>
            <td height="50" align="left" ><g:message code="preppy.exDate.label" default="exDate" />：
            <g:formatDate date="${preppyInstance?.exDate}" format="yyyy-MM-dd"/>
            </td>
        </tr>

        <tr>
            <td height="50" align="left" >辅导员：
            ${preppyInstance?.counselor}
            辅导员电话： ${preppyInstance?.counselorPhone}
            </td>
        </tr>

        <tr>
            <td height="50" align="left" >备注：${preppyInstance?.remark}</td>
        </tr>

    </table>

    <table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie">
        <tr>
            <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 报名补充材料 ☆☆☆</strong></td>
        </tr>

        <tr>
            <td height="50">民<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>族：
            ${preppyInstance?.nation?.name}            </td>
        </tr>
        <tr>
            <td height="50">出生日期：
            <g:formatDate date="${preppyInstance?.birthday}" format="yyyy-MM-dd"/>
        </tr>

        <tr>
            <td height="50"><g:message code="politicalStatus.label"/>：
            ${preppyInstance?.politicalStatus?.name}            </td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.familyType.label"/>：
            ${preppyInstance?.familyType?.label}            </td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.family.label"/>：
            ${preppyInstance?.province?.name}省&nbsp;
            ${preppyInstance?.city?.name}&nbsp;市&nbsp;
            ${preppyInstance?.district?.name}县（区）
            ${preppyInstance?.town}乡镇</td>
        </tr>

        <tr>
            <td height="50"><g:message code="preppy.address.label"/>：
            ${preppyInstance?.address}            </td>
        </tr>

        <tr>
            <td  height="50">初中校名：
            ${preppyInstance?.resume?.juniorSchool}
            证明人：
            ${preppyInstance?.resume?.juniorAuthenticator}
        </tr>

        <tr>
            <td height="50" align="left" >户口本首页照片
                <g:if test="${preppyInstance.hkbPath}">
                    <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                </g:if>
            </td>
        </tr>
        <tr>
            <td height="50" align="left" >户口本本人页照片
                <g:if test="${preppyInstance.hkbksyPath}">
                    <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbksyPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbksyPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                </g:if>
            </td>
        </tr>
        <tr>
            <td height="50" align="left" >高中/中专毕业证书照片
                <g:if test="${preppyInstance.byzsPath}">
                    <g:link action="img1"  controller="api" params="[path:preppyInstance?.byzsPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.byzsPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
                </g:if>
            </td>
        </tr>
        <tr>
            <td height="50" align="left" >初中毕业证书照片
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
            <g:if test="${!preppyInstance.reviewStatus || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.NO_AUDIT.name() || preppyInstance.reviewStatus?.name() == com.baoming.Preppy.ReviewStatus.GJSZZ.name()}">
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
