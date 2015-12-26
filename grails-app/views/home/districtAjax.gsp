<g:each in="${districts}" var="district" status="tc">
    <li>
        <a href="${createLink(controller: 'student',action: 'list',params: [provinceId:district?.provinceCode,cityId:district?.cityCode,districtId:district.code,year:params.year?:year])}">
            <span class="green">${tc+1}</span>
            ${district.cityName}${district.name}<strong style="padding-left: 10px;">${district.cc}</strong>
        </a>
    </li>
</g:each>