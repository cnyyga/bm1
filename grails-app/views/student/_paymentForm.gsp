<div class="control-group">
    <label class="control-label" for="payment.type">
        <g:message code="student.payment.type.label" default="type" />
    </label>
    <div class="controls">
        <g:select name="payment.type" value="${studentInstance?.payment?.type}" from="${com.baoming.account.Payment.Type.values()}" optionValue="label" noSelection="${['':'未缴费']}" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.name">
        <g:message code="student.payment.name.label" default="name" />
    </label>
    <div class="controls">
        <g:textField name="payment.name" value="${studentInstance?.payment?.name}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.account">
        <g:message code="student.payment.account.label" default="account" />
    </label>
    <div class="controls">
        <g:textField name="payment.account" value="${studentInstance?.payment?.account}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="payment.amount">
        <g:message code="student.payment.amount.label" default="amount" />
    </label>
    <div class="controls">
        <g:textField name="payment.amount" value="${studentInstance?.payment?.amount}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="paymentDate">
        <g:message code="student.payment.date.label" default="date" />
    </label>
    <div class="controls">
        <g:textField name="paymentDate" class="datepicker" value="${studentInstance?.payment?.date?.format('yyyy-MM-dd')}"/>
    </div>
</div>
%{--<div class="control-group">
    <label class="control-label" for="docPic">
        <g:message code="student.payment.docPic.label" default="docPic" />
    </label>
    <div class="controls" >
        <input type="file" name="docPic" id="docPic" />
        <g:hiddenField id="paymentDocPic" name="payment.docPic" value="${studentInstance?.payment?.docPic}"/>
        <g:if test="${studentInstance?.payment?.docPic}">
            <div style="position: relative;height: 100px;">
            <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.payment?.docPic)}"  />
             <a href="javascript:void 0" class="payment-del-pic"><g:message code="default.button.delete.label"/></a>
            </div>
        </g:if>
    </div>
</div>--}%



