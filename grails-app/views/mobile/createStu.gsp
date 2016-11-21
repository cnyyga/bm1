<html>
<head>
    <meta name='layout' content='mainMobile'/>
    <title><g:message code="student.create.stu.title"/></title>
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
    <script>
        $(function(){
            $(".btn-ok").click(function(){
                var _type = $("#selectType").val();
                if(_type == '1'){
                    location.href="${createLink(controller: 'mobile',action: 'addStu')}";
                }else if(_type == '2'){
                    location.href="${createLink(controller: 'mobile',action: 'addPreppy')}";
                }else{
                    location.href="${createLink(controller: 'mobile',action: 'addMedium')}";
                }
            })
        })

    </script>
</head>

<body>
<div class="page-title select-title">
    <h2><g:message code="student.create.stu.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body select-body">
        <dl class="top code clearfix">
            <dt><label for="type"><g:message code="student.create.stu.type.title"/> </label></dt>
            <dd>
                <g:select name="type" id="selectType" class="input-text" from="[[id:1,label:'高中生'],[id:2,label:'旁听生'],[id:3,label:'中专生']]" optionKey="id" optionValue="label"/>
            </dd>
        </dl>

        <dl class="savepassword clearfix">
            <dt>

            </dt>
            <dd>
                <button class="btn-large btn btn-primary btn-ok" type="button"><g:message code="default.button.confirm.label"/> </button>
            </dd>
        </dl>
    </div></div>
</body>
</html>
