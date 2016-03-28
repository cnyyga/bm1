<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>钟山职业技术学院</title>
    <script type="text/javascript">
       // window.print();
    </script>
</head>
<style>
.tianxie{ font-family:"微软雅黑"; font-size:16px;  }
.tianxie td{  padding:5px 0 5px 3px;}
.inp_gray{ font-size:14px; color:#000000; border:#d1d1d1 1px solid; height:24px;  font-family:"微软雅黑";  }
.sel_gray{ font-size:14px; font-family:"微软雅黑";}
.inp_red{ font-size:18px; color:#cc0000; border-bottom:#888888 1px solid;border-left-width:0px;border-right-width:0px;border-top-width:0px; font-family:"微软雅黑"; text-align:left; }

</style>
<body>
<table width="750" border="0" align="center" cellpadding="0" cellspacing="1" class="tianxie" style="background:#cccccc;" >
    <tr>
        <td height="50" colspan="5" align="center" bgcolor="#FFFFFF"><strong style="font-size:26px;">${new Date().format('yyyy')}注册入学关键信息采集表</strong></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">姓名： <span class="f_20">
            <input class="inp_red" name="textfield6" type="text" id="textfield6"   value="${preppyInstance.name}" size="8" />
        </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;性别： <span class="f_20">
            <input class="inp_red" name="textfield10" type="text" id="textfield11"   value="${preppyInstance?.gender?.label}" size="4" />
        </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;民族： <span class="f_20">
            <input class="inp_red" name="textfield11" type="text" id="textfield13"   value="${preppyInstance?.nation?.name}" size="6" />
        </span>&nbsp;&nbsp;&nbsp;&nbsp;出生日期： <span class="f_20">
            <input class="inp_red" name="textfield12" type="text" id="textfield14"   value="${preppyInstance?.birthday?.format("yyyy年MM月dd日")}" size="17" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">身份证号：<span class="f_20">
            <input class="inp_red" name="textfield13" type="text" id="textfield16"   value="${preppyInstance.number}" size="70" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">户&nbsp;&nbsp;籍&nbsp;地：<span class="f_20">
            <input class="inp_red" name="textfield23" type="text" id="textfield25"   value="${preppyInstance.province?.name}省${preppyInstance.city?.name}市${preppyInstance.district?.name}县(区.市)${preppyInstance.town}" size="70" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">详细地址：<span class="f_20">
            <input class="inp_red" name="textfield24" type="text" id="textfield26"   value="${preppyInstance.address}" size="70" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">家长电话：<span class="f_20">
            <input class="inp_red" name="textfield25" type="text" id="textfield27"   value="${preppyInstance.parentPhone}" size="15" />
            &nbsp;&nbsp;学生电话：
            <input class="inp_red" name="textfield26" type="text" id="textfield28"   value="${preppyInstance.phone}" size="15" />
        </span><span class="f_20"> &nbsp;&nbsp;</span>学生QQ：<span class="f_20">
            <input class="inp_red" name="textfield27" type="text" id="textfield29"   value="${preppyInstance.qq}" size="14" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF">毕业中学(中职名称)：<span class="f_20">
            <input class="inp_red" name="textfield28" type="text" id="textfield30"   value="${preppyInstance?.resume?.highSchool}" size="62" />
        </span></td>
    </tr>
    <tr>
        <td width="129" height="40" align="left" bgcolor="#FFFFFF">本&nbsp;&nbsp;人&nbsp;&nbsp;简&nbsp;&nbsp;历：</td>
        <td width="158" align="center" bgcolor="#FFFFFF">自何年何月</td>
        <td width="133" align="center" bgcolor="#FFFFFF">至何年何月</td>
        <td width="238" align="center" bgcolor="#FFFFFF">在何校学习(中职须注明专业)</td>
        <td width="86" align="center" bgcolor="#FFFFFF">证明人</td>
    </tr>
    <tr>
        <td height="40" align="left" bgcolor="#FFFFFF">初&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中：</td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield5" type="text" id="textfield5"   value="${preppyInstance?.resume?.juniorStart?.format("yyyy年MM月")}" size="12" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield8" type="text" id="textfield8"   value="${preppyInstance?.resume?.juniorEnd?.format("yyyy年MM月")}" size="12" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield" type="text" id="textfield"   value="${preppyInstance?.resume?.juniorSchool}" size="15" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield3" type="text" id="textfield3"   value="${preppyInstance?.resume?.juniorAuthenticator}" size="8" />
        </span></td>
    </tr>
    <tr>
        <td height="40" align="left" bgcolor="#FFFFFF">高中（中职）：</td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield7" type="text" id="textfield7"   value="${preppyInstance?.resume?.highStart?.format("yyyy年MM月")}" size="12" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield9" type="text" id="textfield9"   value="${preppyInstance?.resume?.highEnd?.format("yyyy年MM月")}" size="12" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield2" type="text" id="textfield2"   value="${preppyInstance?.resume?.highSchool}${preppyInstance?.resume?.zzzy}" size="15" />
        </span></td>
        <td align="center" bgcolor="#FFFFFF"><span class="f_20">
            <input class="inp_red" name="textfield4" type="text" id="textfield4"   value="${preppyInstance?.resume?.highAuthenticator}" size="8" />
        </span></td>
    </tr>
    <tr>
        <td height="40" align="left" bgcolor="#FFFFFF">就读我院专业：</td>
        <td colspan="4" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<span class="f_20">
            <input class="inp_red" name="textfield22" type="text" id="textfield24"   value="${preppyInstance.plan?.name}" size="65" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" bgcolor="#FFFFFF"><table width="740" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2">2017年高考报名地选择：<span class="f_20">
                    <input class="inp_red" name="textfield14" type="text" id="textfield17"   value="${preppyInstance.collegeSignUp?.label}" size="59" />
                </span></td>
            </tr>
            <tr>
                <td colspan="2">备注1：<span class="f_20">
                    <input class="inp_red" name="textfield18" type="text" id="textfield21"   value="2017年高考报名" size="72" value="${preppyInstance.remark}" />
                </span></td>
            </tr>
            <tr>
                <td colspan="2">备注2：<span class="f_20">
                    <input class="inp_red" name="textfield19" type="text" id="textfield22" size="72" value="${preppyInstance.remark1}" />
                </span></td>
            </tr>
            <tr>
                <td colspan="2">备注3：<span class="f_20">
                    <input class="inp_red" name="textfield21" type="text" id="textfield23" size="72" value="${preppyInstance.remark2}" />
                </span></td>
            </tr>
            <tr>
                <td colspan="2">辅导员，辅导员电话：<span class="f_20">
                    <input class="inp_red" name="textfield211" type="text" id="textfield231" size="60" value="${preppyInstance.counselor}${preppyInstance.counselorPhone}" />
                </span></td>
            </tr>
            <tr>
                <td>科目组：<span class="f_20">
                    <input class="inp_red" name="textfield16" type="text" id="textfield18"   value="${preppyInstance.preppyPlan?.name}" size="40" />
                </span></td>
                <td>签约人：<span class="f_20">
                    <input class="inp_red" name="textfield17" type="text" id="textfield19"   value="${preppyInstance.teacher?.name}" size="20" />
                </span></td>
            </tr>
        </table></td>
    </tr>

    <tr>
        <td bgcolor="#FFFFFF">该生的身份是：</td>
        <td colspan="4" bgcolor="#FFFFFF">1、<span class="f_20">
            <input class="inp_red" name="textfield29" type="text" id="textfield31"   value="${preppyInstance.family?.label}" size="62" />
        </span><span class="f_20">
            &nbsp;&nbsp;<br />
            2、
            <input class="inp_red" name="textfield30" type="text" id="textfield32"   value="${preppyInstance.studentCateories?.label}" size="62" />
        </span></td>
    </tr>
    <tr>
        <td colspan="5" align="left" bgcolor="#FFFFFF"><p>填表人：<span class="f_20">
            <input class="inp_red" name="textfield31" type="text" id="textfield33"   value="" size="29" />
        </span> 填表日期：<span class="f_20">
            <input class="inp_red" name="textfield32" type="text" id="textfield34"   value="${preppyInstance.reviewDate?.format("yyyy年MM月dd日")}" size="30" />
        </span></p></td>
    </tr>

    <g:if test="${preppyInstance.reviewStatus && preppyInstance.reviewStatus?.name() != com.baoming.Preppy.ReviewStatus.NO_AUDIT.name()}">
        <tr>
            <td colspan="5" align="center" bgcolor="#FFFFFF"><input type="submit" name="button" id="button" value="打印" onclick="javascript:window.print();"/>
                &nbsp;&nbsp;<br /></td>
        </tr>
    </g:if>
</table>
<p>&nbsp;</p>
</body>
</html>
