<%@ page import="com.baoming.Plan; com.baoming.Preppy" %>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie lstx" >
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 招生老师填写 ☆☆☆</strong></td>
    </tr>
    <tr>
        <td height="50" >姓&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：
            <input name="name" type="text" id="name" size="12"  class="inp_gray" value="${preppyInstance?.name}" /></td>
    </tr>
    <tr>
        <td height="50">身份证号：&nbsp;
            <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
                <g:textField name="number" value="${preppyInstance?.number}"  class="inp_gray" size="40" />
            </g:if>
            <g:else>
                <g:textField name="number" value="${preppyInstance?.number} " class="inp_gray" size="40"  readonly="readonly"/>
            </g:else>
            &nbsp;</td>
    </tr>
    <tr>
        <td height="50">登陆密码：&nbsp;
            <input name="password" type="text"  class="inp_gray" id="password" size="40" />
            &nbsp;</td>
    </tr>
    <tr>
        <td height="50">户籍地区：
        <g:select id="province" name="provinceId" from="${provinces}" optionKey="code" optionValue="name" required="" value="${preppyInstance?.province?.code}" noSelection="['':'请选择']"/>
        省&nbsp;
        <g:select id="city" name="cityId" from="" optionKey="id" required="" class="many-to-one"/>
        &nbsp;市&nbsp;
        <g:select id="district" name="districtId" from="" optionKey="id" required="" class="many-to-one"/>
        县（区）
        <g:textField name="town" value="${preppyInstance?.town}" placeholder="${message(code: 'preppy.town.label')}"/>
        乡镇</td>
    </tr>
    <tr>
        <td height="50">性<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>别：

            <label>
                <input name="gender" type="radio" id="radio" value="${com.baoming.account.User.Gender.MALE.name()}" <g:if test="${!preppyInstance?.gender?.name() || preppyInstance?.gender?.name() == com.baoming.account.User.Gender.MALE.name()}">checked="checked"</g:if> />
                ${com.baoming.account.User.Gender.MALE.label}&nbsp; &nbsp;&nbsp;
                <input type="radio" name="gender" id="radio2" value="${com.baoming.account.User.Gender.FEMALE.name()}" <g:if test="${preppyInstance?.gender?.name() == com.baoming.account.User.Gender.FEMALE.name()}">checked="checked"</g:if>/>
                ${com.baoming.account.User.Gender.FEMALE.label} </label></td>
    </tr>
    <tr>
        <td height="50">保证金缴纳方式：
        <g:select name="depositType" from="${com.baoming.Preppy.DepoistType.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.depositType}"/>
        </td>
    </tr>
    <tr>
        <td height="50">缴纳保证金：&nbsp;
            <g:if test="${!preppyInstance.reviewStatus || preppyInstance?.reviewStatus == com.baoming.Preppy.ReviewStatus.NO_AUDIT }">
                <g:textField name="deposit" value="${preppyInstance?.deposit}" size="10" class="sel_gray"/>
            </g:if>
            <g:else>
                <g:textField name="deposit" value="${preppyInstance?.deposit} "  size="10" class="sel_gray" readonly="readonly"/>
            </g:else>
            元 </td>
    </tr>
</table>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie xstx">
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 学生填写 ☆☆☆</strong></td>
    </tr>

    <tr>
        <td height="50" align="center"><strong >（请选择你的身份，只能选一个，必须真实有效。 如选错，将无法取得我院学籍。 )</strong></td>
    </tr>
    <tr>
        <td height="50">户籍地：
        <g:select name="family" from="${com.baoming.Preppy.Family.values()}" class="sel_gray" optionValue="label" value="${preppyInstance?.family}" noSelection="['':'请选择']"/>
        </td>
    </tr>
    <tr>
        <td height="50"><g:message code="preppy.type.label"/> ：
            <g:each in="${com.baoming.Preppy.Type.values()}" var="t" status="i">
                <label class="radio-inline">
                    <input type="radio" name="type" id="type${i}" value="${t.name()}" <g:if test="${preppyInstance?.type?.id==t.id}">checked</g:if>/>  ${t.label}
                </label>
            </g:each>
        </td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.leiBei.label"/> ：
            <g:each in="${com.baoming.Preppy.LeiBie.values()}" var="t" status="i">
                <label class="radio-inline">
                    <input type="radio" name="leiBie" id="leiBie${i}" value="${t.name()}" <g:if test="${preppyInstance?.leiBie?.id==t.id}">checked</g:if>/>  ${t.label}
                </label>
            </g:each>
        </td>
    </tr>

    <tr>
        <td height="50"><g:message code="preppy.beforeFamily.label"/> ：
            <label class="radio-inline">
                <input type="radio" name="beforeFamily" id="beforeFamily1" value="true" <g:if test="${preppyInstance?.beforeFamily==true}">checked</g:if>/> <g:message code="default.boolean.true"/>
            </label>
            <label class="radio-inline">
                <input type="radio" name="beforeFamily" id="beforeFamily0" value="false" <g:if test="${preppyInstance?.leiBie && preppyInstance?.beforeFamily==false}">checked</g:if>/> <g:message code="default.boolean.false"/>
            </label>
        </td>
    </tr>

    <tr>
        <td height="50">民<span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;&nbsp;</span>族：
        <g:select name="nation.id" from="${com.baoming.Nation.findAll()}" class="sel_gray" optionValue="name" optionKey="id" required="" value="${preppyInstance?.nation?.id}" noSelection="['':'请选择']"/>
</td>
    </tr>
    <tr>
        <td height="50">出生日期：
        <%
            def cal = Calendar.instance
            def year = cal.get(Calendar.YEAR)
            cal.add(Calendar.YEAR,-10);
        %>
        <g:set var="startYear" value="${year-25}"/>
        <g:datePicker name="birthday" value="${preppyInstance?.birthday}" precision="day"
                      years="${startYear..(year-10)}" default="none" noSelection="['':'请选择']"/>
    </tr>

    <tr>
        <td height="50">详细地址：
            <g:textField name="address" value="${preppyInstance?.address}" size="80" class="sel_gray" />
        </td>
    </tr>
    <tr>
        <td height="50"><p >申请就读专业：
            <g:select name="plan.id" from="${plans}" value="${preppyInstance?.plan?.id}" optionValue="name" optionKey="id"/>
            </td>
    </tr>
    <tr>
        <td height="50"><p > <g:message code="topupStatus.label" default="type" />：
        <g:select name="topupStatus" value="${preppyInstance?.topupStatus}" from="${com.bm.TopupStatus.values()}" optionValue="label" noSelection="${['':'未选择']}" />
        </td>
    </tr>
    <tr>
        <td height="50">学生手机：
        <g:textField name="phone" value="${preppyInstance?.phone}"  size="20" class="sel_gray1" />
            家长手机：
            <g:textField name="parentPhone" value="${preppyInstance?.parentPhone}" size="20" class="sel_gray1" />
            学生QQ：
            <g:textField name="qq" value="${preppyInstance?.qq}" size="15" class="sel_gray1"/></td>
    </tr>
    <tr>
        <td height="55"  style="border-bottom:none;"><table width="750" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="98">学生简历：</td>
                <%
                    cal.add(Calendar.YEAR,4);
                    cal.set(Calendar.MONTH,8)
                %>
                <td>初中
            <g:datePicker name="juniorStart" value="${preppyInstance?.resume?.juniorStart}" precision="month"
                          years="${startYear..year}" class="sel_gray1" noSelection="['':'请选择']" default="none"/>
            <%
                cal.add(Calendar.YEAR,3);
                cal.set(Calendar.MONTH,6)
            %>
            起至<g:datePicker name="juniorEnd" value="${preppyInstance?.resume?.juniorEnd}" precision="month"
                            years="${startYear..year}"  class="sel_gray1" noSelection="['':'请选择']" default="none"/></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>初中校名：
                <g:textField name="juniorSchool" value="${preppyInstance?.resume?.juniorSchool}"  size="40" class="sel_gray" />
                    证明人：
                <g:textField name="juniorAuthenticator" value="${preppyInstance?.resume?.juniorAuthenticator}"   size="20" class="sel_gray1" />
            </tr>
            <tr>
                <td>&nbsp;</td>
                <%

                    cal.set(Calendar.MONTH,8)
                %>
                <td>高中(中职)<span class="f_20">&nbsp;</span>
                <g:datePicker name="highStart" value="${preppyInstance?.resume?.highStart}" precision="month"
                              years="${startYear..year}"  class="sel_gray1" noSelection="['':'请选择']" default="none"/>
                <%
                    cal.add(Calendar.YEAR,3);
                    cal.set(Calendar.MONTH,6)
                %>
                起至
                <g:datePicker name="highEnd" value="${preppyInstance?.resume?.highEnd}" precision="month"
                              years="${startYear..year}"  class="sel_gray1" noSelection="['':'请选择']" default="none"/></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>高中(中职)校名：
                <g:textField name="highSchool" value="${preppyInstance?.resume?.highSchool}"  size="33" class="sel_gray"/>
                    证明人：
                <g:textField name="highAuthenticator" value="${preppyInstance?.resume?.highAuthenticator}" size="20" class="sel_gray1" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>中职专业：
                    <input name="zzzy" type="text" id="textfield19"   size="40" class="sel_gray" value="${preppyInstance?.resume?.zzzy}" />
                    <font style="font-size:14px;">（注：中职学生填写此项）</font></td>
            </tr>
        </table></td>
    </tr>
    <sec:ifAllGranted roles="${com.baoming.account.Role.AUTHORITY_STUDENT}">
    <tr>
        <td>
            <div style="text-align: center;color:red">【所有信息填写完毕，请点击最下方“保存修改”】</div>
        </td>
    </tr>
    </sec:ifAllGranted>
</table>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 上传材料 ☆☆☆</strong></td>
    </tr>
    <tr>
        <td height="50" align="left" >身份证正面照片
            <input type="file" name="cardPhotoPathInp">
            <g:if test="${preppyInstance.cardPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardPhotoPath])}" title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >身份证反面照片
            <input type="file" name="cardBackgroundPhotoPathInp">
            <g:if test="${preppyInstance.cardBackgroundPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.cardBackgroundPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.cardBackgroundPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >户口本首页照片
            <input type="file" name="hkbPathInp">
            <g:if test="${preppyInstance.hkbPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >户口本本人页照片
            <input type="file" name="hkbksyPathInp">
            <g:if test="${preppyInstance.hkbksyPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.hkbksyPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.hkbksyPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >高中/中专或初中毕业证书照片
            <input type="file" name="byzsPathInp">
            <g:if test="${preppyInstance.byzsPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.byzsPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.byzsPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >高校录取通知书（若已被其它高校录取请上传）
            <input type="file" name="xjzmPathInp">
            <g:if test="${preppyInstance.xjzmPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.xjzmPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.xjzmPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >手持身份证照片
            <input type="file" name="otherPhotoPathInp">
            <g:if test="${preppyInstance.otherPhotoPath}">
                <g:link action="img1"  controller="api" params="[path:preppyInstance?.otherPhotoPath]" target="_blank"><img src="${createLink(controller: 'api',action: 'img1',params: [path:preppyInstance.otherPhotoPath])}"  title="点击打开原图" alt="点击打开原图" style="max-height: 50px;"></g:link>
            </g:if>
        </td>
    </tr>
</table>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="tianxie zbsh">
    <tr>
        <td height="42" align="center" style="background:#5fb9f2;"><strong style="font-size:22px; color:#ffffff;">☆☆☆ 招办审核 ☆☆☆</strong></td>
    </tr>
    <tr>
        <td height="50" align="left" >1、审核：
        <g:select name="reviewStatus" from="${com.baoming.Preppy$ReviewStatus?.values()}"  optionValue="label" required="" value="${preppyInstance?.reviewStatus?.name()}"  class="sel_gray1" noSelection="['':'请选择']"/>

        </td>
    </tr>
    <tr class="zhongzhi">
        <td height="50" align="left" ><p >2、2017年高考报名
            <g:select name="collegeSignUp" from="${com.baoming.Preppy$CollegeSignUp?.values()}"  optionValue="label" required="" value="${preppyInstance?.collegeSignUp?.name()}" class="sel_gray1" noSelection="['':'请选择']"/>
            <font style="font-size:14px;"> （注：非江苏户籍学生全部选“钟山学院”，江苏户籍任选）</font> </p></td>
    </tr>
    <tr class="zhongzhi">
        <td height="50" align="left" >3、科目组
        <g:select id="preppyPlan" name="preppyPlan.id" from="${preppyPlans}" optionKey="id" optionValue="name" value="${preppyInstance.preppyPlan?.id}" class="sel_gray1" noSelection="['':'请选择']"/>
        </td>
    </tr>
    <tr>
        <td height="50" align="left" >4、备注1：
            <g:textField name="remark" value="${preppyInstance?.remark}" size="80" class="sel_gray1"/><label class="error" style="font-size: 12px;">（科目组）</label></td>
    </tr>
    <tr>
        <td height="50" align="left" ><span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;</span>备注2：
            <g:textField name="remark1" value="${preppyInstance?.remark1}" size="80" class="sel_gray1"/><label class="error" style="font-size: 12px;">（学籍异动、学费、挂靠费收退补）</label></td>
    </tr>
    <tr>
        <td height="50" align="left" ><span class="f_20">&nbsp; &nbsp;&nbsp;&nbsp;</span><span class="f_20">&nbsp;</span>备注3：
            <g:textField name="remark2" value="${preppyInstance?.remark2}" size="80" class="sel_gray1"/><label class="error" style="font-size: 12px;">（入学年份、取得学籍年份等其他内容）</label></td>
    </tr>
    <tr>
        <td height="50" align="left" >5、推荐人：
        <%
            def userService = grailsApplication.mainContext.getBean("userService");
        %>
            <select id="combobox" name="teacherId">
                <option value="">请选择</option>
                <g:set var="studTeacherId" value="${preppyInstance.teacher?.id}"/>
                <g:each in="${userService.getTeachers()}" var="teah">
                    <g:if test="${studTeacherId == teah.id}">
                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" selected="true" >${teah.name}</option>
                    </g:if>
                    <g:else>
                        <option value="${teah.id}" title="${teah.name}${com.bm.utils.PinyinUtils.getPinyin(teah.name)}" >${teah.name}</option>
                    </g:else>
                </g:each>
            </select>
            <span class="f_20">&nbsp;</span></td>
    </tr>
    <tr>
        <td height="50" align="left" >6、辅导员，辅导员电话：
        <g:textField name="counselor" value="${preppyInstance?.counselor}" size="20" class="sel_gray1"/>
        <g:textField name="counselorPhone" value="${preppyInstance?.counselorPhone}" size="20" class="sel_gray1"/>
        </td>
    </tr>

</table>



<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${preppyInstance?.city?.code?:params.cityId}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${preppyInstance?.district?.code?:params.districtId}" />
<g:hiddenField name="preppyPlanUrl" select-txt="请选择" value="${createLink(action: 'getPlans1',controller: 'preppyPlan')}"  title="${preppyInstance?.plan?.id}" />