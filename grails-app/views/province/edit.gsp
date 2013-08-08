<%@ page import="com.baoming.PoliticalStatus" %>
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
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <g:javascript src="jquery.validate.min.js"/>
    <g:javascript src="card.js"/>
    <g:javascript src="additional-methods.js"/>
    <g:javascript src="messages_zh.js"/>
    <g:javascript src="all.js"/>
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
            <a href="javascript:void 0"><g:message code="default.edit.label" args="[instance?.name?:entityName]" /></a>
        </li>
    </ul>
</div>
<g:if test="${flash.message}">
    <div class="alert alert-error">${flash.message}</div>
</g:if>
<g:hasErrors bean="${instance}">
    <ul class="alert alert-error" >
        <g:eachError bean="${instance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
        </g:eachError>
    </ul>
</g:hasErrors>

<div class="row-fluid sortable">
    <div class="box span12">
        <div class="box-header well" data-original-title>
            <h2><i class="icon-edit"></i> <g:message code="default.edit.label" args="[entityName]" /></h2>
        </div>
        <div class="box-content">
            <g:form class="form-horizontal" action="update" params="[t:params.t,id:params.id,pid:params.pid]">
                <g:hiddenField name="id" value="${instance?.code}" />
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
