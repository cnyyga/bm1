<html>
<head>
	<meta name='layout' content='mainMobile'/>
	<title><g:message code="springSecurity.denied.title"/></title>
    <style type="text/css">
        .select-title{
            width: 120px;
            color:#575757;
            margin-top: 10px;
        }

        .select-body{
            background:none;
            border:0;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="springSecurity.denied.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body select-body">
        <div class='errors'><g:message code="springSecurity.denied.message" /></div>
        <a href="${createLink(action: 'auth')}"><g:message code="springSecurity.login.title" /></a>
        </div></div>
</body>
</html>
