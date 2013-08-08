<!DOCTYPE html>
<html>
	<head>
		<title>${message(code: 'default.sys.name')}-Error</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
    <p class="error-code">
        404
    </p>
    <p class="not-found">Not<br/>Found</p>
    <div class="clear"></div>
    <div class="content">
        ${message(code: 'default.not.find.page.message')}
        <br/><a href="${createLink(uri: '/')}">Go Home</a>
    </div>
        <div style="display: none">
		<g:renderException exception="${exception}" />
        </div>
	</body>
</html>
