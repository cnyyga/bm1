<html>
<head>
	<meta name='layout' content='mainMobile'/>
	<title><g:message code="springSecurity.student.login.title"/></title>
    <style type="text/css">

        .back-select{
            margin:0 30px;
        }
        .back-select a{
            color: #cccccc;
        }
    </style>
    <script type="text/javascript">
        $(function(){
            $("form").submit(function () {
                var username = $("#username").val();
                var password = $("#password").val();
                if(!username || username.trim() == ""){
                    $("#username").css("border-color","#a94442");
                    alert("请输入身份证号");
                    $("#username").focus();
                    return false;
                }
                var len = username.length;
                if(len !=18 && len !=15){
                    $("#username").css("border-color","#a94442");
                    alert("请输入正确的18位身份证号");
                    $("#username").focus();
                    return false;
                }

                if(!password || password.trim().length <1){
                    $("#password").css("border-color","#a94442");
                    alert("请输入密码");
                    $("#password").focus();
                    return false;
                }
            });

            $("#username").keyup(function () {
                var len = $(this).val().length;
                console.log(len)
                if(len == 18){
                    $(this).css("border-color","#3c763d");
                }else{
                    $(this).css("border-color","#a94442");
                }
            })
        })
    </script>
</head>

<body>
<div class="page-title">
    <h2 style=""><g:message code="springSecurity.student.login.title"/></h2>
</div>
<div class="page-content gradient" >
    <div class="page-body">

        <form action="${postUrl}" class="login-form" id="loginForm" method="post" style="padding-top: 15px;">
            <g:if test='${flash.message}'>
            <dl class="top clearfix">
                    <span style="display: block;" class="errors_div">${flash.message}</span>
            </dl>
            </g:if>
            <dl class="top code clearfix">
                <dt><label for="username">帐号</label></dt>
                <dd>
                    <input type="text" id="username" class="input-text" name="j_username">
                </dd>
            </dl>
            <dl class="pwd clearfix">
                <dt><label for="password">密码</label></dt>
                <dd>
                    <input type="password" autocomplete="off"  class="input-text" error="请输入密码" name="j_password" id="password">
                </dd>
            </dl>
            <dl class="savepassword clearfix">
                <dt>
                    <label class="labelCheckbox" for="autoLogin" >
                        <input type='checkbox' id="autoLogin" name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>下次自动登录
                        <button class="btn-large btn btn-primary btn-ok" type="submit">登录</button>
                    </label>
                </dt>
                <dd>

                </dd>
            </dl>

        </form>
        </div>
    <p class="back-select"><a href="${createLink(controller: 'mobile')}">←返回身份选择页面</a></p>

</div>
</body>
</html>
