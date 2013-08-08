<div class="form-horizontal">
    <fieldset>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.payment.type.label" default="type" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.payment?.type?.label}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label" >
        <g:message code="student.payment.name.label" default="name" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.payment?.name}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.payment.account.label" default="account" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.payment?.account}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.payment.amount.label" default="amount" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.payment?.amount}
        </span>
    </div>
</div>
<div class="control-group">
    <label class="control-label">
        <g:message code="student.payment.date.label" default="date" />
    </label>
    <div class="controls">
        <span class="property-value">
            ${studentInstance?.payment?.date?.format('yyyy-MM-dd')}
        </span>
    </div>
</div>
       %{-- <div class="control-group">
            <label class="control-label">
                <g:message code="student.payment.docPic.label" default="docPic" />
            </label>
            <div class="controls">
                <span class="property-value">
                    <g:if test="${studentInstance?.payment?.docPic}">
                        <g:link action="img"  controller="api" id="${studentInstance?.payment?.docPic}" target="_blank">
                    <img src="${createLink(controller: 'api',action: 'img',id: studentInstance?.payment?.docPic)}" style="height: 100px;" title="点击查看原图"/>
                            </g:link>
                    <a href="javascript:void 0" class="payment-del-pic" rel="${createLink(action: 'delPaymentPic',id:studentInstance?.id)}"><g:message code="default.button.delete.label"/></a>
                    </g:if>
                </span>
            </div>
        </div>--}%
        <div class="control-group">
            <label class="control-label">
                <g:message code="student.payment.docDate.label" default="docDate" />
            </label>
            <div class="controls">
                <span class="property-value">
                    ${studentInstance?.payment?.docDate?.format('yyyy-MM-dd')}
                </span>
            </div>
        </div>
    </fieldset></div>
