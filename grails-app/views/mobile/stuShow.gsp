<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.high.show.title"/></title>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="baoming_a.js"/>
    <g:javascript src="tj.js"/>
    <g:javascript>
        $(function () {
            $('#myTab').tab('show');
            $('#myTab a:first').tab('show')
        })
    </g:javascript>
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
    <h2><g:message code="student.mobile.high.show.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body select-body">
        <g:render template="/student/newshow"/>
        <div>
        <button type="button" class="btn btn-primary" onclick="javascript:location.href='${createLink(controller: 'mobile',action: 'addStu')}'"><g:message code="student.create.high.title"/> </button>
        <g:link action="createStu" controller="mobile" class="btn">${message(code: 'default.button.back.label')}${message(code: 'student.create.stu.type.title')}</g:link>

    </div>
    </div>
</div>
</body>
</html>
