<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="BaoMing"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'baoming.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui.min.css')}" type="text/css">
        <g:javascript src="jquery-1.8.3.js"/>
        <r:layoutResources />
        <g:javascript src="jquery-ui-1.9.2.custom.min.js"/>
        <g:javascript src="jquery.ui.datepicker-zh-CN.js"/>
        <g:layoutHead/>

	</head>
	<body>
        <div id="header">
            <div class="header-area">
                <div id="headerLogo">
                    <g:img dir="images" file="logo.jpg" height="74"/>
                    <sec:ifAllGranted roles='ROLE_STUDENT'>
                    <div style="position: absolute;bottom: 5px;right: 5px;">
                      %{--  <g:link action="edit" controller="profile">修改资料</g:link>
                        <g:link action="rePassword" controller="profile">修改密码</g:link>--}%
                        <g:link controller="logout">退出</g:link>
                    </div>
                    </sec:ifAllGranted>
                </div>

            </div>
        </div>
        <div id="container" class="clearfix">
            <div class="fl stu-left" >
            <g:render template="/layouts/studentLeft"   />
            </div>
            <div class="fl stu-right">
            <g:layoutBody/>
            </div>
        </div>
        <div id="footer" style="border:none">
            <g:render template="/layouts/regFooter"/>
        </div>
	</body>
</html>
