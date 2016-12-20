<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.mobile.preppy.stu.title"/></title>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-row.css')}" type="text/css">
    <g:javascript src="jquery-1.8.3.js"/>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="app-preppy_stu.js"/>
    <script>
        $(function(){
            $(".lstx input").attr("disabled",true);
            $(".lstx select").attr("disabled",true);
            $(".zbsh input").attr("disabled",true);
            $(".zbsh select").attr("disabled",true);
        })
    </script>
    <style>
        .select-body{
            background:none;
            border:0;
        }
    </style>

</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.mobile.preppy.stu.title"/></h2>
</div>

<div class="page-content gradient" >
    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>
    <div class="page-body select-body">
        <g:uploadForm method="post" controller="profile"  action="savePreppy" name="preppyForm">
            <g:render template="/profile/preppyForm"/>
            <div>
                <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
                    <g:submitButton name="subbtn" class="input-submit"  value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </g:if>
            </div>
         </g:uploadForm>
    </div>
</div>
</body>
</html>
