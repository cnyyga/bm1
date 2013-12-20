<g:each in="${citys}" var="city" status="tc">
    <li>
        <a href="${createLink(controller: 'student',action: 'list',params: [provinceId:city?.provinceId,cityId:city?.id,year:params.year?:year])}">
            <span class="green">${tc+1}</span>
            ${city.name}<strong style="padding-left: 10px;">${city.cc}</strong>
        </a>
    </li>
</g:each>