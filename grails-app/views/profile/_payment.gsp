
        <ul class="reg_box">
            <li class="live">
                <label class="reg_tit"><g:message code="student.payment.type.label"/>：</label>

                <div class="reg_element">

                        <g:select name="payment.type" value="${student?.payment?.type}" from="${com.baoming.account.Payment.Type.values()}" optionValue="label" noSelection="${['':'未缴费']}" />

                </div>

            </li>
            <li class="live">
                <label class="reg_tit"><g:message code="student.payment.name.label"/>：</label>

                <div class="reg_element">

                        <g:textField name="payment.name" class="txt" value="${student?.payment?.name}"/>

                </div>

            </li>

            <li class="live">
                <label class="reg_tit"><g:message code="student.payment.account.label"/>：</label>

                <div class="reg_element">

                        <g:textField name="payment.account" class="txt" value="${student?.payment?.account}"/>

                </div>

            </li>

            <li class="live">
                <label class="reg_tit"><g:message code="student.payment.amount.label"/>：</label>

                <div class="reg_element">

                        <g:textField name="payment.amount" class="txt" value="${student?.payment?.amount}"/>

                </div>

            </li>
            <li class="live">
                <label class="reg_tit"><g:message code="student.payment.date.label"/>：</label>

                <div class="reg_element">


                        <%
                            def cal = Calendar.instance
                            def year = cal.get(Calendar.YEAR)
                        %>
                        <g:datePicker name="paymentDate" value="${student?.payment?.date}" precision="day"
                                      years="${1900..year}"/>


                </div>

            </li>

           %{-- <li class="live">
                <label class="reg_tit"><g:message code="student.payment.docPic.label"/>：</label>

                <div class="reg_element">
                    <g:if test="${student?.payment?.docPic}">
                        <g:link action="img"  controller="api" id="${student?.payment?.docPic}"  target="_blank">
                        <img src="${createLink(controller: 'api',action: 'img',id: student?.payment?.docPic)}" title="点击查看原图" style="height: 100px;position: absolute;right: 0" />
                        </g:link>
                    </g:if>

                        <input type="file" name="docPic" id="docPic" /> <g:message code="student.payment.docPic.message"/>
                </div>
            </li>--}%
            <li class="live">
                <label class="reg_tit"><g:message code="student.admissionTicketNumber.pic.label"/>：
                    <span class="required-indicator">*</span></label>

                <div class="reg_element">
                    <g:if test="${student?.admissionTicketPic}">
                        <g:link action="img"  controller="api" id="${student?.admissionTicketPic}"  target="_blank">
                            <img src="${createLink(controller: 'api',action: 'img',id: student?.admissionTicketPic)}" title="点击查看原图" style="height: 100px;" />
                        </g:link>
                    </g:if>
                    <g:else>

                    <input type="file" name="admissionTicketPicInp" id="admissionTicketPicInp" /> <label class="error"><g:message code="student.admissionTicketNumber.pic.message"/></label>
                    </g:else>

                </div>
            </li>

        </ul>
