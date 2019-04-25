<%@ page import="com.baoming.account.Role; com.baoming.Preppy" %>
<!DOCTYPE html>
<html>
	<head>
		<g:set var="entityName" value="${message(code: 'preppy.label', default: 'Preppy')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript src="jquery-1.8.3.js"/>
        <g:javascript src="jquery-ui-1.9.2.custom.min.js"  />
        <g:javascript src="jquery.chosen.min.js"  />
        <g:javascript src="tj.js"/>
        <g:javascript src="jquery.validate.min.js"/>
        <g:javascript src="card.js"/>
        <g:javascript src="additional-methods.js"/>
        <g:javascript src="messages_zh.js"/>
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
        }
        </style>
        <script>
            $(function(){
                <sec:ifAllGranted roles="${Role.AUTHORITY_TEACHER}">
                $(".xstx input").attr("disabled",true);
                $(".xstx select").attr("disabled",true);
                $(".zbsh input").attr("disabled",true);
                $(".zbsh select").attr("disabled",true);
                </sec:ifAllGranted>
                <sec:ifAllGranted roles="${Role.AUTHORITY_FINANCE}">
                $(".xstx input").attr("disabled",true);
                $(".xstx select").attr("disabled",true);
                $(".lstx input").attr("disabled",true);
                $(".lstx select").attr("disabled",true);
                </sec:ifAllGranted>
            })

        </script>
	</head>
	<body>
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${preppyInstance}">
        <ul class="alert alert-error" >
            <g:eachError bean="${preppyInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:uploadForm action="save" name="editForm">
        <g:render template="form"/>
        <div class="form-actions" style="margin: 10px auto;text-align: center;">
            <input type="submit" name="button" id="button" value="提交" />
            &nbsp;&nbsp;
            <input type="submit" name="button2" id="button2" value="重置" />
            <button onclick="javascript:history.back()"type="button" >返回</button>
        </div>
    </g:uploadForm>
	</body>
</html>
