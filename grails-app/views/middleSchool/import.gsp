<%@ page import="com.baoming.MiddleSchool" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'default.button.import.label')}${message(code: 'middleSchool.label', default: 'MiddleSchool')}" />
		<title>${entityName}</title>

	</head>
	<body>
        <div>
            <ul class="breadcrumb">
                <li>
                    <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
                </li>
                <li>
                    <g:link class="list" action="list">${message(code: 'middleSchool.label', default: 'MiddleSchool')}</g:link>
                </li>
            </ul>
        </div>
        <div class="alert alert-error">
            提示：Excel文件内容格式必须符合规范.
            如：
            <table border="1">
                <tr><th>省</th><th>市</th><th>区县</th><th>名称</th><th>编号</th><th>联系人</th><th>联系电话</th><th>说明</th></tr>
                <tr><td>江苏省</td><td>南京市</td><td>鼓楼区</td><td>职业中学</td><td>10000</td><td>张校长</td><td>13333333333</td><td>江苏省</td><td>好学校</td></tr>

            </table>
        </div>
        <g:if test="${flash.message}">
            <div class="alert alert-error">${flash.message}</div>
        </g:if>
        <g:if test="${status == '1'}">
            <div class="alert alert-error">
                导入成功${succ},失败${fail}
            </div>
        </g:if>
        <g:if test="${status == '2'}">
            <div class="alert alert-error">
                没有选择文件或文件读取失败.
            </div>
        </g:if>


        <div class="row-fluid sortable">
            <div class="box span12">
                <div class="box-header well" data-original-title>
                    <h2><i class="icon-edit"></i> ${entityName}</h2>
                </div>
                <div class="box-content">
                    <g:uploadForm action="importFile">
                        <g:hiddenField name="u" value="1"/>
                        <input type="file" name="file"/>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">${message(code: 'default.button.import.label')}</button>
                        </div>
                    </g:uploadForm>

                </div>
            </div><!--/span-->

        </div><!--/row-->

	</body>
</html>
