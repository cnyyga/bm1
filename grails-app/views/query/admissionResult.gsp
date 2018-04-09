<%@ page import="com.baoming.Plan" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainReg">
    <g:set var="entityName" value="${message(code: 'admission.query.label', default: 'Admission')}"/>
    <title>${entityName}</title>
    <style>
        table{
            width: 100%;
            max-width: 100%;
            background-color:transparent;
            border: 1px solid #dddddd;
        }

        table th {
            border: 1px solid #dddddd;
            border-bottom: 0;
            padding: 8px;
        }
        table td {
            border: 1px solid #dddddd;
            padding: 8px;
            vertical-align: middle;
        }
    </style>
</head>

<body>
<div class="reg-content">
    <div class="reg-header">
        ${entityName}结果
    </div>
    <g:if test="${flash.message}">
        <div class="info-result ">
            <label class="" style="font-weight: bold;">${flash.message}</label>
        </div>
    </g:if>
<g:if test="${admissionInstance}">
    <table class="table table-bordered table-striped table-condensed">
        <thead>
        <tr>

            <th><g:message code="admission.idNo.label" default="Id No" /></th>

            <th><g:message code="admission.name.label" default="Name" /></th>

            <th><g:message code="admission.sex.label" default="Sex" /></th>

            <th><g:message code="admission.ksh.label" default="Ksh" /></th>

            <th><g:message code="admission.bkzy.label" default="Bkzy" /></th>
            <th><g:message code="admission.jtdz.label" default="Bkzy" /></th>
            <th><g:message code="admission.lxdh.label" default="Bkzy" /></th>
            <th><g:message code="admission.kd.label" default="Bkzy" /></th>
            <th><g:message code="admission.kddh.label" default="Bkzy" /></th>
            <th><g:message code="admission.bz.label" default="Bkzy" /></th>

        </tr>
        </thead>
        <tbody>
            <tr>

                <td class="center">${fieldValue(bean: admissionInstance, field: "idNo")}</td>

                <td class="center">${fieldValue(bean: admissionInstance, field: "name")}</td>

                <td class="center">${fieldValue(bean: admissionInstance, field: "sex")}</td>

                <td class="center">${fieldValue(bean: admissionInstance, field: "ksh")}</td>

                <td class="center">${fieldValue(bean: admissionInstance, field: "bkzy")}</td>
                <td class="center">${fieldValue(bean: admissionInstance, field: "jtdz")}</td>
                <td class="center">${fieldValue(bean: admissionInstance, field: "lxdh")}</td>
                <td class="center">${fieldValue(bean: admissionInstance, field: "kd")}</td>
                <td class="center">${fieldValue(bean: admissionInstance, field: "kddh")}</td>
                <td class="center">${fieldValue(bean: admissionInstance, field: "bz")}</td>

            </tr>
        </tbody>
    </table>
</g:if>

</div>
</body>
</html>