<g:each in="${teachers}" var="tea" status="tc">
    <li>
        <a href="${createLink(controller: 'student',action: 'list',params: [teacherId:tea.id,year:params.year?:year])}">
            <span class="green">${tc+1}</span>
            ${tea.name}<strong style="padding-left: 10px;">${tea.cc}</strong>
        </a>
    </li>
</g:each>