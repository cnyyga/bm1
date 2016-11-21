<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.medium.show.title"/></title>

    <style>
        .select-body{
            background:none;
            border:0;
        }
        .form-horizontal .control-label {
            width: 100px;
        }
        .form-horizontal .controls {
            margin-left: 120px;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.mobile.medium.show.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body select-body">
        <g:render template="/medium/show"/>
        <div>
        <button type="button" class="btn btn-primary" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'addMedium')}'"><g:message code="student.mobile.create.medium.title"/> </button>
    </div>
    </div>
</div>
</body>
</html>
