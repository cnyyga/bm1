<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>钟山职业技术学院</title>
</head>

<body>
<style>
.main_table input{ font-family:'微软雅黑'; font-weight:bold; font-size:16px;}
</style>
<div style="text-align:center;"><span style="font-size:30px; font-family:'微软雅黑'; font-weight:bold;">2016年注册入学关键信息采集表</span></div>
<br />
<table width="750" border="0" align="center" cellpadding="0" cellspacing="1" style="background:#666666; font-family:'微软雅黑'; font-size:15px;" class="main_table"  >
    <tr>
        <td width="118" height="45" align="center" bgcolor="#FFFFFF" style="padding-left:8px;">姓 名</td>
        <td width="80" align="left" bgcolor="#FFFFFF" style="padding-left:5px;">
            <input name="textfield" type="text"   id="textfield" value="${preppyInstance.name}" size="8" /></td>
        <td width="53" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">性别</td>
        <td width="50" align="left" bgcolor="#FFFFFF" ><label>
            <input name="radio" type="radio" id="radio" value="radio" checked="checked" />${preppyInstance?.gender?.label}<br /></label></td>
        <td width="52" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">民族</td>
        <td width="51" align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield20" type="text"   id="textfield13" value="${preppyInstance?.nation?.name}" size="4" /></td>
        <td width="92" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">出生日期</td>
        <td width="245" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="180" border="0" cellpadding="0" cellspacing="0">

            <tr>
                <td><input name="textfield7" type="text"  id="textfield7" value="${preppyInstance?.birthday.toCalendar().get(Calendar.YEAR)}"   size="5" /></td>
                <td>年</td>
                <td><input name="textfield8" type="text"  id="textfield8" value="${preppyInstance?.birthday.toCalendar().get(Calendar.MONTH)}"   size="4" /></td>
                <td>月</td>
                <td><input name="textfield9" type="text"  id="textfield9" value="${preppyInstance?.birthday.toCalendar().get(Calendar.DATE)}"   size="4" /></td>
                <td>日</td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:8px;">身份证号</td>
        <td colspan="7" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="620" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <g:set var="num" value="${preppyInstance.number}"/>
                <g:set var="numLen" value="${num.length()}"/>
                <g:each in="${(0..17)}" var="nn" status="i">
                    <td><input name="textfield${i}" type="text"   id="textfield${i}"
                               style="height:20px;width:20px;text-align:center;font-size:16px; font-weight:bold;" value="${numLen>i?num[i]:''}" size="2" /></td>
                </g:each>

            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">户籍地</td>
        <td colspan="7" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="620" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td width="71"><input name="textfield39" type="text"  id="textfield39" value="${preppyInstance.province?.name}"   size="8" /></td>
                <td width="17">省</td>
                <td width="71"><input name="textfield40" type="text"  id="textfield40" value="${preppyInstance.city?.name}"   size="8" /></td>
                <td width="17">市</td>
                <td width="82"><input name="textfield41" type="text"  id="textfield41" value="${preppyInstance.district?.name}"   size="8" /></td>
                <td width="95">县(区.市)</td>
                <td width="148"><input name="textfield42" type="text"  id="textfield42" value="${preppyInstance.town}"   size="20" /></td>
                <td width="119">乡镇(街道)</td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">详细地址</td>
        <td colspan="7" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield2" type="text"   id="textfield2" value="${preppyInstance.address}" size="70" /></td>
    </tr>

    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">家长电话</td>
        <td colspan="7" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="620" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td width="156"><input name="textfield5" type="text"  id="textfield5" value="${preppyInstance.parentPhone}"   size="15" /></td>
                <td width="79">学生电话</td>
                <td width="156" align="left"><input name="textfield3" type="text"  id="textfield3" value="${preppyInstance.phone}"   size="15" /></td>
                <td width="75">学生QQ</td>
                <td width="154" align="left"><input name="textfield4" type="text"  id="textfield4" value="${preppyInstance.qq}"   size="12" /></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">毕业中学<br />
            （中职）名称</td>
        <td colspan="7" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield2" type="text"   id="textfield2" value="如皋中学" size="70" /></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">本人简历</td>
        <td colspan="7" rowspan="3" align="left" bgcolor="#FFFFFF" ><table width="632" border="0" align="left" cellpadding="0" cellspacing="1" style="background:#999999"    >
            <tr>
                <td width="151" height="45" align="center" bgcolor="#FFFFFF" >自何年何月</td>
                <td width="149" align="center" bgcolor="#FFFFFF" >至何年何月</td>
                <td colspan="4" align="center" bgcolor="#FFFFFF" >在何校学习(中职须注明专业)</td>
                <td width="99" align="center" bgcolor="#FFFFFF" >证明人</td>
            </tr>
            <tr>
                <td height="45" align="left" valign="middle" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="120" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><input name="textfield10" type="text"  id="textfield10" style="width:40px; height:20px;" value="2009"   size="4" /></td>
                        <td>年</td>
                        <td><input name="textfield10" type="text"  id="textfield11" style="width:40px; height:20px;" value="09"   size="2" /></td>
                        <td>月</td>
                    </tr>
                </table></td>
                <td align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="120" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><input name="textfield11" type="text"  id="textfield14" style="width:40px; height:20px;" value="2012"   size="4" /></td>
                        <td>年</td>
                        <td><input name="textfield11" type="text"  id="textfield21" style="width:40px; height:20px;" value="06"   size="2" /></td>
                        <td>月</td>
                    </tr>
                </table></td>
                <td colspan="4" align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield21" type="text" id="textfield44" value="南通如皋中学" size="28"   /></td>
                <td align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield21" type="text" id="textfield45" value="张兰" size="10"   /></td>
            </tr>
            <tr>
                <td height="45" align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="120" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><input name="textfield13" type="text"  id="textfield46" style="width:40px; height:20px;" value="2012"   size="4" /></td>
                        <td>年</td>
                        <td><input name="textfield13" type="text"  id="textfield47" style="width:40px; height:20px;" value="09"   size="2" /></td>
                        <td>月</td>
                    </tr>
                </table></td>
                <td align="left" bgcolor="#FFFFFF" style="padding-left:5px;"><table width="120" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><input name="textfield14" type="text"  id="textfield51" style="width:40px; height:20px;" value="2015"   size="4" /></td>
                        <td>年</td>
                        <td><input name="textfield14" type="text"  id="textfield52" style="width:40px; height:20px;" value="06"   size="2" /></td>
                        <td>月</td>
                    </tr>
                </table></td>
                <td colspan="4" align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield21" type="text" id="textfield48" value="南通如皋中学" size="28"   /></td>
                <td align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><input name="textfield21" type="text" id="textfield49" value="王兰" size="10"   /></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">初中</td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;">高中（中职）</td>
    </tr>
    <tr>
        <td height="45" align="center" bgcolor="#FFFFFF" style="padding-left:5px;"><strong>就读我院专业</strong></td>
        <td colspan="7" align="left" bgcolor="#FFFFFF"  style="padding-left:5px;">
            <input name="textfield6" type="text"   id="textfield6" value="${preppyInstance.plan?.name}" size="70" />
        </td>
    </tr>
    <tr>
        <td height="165"  colspan="8" align="center" bgcolor="#FFFFFF" style="padding:8px 0;" >

            <table width="720" border="0" align="center" cellpadding="0" cellspacing="1" style="background:#999999; font-family:'微软雅黑';" >
                <tr>
                    <td width="201" height="30" align="center" bgcolor="#FFFFFF" >2017年高考报名地选择</td>
                    <td colspan="2" bgcolor="#FFFFFF">
                        <input name="checkbox" type="checkbox"  id="checkbox" <g:if test="${preppyInstance.collegeSignUp == com.baoming.Preppy.CollegeSignUp.SG}">checked="checked"</g:if>  />
                        1.钟山学院 <span style="padding-left:10px;">
                        <input  type="checkbox" name="checkbox2" id="checkbox2"  <g:if test="${preppyInstance.collegeSignUp == com.baoming.Preppy.CollegeSignUp.WG}">checked="checked"</g:if>/>
                    </span>2.原籍、原校 <font style="font-size:13px;">(注:非江苏户籍学生全部选1,江苏户籍任选)</font></td>
                </tr>
                <tr>
                    <td height="30" align="center" bgcolor="#FFFFFF">备注1</td>
                    <td colspan="2" bgcolor="#FFFFFF"><input name="textfield15" type="text" id="textfield15" value="${preppyInstance.remark}" size="55"   /></td>
                </tr>
                <tr>
                    <td height="30" align="center" bgcolor="#FFFFFF">备注2</td>
                    <td colspan="2" bgcolor="#FFFFFF"><input name="textfield12" type="text" id="textfield12" size="55"   value="${preppyInstance.remark1}"  /></td>
                </tr>
                <tr>
                    <td height="30" align="center" bgcolor="#FFFFFF">备注3</td>
                    <td colspan="2" bgcolor="#FFFFFF"><input name="textfield16" type="text" id="textfield16" size="55"   value="${preppyInstance.remark2}"  /></td>
                </tr>
                <tr>
                    <td height="30" align="center" bgcolor="#FFFFFF"><strong>科目组</strong></td>
                    <td width="282" bgcolor="#FFFFFF"><input name="textfield17" type="text"   id="textfield17" value="${preppyInstance.preppyPlan?.name}"  size="40" /></td>
                    <td width="213" align="center" bgcolor="#FFFFFF"><strong>签约人</strong>              <input name="textfield19" type="text"   id="textfield19" value="${preppyInstance.teacher?.name}" size="15" /></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<br />
<table width="750" border="0" align="center" cellpadding="0" cellspacing="1" style="background:#666666; font-family:'微软雅黑';font-size:15px;"  >
    <tr>
        <td height="45" colspan="4" align="center" bgcolor="#FFFFFF" style="padding-left:8px;"><strong style="font-size:18px;">请选择你的身份必须真实有效！如选错，将无法取得我院学籍。</strong></td>
    </tr>
    <tr>
        <td width="48" height="45" align="center" bgcolor="#FFFFFF" >非<br />
            江苏<br />
            户籍<br />
            学生</td>
        <td width="298" align="left" bgcolor="#FFFFFF" ><table width="290" border="0" cellpadding="0">
            <tr>
                <td>
                    <input name="checkbox4" type="checkbox"  id="checkbox4" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC10}">checked="checked"</g:if> />
                </td>
                <td>1.曾在江苏高中(中职)读书</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox5" id="checkbox5" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC11}">checked="checked"</g:if>/>
                </td>
                <td>2.一直在其他省份高中(中职)读书</td>
            </tr>
        </table></td>
        <td width="45" align="center" bgcolor="#FFFFFF" >江苏<br />
            户籍<br />
            学生</td>
        <td width="354" align="left" bgcolor="#FFFFFF" ><table width="334" border="0">
            <tr>
                <td width="22">
                    <input  type="checkbox" name="checkbox6" id="checkbox8" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC4}">checked="checked"</g:if>/>
                </td>
                <td width="302">1.中职在校生</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox7" id="checkbox9" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC5}">checked="checked"</g:if>/>
                </td>
                <td>2.普通高中在校生</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox8" id="checkbox10" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC6}">checked="checked"</g:if> />
                </td>
                <td>3.中职毕业生未曾被普通高校录取</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox9" id="checkbox11" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC7}">checked="checked"</g:if>/>
                </td>
                <td>4.中职毕业生已经被普通高校录取</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox10" id="checkbox12" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC8}">checked="checked"</g:if>/>
                </td>
                <td>5.普通高中毕业生未曾被普通高校录取</td>
            </tr>
            <tr>
                <td>
                    <input  type="checkbox" name="checkbox11" id="checkbox13" <g:if test="${preppyInstance.studentCateories ==com.baoming.Preppy.StudentCateories.SC9}">checked="checked"</g:if>/>
                </td>
                <td>6.普通高中毕业生已经被普通高校录取</td>
            </tr>
        </table></td>
    </tr>
</table>
<br />
</body>
</html>
