<html>
<head>
	<meta name='layout' content='mainReg'/>
	<title><g:message code="springSecurity.login.title"/></title>
    <script type="text/javascript">
        $(function(){
            $("#loginForm .input-text").focus(function(){
                var t = $(this);
                var id = t.attr("id");
                if(id == 'username') {
                    $("#loginForm #pwdUsername").hide();
                }else if(id == 'password') {
                    $("#loginForm #pwdTip").hide();
                }
            })
            $("#loginForm .input-text").blur(function(){
                var t = $(this);
                var v = t.val();
                if(v && $.trim(v)!='') {
                    return;
                }

                var id = t.attr("id");
                if(id == 'username') {
                    $("#loginForm #pwdUsername").show();
                }else if(id == 'password') {
                    $("#loginForm #pwdTip").show();
                }
            })
        })
    </script>
</head>

<body>
    <div class="" style="width:220px;height:350px;margin: 0 auto;border: 0;">
        <h2 style="text-align: center;padding: 5px;color: #43A1DA">报名后台管理登录</h2>
        <form action="${postUrl}" class="login-form" id="loginForm" method="post" style="padding-top: 15px;">
            <g:if test='${flash.message}'>
            <dl class="top clearfix">
                    <span style="display: block;" class="errors_div">${flash.message}</span>
            </dl>
            </g:if>
            <dl class="top code clearfix">
                <dt><label for="username">帐号:</label></dt>
                <dd style="border-color: rgb(173, 182, 201);">
                    <input type="text" id="username" class="input-text" name="j_username" style="color: rgb(136, 136, 136);">
                    <label for="username" id="pwdUsername" class="codetip" style="visibility: visible;">请输入用户名</label>
                </dd>
            </dl>
            <dl class="pwd clearfix">
                <dt><label for="password">密码:</label></dt>
                <dd style="border-color: rgb(173, 182, 201);">
                    <input type="password" autocomplete="off"  class="input-text" error="请输入密码" name="j_password" id="password">
                    <label for="password" id="pwdTip" class="pwdtip" style="visibility: visible;">请输入密码</label>
                </dd>
            </dl>
            <div style="display:none" id="capsLockMessage" class="caps-lock-tips"></div>
            <dl class="savepassword clearfix">
                <dt>
                    <label class="labelCheckbox" for="autoLogin" >
                        <input type='checkbox' id="autoLogin" name='${rememberMeParameter}' id='remember_me' <g:if test='${hasCookie}'>checked='checked'</g:if>/>下次自动登录
                    </label>
                </dt>
                <dd>
                   %{-- <span id="getpassword" class="getpassword"><a stats="home_findpassword" href="#">忘记密码？</a></span>--}%
                </dd>
            </dl>

            <dl class="login-button">
                <button class="btn-large btn btn-primary" type="submit">登录</button>
            </dl>
        </form>
        %{--<div class="regnow">
            <button class="btn-large btn btn-success" onclick="location.href='${createLink(action: 'index',controller: 'reg')}'">注册</button>
        </div>--}%
    </div>
    %{--<div class="content_right fr">
        <div style="padding: 20px 5px;line-height:normal ;">
            <p style="text-align: center">
            <g:img dir="images" file="home.jpg"/>
            </p>
            <g:set var="welcome" value="${com.baoming.Welcome.list()}"/>
            <g:set var="welcome" value="${welcome?welcome[0]:null}"/>
            ${welcome?.content}
        </div>
    </div>--}%
</body>
</html>
