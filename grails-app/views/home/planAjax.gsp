<g:each in="${plans}" var="plan" status="tc">
    <li>
        <a href="${createLink(controller: 'student',action: 'list',params: [planId:plan.id,year:params.year?:year])}">
            <span class="green">${tc+1}</span>
            ${plan.name}<strong style="padding-left: 10px;">${plan.cc}</strong>
        </a>
    </li>
</g:each>