<%@ page import="com.baoming.Province; com.baoming.MiddleSchool; com.baoming.Nation; com.baoming.PoliticalStatus; com.baoming.account.Student" %>

<ul class="reg_box">

    <li class="name">
        <label class="reg_tit">姓名：   <span class="required-indicator">*</span></label>

        <div class="reg_element">
            <span class="inp_box">
                <input type="text" name="name" class="txt" value="${student?.name}" readonly="${!!student?.name}">

             </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">考生号： <span class="required-indicator">*</span> </label>

        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="code" value="${student?.code}" class="txt" readonly="${!!student?.code}"/>
            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">准考证号：   </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="admissionTicketNumber" value="${student?.admissionTicketNumber}" class="txt" />
            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">身份证号：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="number" value="${student?.number}" class="txt" readonly="true"/>
            </span>
        </div>
    </li>

    <li class="sing">
        <label class="reg_tit">性别：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element reg_lh">

            <g:each in="${com.baoming.account.User.Gender.values()}" var="gender">
                <g:set var="genderChk" value=""/>
                <g:if test="${!student?.gender || student?.gender == gender}">
                    <g:set var="genderChk" value="checked"/>
                </g:if>
                <g:radio name="gender" value="${gender}" checked="${genderChk}"></g:radio>   ${gender.label}
            </g:each>

        </div>
    </li>
    <li class="birthday">
        <label class="reg_tit reg_birthday">生日：        <span class="required-indicator">*</span>
        </label>
        <div id="selectBox" class="reg_element reg_mt3">


                <%
                    def cal = Calendar.instance
                    def year = cal.get(Calendar.YEAR)
                %>
                <g:datePicker name="birthday" value="${student?.birthday ?: cal.time}" precision="day"
                              years="${1900..year}"/>


        </div>
    </li>
    <li class="live">
        <label class="reg_tit">政治面貌：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element">
            <span class="inp_box">

                    <g:select name="politicalStatus.id" from="${PoliticalStatus.list()}" value="${student?.politicalStatus?.id}"
                              optionKey="id" optionValue="name" noSelection="['': '请选择']"></g:select>


            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">民族：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element">
            <span class="inp_box">

                    <g:select name="nation.id" from="${Nation.list()}" value="${student?.nation?.id}" optionKey="id"
                              optionValue="name" noSelection="['': '请选择']"></g:select>


            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit"><g:message code="student.district.label"/>：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element">
            <span class="inp_box">

                <g:select name="provinceId" id="province" from="${Province.list()}" noSelection="['': '请选择']" value="${student?.province?.code}" optionKey="code" optionValue="name"></g:select>
                <g:select name="cityId" id="city" from="${[]}" noSelection="['': '==选择==']"></g:select>
                <g:select name="districtId" id="district" from="${[]}"  noSelection="['': '==选择==']"></g:select>


            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">毕业中学：
        </label>
        <div class="reg_element">
            <span class="inp_box">

                    <g:select name="middleSchool.id" id="middleSchooleId" from="${MiddleSchool.list()}" value="${student?.middleSchool?.id}"
                              optionKey="id" optionValue="name"></g:select>


            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">家庭地址：
        </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="address" value="${student?.address}" class="txt" />
            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">家庭电话：
        </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="tel" value="${student?.tel}" class="txt" />
            </span>
        </div>
    </li>

    <li class="live">
        <label class="reg_tit">手机：        <span class="required-indicator">*</span>
        </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="phone" value="${student?.phone}" class="txt"/>
            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">邮政编码：</label>

        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="postcode" value="${student?.postcode}" class="txt"  />
            </span>
        </div>
    </li>

    <li class="live">
        <label class="reg_tit">邮件：
        </label>
        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="email" value="${student?.email}" class="txt" />
            </span>
        </div>
    </li>
    <li class="live">
        <label class="reg_tit">QQ：</label>

        <div class="reg_element">
            <span class="inp_box">
                <g:textField name="qq" value="${student?.qq}" class="txt"/>
            </span>
        </div>
    </li>



</ul>
<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${student?.city?.code}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${student?.district?.code}" />
<g:hiddenField name="schoolUrl" value="${createLink(action: 'schoolOpts',controller: 'api')}"  title="${student?.middleSchool?.id}" />
