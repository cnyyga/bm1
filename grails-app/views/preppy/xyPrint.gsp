<%@ page import="com.baoming.Preppy" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>钟山职业技术学院</title>
    <script type="text/javascript">
        window.print();
    </script>
</head>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'xiyi.css')}" type="text/css">
<body>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="0" class="zhongzhi" >
    <tr>
        <td height="40" colspan="2" align="right"  style="border-bottom:1px solid #cccccc;" >协议编号：&nbsp;<strong>${preppyInstance?.protocolCode}</strong></td>
    </tr>
    <tr>
        <td align="center" ><table width="680" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="475"><g:img dir="images" file="title_pugao.jpg"  width="474" height="89" /></td>
                <td><p style="font-size:40px; font-family:'宋体'; font-weight:bold;">(${preppyInstance.studentCateories.label})</p></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" class="f_20">甲&nbsp;&nbsp;方：钟山职业技术学院 </td>
    </tr>
    <tr>
        <td height="45" class="f_20">乙&nbsp;&nbsp;方：
            <input class="inp_red" name="textfield" type="text" id="textfield"   value="${preppyInstance?.name}" size="8" /></td>
    </tr>

    <tr>
        <td style="padding-left:30px;">
            1、身份证号：&nbsp;<input class="inp_red" name="textfield2" type="text" id="textfield2" value="${preppyInstance?.number}" size="25"   />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性别：
            <input name="textfield3" type="text" id="textfield3" value="${preppyInstance?.gender?.label}"   size="5" class="inp_red" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年龄：
            <input name="textfield4" type="text" id="textfield4" value="${age}"   size="5" class="inp_red" /></td>
    </tr>
    <tr>
        <td style="padding-left:30px;">2、户籍：&nbsp;
            <input class="inp_red" name="textfield5" type="text" id="textfield5" value="${preppyInstance?.province?.name}"   size="6" />&nbsp;省&nbsp;
            <input class="inp_red" name="textfield6" type="text" id="textfield6" value="${preppyInstance?.city?.name}"   size="6" />市
            <input class="inp_red" name="textfield7" type="text" id="textfield7" value="${preppyInstance?.district?.name}"   size="6" />县（区） </td>
    </tr>
    <tr>
        <td style="padding-left:30px;">3、毕业或正在就读中学、中专、技校全称：
            <input class="inp_red" name="textfield8" type="text" id="textfield8" value="${preppyInstance?.studentProvince?.name}"   size="6" />省&nbsp;
            <input class="inp_red" name="textfield9" type="text" id="textfield9" value="${preppyInstance?.studentCity?.name}"   size="6" />&nbsp;市&nbsp;
            <input class="inp_red" name="textfield14" type="text" id="textfield14" value="${preppyInstance?.school}"   size="18" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
    </tr>
    <tr>
        <td style="padding-left:30px;">4、
            <input class="inp_red" name="checkbox2" type="checkbox" id="checkbox2" <g:if test="${preppyInstance.type?.name() == Preppy.Type.FRESH.name()}">checked="checked"</g:if>  />
            应届生
            、
            <input class="inp_red" type="checkbox" name="checkbox" id="checkbox" <g:if test="${preppyInstance.type?.name() == Preppy.Type.PREVIONS.name()}">checked="checked"</g:if>/>
            往届生
            、
            <input class="inp_red" type="checkbox" name="checkbox3" id="checkbox3" <g:if test="${preppyInstance.type?.name() == Preppy.Type.DROPOUT.name()}">checked="checked"</g:if> />
            肄业生</td>
    </tr>
    <g:if test="${preppyInstance.studentCateories.name() == Preppy.StudentCateories.SG.name()}">
        <tr>
            <td valign="top" style="padding-left:30px;"><p>5、学业水平测试成绩：
                <g:if test="${!preppyInstance.academicYear}">
                    <input name="textfield11" type="text" id="textfield11" value="未"   size="5" class="inp_red" />
                    参加  <br />
                </g:if>
                <g:else>
                    <input name="textfield12" type="text" id="textfield12" value="${preppyInstance.academicYear}" class="inp_red"   size="5" />
                    年参加。<br />
                </g:else>
                <g:set var="academicScore" value="${preppyInstance.academicScore}"  />
                <g:set var="academicScoreList" value="${academicScore?academicScore.tokenize(','):['','','','','','']}"  />
                <span class="f_20">&nbsp;&nbsp;&nbsp;</span>成绩：物理
                <input name="textfield15" type="text" id="textfield15" value="${academicScoreList[0]}"   size="3" class="inp_red" />
                化学
                <input name="textfield16" type="text" id="textfield16" value="${academicScoreList[1]}"   size="3" class="inp_red" />
                生物
                <input name="textfield17" type="text" id="textfield17" value="${academicScoreList[2]}"   size="3" class="inp_red" />
                地理
                <input name="textfield18" type="text" id="textfield18" value="${academicScoreList[3]}"   size="3" class="inp_red" />
                历史
                <input name="textfield19" type="text" id="textfield19" value="${academicScoreList[4]}"   size="3" class="inp_red" />
                政治
                <input name="textfield20" type="text" id="textfield20" value="${academicScoreList[5]}"   size="3" class="inp_red" />
                <span class="f_20">&nbsp;&nbsp;&nbsp;&nbsp;</span>技术
                <input name="textfield21" type="text" id="textfield21" value="${preppyInstance.skill?.label}"   size="6" class="inp_red" />
            </p></td>
        </tr>
    </g:if>
    <g:else>
        <tr>
            <td style="padding-left:30px;">5、
                <input class="inp_red" type="checkbox" name="checkbox4" id="checkbox4" <g:if test="${preppyInstance.schoolType?.name() == Preppy.SchoolType.SECONDARY.name()}">checked="checked"</g:if>/>
                中专生、
                <input class="inp_red" name="checkbox5" type="checkbox" id="checkbox5" <g:if test="${preppyInstance.schoolType?.name() == Preppy.SchoolType.INDUSTRIAL.name()}">checked="checked"</g:if> />
                技校生
                、
                <input class="inp_red" type="checkbox" name="checkbox6" id="checkbox6" <g:if test="${preppyInstance.schoolType?.name() == Preppy.SchoolType.HIGH.name()}">checked="checked"</g:if> />
                高中生</td>
        </tr>
    </g:else>

    <tr>
        <td style="padding-left:30px;">
            6、<g:if test="${preppyInstance.studentCateories.name() == Preppy.StudentCateories.WG.name()}">中专生、技校生原就读专业<input class="inp_red" name="textfield11" type="text" id="textfield11" value="${preppyInstance.middlePlan}"   size="16" />    </g:if>
            <span class="f_20">&nbsp;</span>申请旁听专业：
            <input class="inp_red" name="textfield12" type="text" id="textfield12" value="${preppyInstance.plan?.name}"   size="16" />（钟山专业）</td>
    </tr>
    <tr>
        <td class="f_20" style="padding-left:30px; padding-top:10px;"><strong>乙方向甲方申请跟班旁听学习，为保障双方合法权益签订以下协议：</strong></td>
    </tr>
    <tr>
        <td height="35" align="left" style="padding-left:30px;">
<g:if test="${preppyInstance.studentCateories.name() == Preppy.StudentCateories.SG.name()}">
    <div class="xy_xuzhi">
        一、甲方招收乙方为2015年旁听生。各项收费标准按甲方普高类在籍生收费标准执行，共收三年。乙方可以享用校内一切教育教学资源，但不能拥有政府规定在籍大学生的各种权利和福利。
        <br />二、甲方保证在符合下列条件下，2016年录取乙方为具有正式学籍的普高类高职生。
        <br />【普通高中生生源】：&#9312;参加2016年江苏省普通高校招生考试并取得成绩；&#9313;参加江苏省普通高校招生体检；<br />
        <span class="f_20">&nbsp;</span>&#9314;必须保证已有学业测试的成绩有效且技术为合格；&#9315;在规定的第一轮录取时间登录江苏省教育考试院网站，<br />
        <span class="f_20">&nbsp;</span>填报以甲方为唯一报考院校的志愿。 <br />
        三、【普通高中生生源】：如果乙方于2016年被甲方录取，则取得2016级学籍并享受2016级学生一切待遇。在旁听专业与正式录取专业一致的前提下，乙方在旁听阶段所取得的学分可以全部免修，继续随2015级跟读，但其毕业证书应随2016级学生发放。若旁听专业与正式录取专业不一致，甲方只认可旁听获得的公共课学分。
        <br />
        四、甲方会提前通知乙方参加2016年江苏省普通高校招生报名、考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的时间及流程。但是甲方并无组织乙方参加2016年江苏省普通高校招生考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的义务。乙方需按照江苏省教育考试院规定的时间，自行处理上述事宜。如果未能按时完成，导致在2016年无法正式被录取，甲方不承担任何责任。
        <br />
        五、乙方保证提供的上述信息准确无误，保证在校期间应遵守甲方的各项规章制度，如因违纪导致被开除，则本协议自动失效。<br />
        六、本协议自签订之后，乙方向甲方交纳保证金<input class="inp_red" name="textfield13" type="text" id="textfield13" value="${preppyInstance.deposit}"   size="7" />元，保证金将充抵学费，本协议有效期壹年。本协议一式2份，双方各一份。 </div>
    </g:if>
    <g:elseif test="${preppyInstance.studentCateories.name() == Preppy.StudentCateories.WG.name()}">
        <div class="xy_xuzhi">
      一、甲方招收乙方为2015年旁听生。各项收费标准按甲方普高类在籍生收费标准执行，共收三年。乙方可以享用校内一切教育教学资源，但不能拥有政府规定在籍大学生的各种权利和福利。<br />
      二、甲方保证在符合下列条件下，2016年录取乙方为具有正式学籍的普高类高职生。
      <br />
      【中职中技生生源】：&#9312;参加者2016年江苏省普通高校面向中职生注册入学报名；&#9313;参加2016年高考体检；<br />
      <span class="f_20">&nbsp;</span>&#9314;在规定的第一轮录取时间登录江苏省教育考试院网站填报以甲方为唯一报考院校的志愿。
      <br />
      三、【中职中技生生源】：旁听专业与正式录取专业必须一致。乙方在旁听阶段所取得的学分可以全部免修，继续随2015级跟读，但其毕业证书应随2016级学生发放。
     <br />
     四、甲方会提前通知乙方参加2016年江苏省普通高校招生报名、考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的时间及流程。但是甲方并无组织乙方参加2016年江苏省普通高校招生考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的义务。乙方需按照江苏省教育考试院规定的时间，自行处理上述事宜。如果未能按时完成，导致在2016年无法正式被录取，甲方不承担任何责任。
      <br />五、乙方保证提供的上述信息准确无误，保证在校期间应遵守甲方的各项规章制度，如因违纪导致被开除，则本协议自动失效。
      <br />六、本协议自签订之后，乙方向甲方交纳保证金
      <input class="inp_red" name="textfield13" type="text" id="textfield13" value="${preppyInstance.deposit}"   size="7" />
      元，保证金将充抵学费，本协议有效期壹年。本协议一式2份，双方各一份。
</p>
    </div>
    </g:elseif>
    <g:elseif test="${preppyInstance.studentCateories.name() == Preppy.StudentCateories.SZ.name()}">
        <div class="xy_xuzhi">
        一、甲方招收乙方为2015年旁听生。各项收费标准按甲方普高类在籍生收费标准执行，共收三年。乙方可以享用校内一切教育教学资源，但不能拥有政府规定在籍大学生的各种权利和福利。<br />
        二、甲方保证在符合下列条件下，2016年录取乙方为具有正式学籍的普高类高职生。
        <br />
        【中职中技生生源】：&#9312;参加者2016年江苏省普通高校面向中职生注册入学报名；&#9313;参加2016年高考体检；<br />
        <span class="f_20">&nbsp;</span>&#9314;在规定的第一轮录取时间登录江苏省教育考试院网站填报以甲方为唯一报考院校的志愿。
        <br />
        三、【中职中技生生源】：旁听专业与正式录取专业必须一致。乙方在旁听阶段所取得的学分可以全部免修，继续随2015级跟读，但其毕业证书应随2016级学生发放。
       <br />
       四、甲方会提前通知乙方参加2016年江苏省普通高校招生报名、考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的时间及流程。但是甲方并无组织乙方参加2016年江苏省普通高校招生考试、体检、填报志愿或江苏省普通高校面向中职注册入学报名、体检、填报志愿的义务。乙方需按照江苏省教育考试院规定的时间，自行处理上述事宜。如果未能按时完成，导致在2016年无法正式被录取，甲方不承担任何责任。
        <br />五、乙方保证提供的上述信息准确无误，保证在校期间应遵守甲方的各项规章制度，如因违纪导致被开除，则本协议自动失效。
        <br />六、本协议自签订之后，乙方向甲方交纳保证金
        <input class="inp_red" name="textfield13" type="text" id="textfield13" value="${preppyInstance.deposit}"   size="7" />
        元，保证金将充抵学费，本协议有效期壹年。本协议一式2份，双方各一份。
</p>
      </div>
    </g:elseif>

        </td>
    </tr>

    <tr>
        <td colspan="3" align="left" valign="top" style="padding-left:30px;"><table width="720" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
            <tr>
                <td width="134" valign="top" >★ <strong>需要提交的材料</strong>：</td>
                <td width="606" height="100" valign="top" >
                    <g:if test="${preppyInstance.reviewStatus.name() != com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">
                        <g:set var="rsid" value="%${preppyInstance.reviewStatus.id}%"/>
                        <g:each in="${com.baoming.Material.findAllByReviewStatusLike(rsid)}" var="material">
                            <div>${material.content}</div>
                        </g:each>
                    </g:if>
                </td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td colspan="3" align="left" style="padding:0 0 30px 30px;"><table width="720" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:10px;">
            <tr>
                <td width="350" valign="top" >甲方（盖章）：<br />              推&nbsp;&nbsp;&nbsp;&nbsp;荐&nbsp;&nbsp;&nbsp;&nbsp; 人：${preppyInstance.teacher?.name}</td>
                <td valign="top" >乙 方&nbsp;&nbsp;&nbsp;学&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;生： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 家&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;长：<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家庭住址：${preppyInstance.address}</td>
            </tr>
        </table></td>
    </tr>

    <tr>
        <td colspan="3" align="left" style="border-top:1px solid #cccccc;"><table width="740" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td width="281" height="45" valign="middle" ><span >学生手机：${preppyInstance.phone}</td>
                <td width="265" valign="middle" >家长手机：${preppyInstance.parentPhone}</td>
                <g:if test="${preppyInstance.reviewStatus.name() != com.baoming.Preppy.ReviewStatus.NO_AUDIT}">
                    <td width="194" valign="middle" >签订日期：<g:formatDate date="${preppyInstance.lastUpdated}" format="yyyy年MM月dd日"/> </td>
                </g:if>
                <g:else>
                    <td width="194" valign="middle" >签订日期：201&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;日</td>
                </g:else>
            </tr>
        </table></td>
    </tr>
</table>

</body>
</html>
