<ul>
    <li>
        <g:link controller="profile" action="preppy" params="${[v:'info']}">
            旁听生信息采集
        </g:link>
    </li>
    %{--<li>
        <g:link controller="profile" action="edit" params="${[v:'plan']}">
            <g:message code="plan.label"/>
        </g:link>
    </li>
    <li>
        <g:link controller="profile" action="edit" params="${[v:'payment']}">
            <g:message code="student.payment.label"/>
        </g:link>
    </li>--}%
    <li>
        <g:link controller="profile" action="rePassword">
            <g:message code="operator.changepassword.label"/>
        </g:link>
    </li>
</ul>