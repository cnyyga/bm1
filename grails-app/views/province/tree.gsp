
<g:each in="${provinces}" var="province">
    <li id="province${province.code}"><a href="javascript:void 0"  rel="1|${province.code}|${province.name}">${province.name}</a>
    <g:if test="${province.citys}">
        <ul>
            <g:each in="${province.citys}" var="city">
                <li id="city${city.code}"><a href="javascript:void 0" rel="2|${city.code}|${city.name}|${city?.province?.code}|${city?.province?.name}">${city.name}</a>
                      <g:if test="${city.districts}">
                          <ul>
                                <g:each in="${city.districts}" var="district">
                                    <li id="district${district.code}"><a href="javascript:void 0" rel="3|${district.code}|${district.name}|${district?.city?.code}|${district?.city?.name}">${district.name}</a>
                                </g:each>
                          </ul>
                      </g:if>
                </li>
            </g:each>
        </ul>
    </g:if>
    </li>
</g:each>
