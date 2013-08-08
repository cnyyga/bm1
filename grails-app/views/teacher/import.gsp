<%@ page import="com.baoming.MiddleSchool" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'default.button.import.label')}${message(code: 'teacher.label', default: 'teacher')}" />
		<title>${entityName}</title>

	</head>
	<body>
        <div>
            <ul class="breadcrumb">
                <li>
                    <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
                </li>
                <li>
                    <g:link class="list" action="list">${message(code: 'teacher.label', default: 'teacher')}</g:link>
                </li>
            </ul>
        </div>
        <div class="alert alert-error">
            提示：Excel文件内容格式必须符合规范.
            如：
            <table border="1">
                <tr><th>姓名</th><th>用户名</th><th>密码</th><th>区县</th><th>启用</th></tr>
                <tr><td>周老师</td><td>9527</td><td>111111</td><td>320201,320202</td><td>1</td></tr>

            </table>
            区和启用这两列可以不需要。
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
