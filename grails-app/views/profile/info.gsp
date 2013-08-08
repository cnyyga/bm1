<%@ page import="com.baoming.account.Student" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="mainStudent">
    <g:set var="entityName" value="${message(code: 'reg.student.info.label', default: 'Student')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen.css')}" type="text/css">
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="baoming.js"/>
    <g:javascript src="tj.js"/>
    <style>
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
    </style>

</head>
<body>
<div class="reg-content">
    <div class="reg-header">
        <g:message code="default.edit.label" args="[entityName]" />
    </div>

    <div class="info-result">
        <p>提示：“姓名、考生号、身份证号、推荐人、准考证照片”信息保存后无法修改，请仔细填写!</p>
    </div>
    <g:if test="${flash.message}">
        <div class="info-result">
            ${flash.message}
        </div>
    </g:if>
    <g:hasErrors bean="${studentInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${studentInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:uploadForm method="post"  action="update" name="regForm" >
        <g:render template="studentForm"/>
        <h3 class="stu-split"><g:message code="plan.label"/> </h3>
        <g:render template="select"/>
        <h3 class="stu-split"><g:message code="student.payment.label"/> </h3>
        <g:render template="payment"/>
        <ul class="reg_box">
        <li class="live">
            <label class="reg_tit"><g:message code="student.description.label"/>：</label>

            <div class="reg_element">
                <span class="inp_box">
                    <g:textArea name="description" rows="4" cols="30" class="txt" style="height: 120px;width: 220px;" value="${student?.description}"/>
                </span>
            </div>
        </li>
        %{--<li class="live">
            <label class="reg_tit">
                <h3><g:message code="student.recommend.teacher.label"/>：</h3></label>

            <div class="reg_element">
                <span class="inp_box">
                    <g:if test="${student?.teacher}">
                          ${student?.teacher.name}
                    </g:if>
                    <g:else>
                        <g:select id="recTeacher" name="teacher.id" from="${com.baoming.account.Teacher.findAllByEnabled(Boolean.TRUE)}" data-rel="chosen" optionValue="name" optionKey="id"  value="${student?.teacher?.id}"  noSelection="${['':'请选择']}"/>
                        <g:message code="student.recommend.teacher.message"/>
                    </g:else>

                </span>
            </div>
        </li>--}%
            <li class="live">
                <label class="reg_tit">
                    <h3><g:message code="student.recommend.teacher.label"/>：</h3></label>

                <div class="reg_element">
                    <g:if test="${student?.teacher?.id}">
                        ${student?.teacher?.name}
                    </g:if>
                    <g:else>
                        <div class="ui-widget">
                            <select id="combobox" name="teacher.id">
                                <option value="">请选择</option>
                                <g:each in="${com.baoming.account.Teacher.findAllByEnabled(Boolean.TRUE)}" var="teah">
                                    <g:if test="${student?.teacher?.id == teah.id}">
                                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" selected="true" >${teah.name}</option>
                                    </g:if>
                                    <g:else>
                                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" >${teah.name}</option>
                                    </g:else>
                                </g:each>
                            </select>
                            <b class="tj-tips" style="padding-left: 30px;color: red">必填</b>
                        </div>
                    </g:else>

                </div>
            </li>
        </ul>
        <g:submitButton name="subbtn" class="input-submit"  value="${message(code: 'default.button.update.label', default: 'Update')}" />
    </g:uploadForm>
</div>
</body>
</html>
