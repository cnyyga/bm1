<g:hiddenField name="cityUrl" value="${createLink(action: 'cityOpts',controller: 'api')}" title="${middleSchoolInstance?.district?.city?.code}"  />
<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOpts',controller: 'api')}"  title="${middleSchoolInstance?.district?.code}" />

<div class="control-group">
    <label class="control-label" for="district">
        <g:message code="district.label" default="District" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:select id="province" name="provinceId" from="${com.baoming.Province.list()}" optionValue="name" optionKey="code"  class="many-to-one"/>
        <g:select id="city" name="cityId" from="${[]}"/>
        <g:select id="district" name="districtId" from="${[]}"  />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="middleSchool.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>

    <div class="controls">
        <g:textField name="name" value="${middleSchoolInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="code">
		<g:message code="middleSchool.code.label" default="Code" />
        <span class="required-indicator">*</span>
	</label>

    <div class="controls">
	<g:textField name="code" value="${middleSchoolInstance?.code}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="contact">
        <g:message code="middleSchool.contact.label" default="Contact" />
    </label>

    <div class="controls">
        <g:textField name="contact" value="${middleSchoolInstance?.contact}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="tel">
		<g:message code="middleSchool.tel.label" default="Tel" />
	</label>

    <div class="controls">
	<g:textField name="tel" value="${middleSchoolInstance?.tel}"/>
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="description">
        <g:message code="middleSchool.description.label" default="Description" />
    </label>

    <div class="controls">
        <g:textField name="description" value="${middleSchoolInstance?.description}"/>
    </div>
</div>

