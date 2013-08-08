<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'province.label', default: 'Province')}" />
    <g:if test="${params.t == 'district'}">
        <g:set var="entityName" value="${message(code: 'district.label')}"/>
    </g:if>
    <g:if test="${params.t == 'city'}">
        <g:set var="entityName" value="${message(code: 'city.label')}"/>
    </g:if>
    <title><g:message code="default.create.label" args="[entityName]" /></title>

</head>
<body>
<div>
    <ul class="breadcrumb">
        <li>
            <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
        </li>
        <li>
            <g:link class="list" action="list"><g:message code="default.list.label" args="[message(code:'province.label')]" /></g:link>
            <g:if test="${params.t == 'city'}">
                <span class="divider">/</span>
                <g:link action="list" params="${[id:instanceObj?.code,t:'city']}">${instanceObj?.name}</g:link>
            </g:if>
            <g:if test="${params.t == 'district'}">
                <span class="divider">/</span>
                <g:link action="list" params="${[id:instanceObj?.province?.code,t:'city']}">${instanceObj?.province?.name}</g:link>
                <span class="divider">/</span>
                <g:link action="list" params="${[id:instanceObj?.code,t:'district']}">${instanceObj?.name}</g:link>
            </g:if>
            <span class="divider">/</span>
            <a href="javascript:void 0"><g:message code="default.create.label" args="[entityName]" /></a>

        </li>
    </ul>
</div>
<g:if test="${flash.message}">
    <div class="alert alert-error">${flash.message}</div>
</g:if>


<div class="row-fluid sortable">
    <div class="box span12">
        <div class="box-header well" data-original-title>
            <h2><i class="icon-edit"></i> <g:message code="default.add.label" args="[entityName]" /></h2>
        </div>
        <div class="box-content">
            <g:form class="form-horizontal" action="save" params="${[t:params.t,id:params.id]}">

                <fieldset>
                    <g:render template="form"/>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">${message(code: 'default.button.update.label')}</button>
                        <button type="reset" class="btn">${message(code: 'default.button.reset.label')}</button>
                    </div>
                </fieldset>
            </g:form>

        </div>
    </div><!--/span-->

</div><!--/row-->

</body>
</html>
