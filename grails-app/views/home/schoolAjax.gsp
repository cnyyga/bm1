<g:each in="${middleSchools}" var="ms" status="tc">
    <li>
        <a href="${createLink(controller: 'student',action: 'list',params: [middleSchoolId:ms.id,year:params.year?:year])}">
            <span class="green">${tc+1}</span>
            ${ms.name}<strong style="padding-left: 10px;">${ms.cc}</strong>
        </a>
    </li>
</g:each>