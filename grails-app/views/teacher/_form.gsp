<%@ page import="com.baoming.City; com.baoming.account.Teacher" %>


<div class="control-group">
    <label class="control-label" for="name">
        <g:message code="user.name.label" default="Name" />
    </label>

    <div class="controls">
        <g:textField name="name" value="${teacherInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="username">
		<g:message code="user.username.label" default="Username" />
	</label>

    <div class="controls">
	<g:textField name="username" required="" value="${teacherInstance?.username}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="password">
		<g:message code="user.password.label" default="Password" />
	</label>

    <div class="controls">
	<g:textField name="password" required="" value="${teacherInstance?.password}"/>
    </div>
</div>
<%
    def c = []%>
<g:if test="${teacherInstance?.teacherDistricts}">

     <g:each in="${teacherInstance?.teacherDistricts}" var="teacherDistrict">
         <%
             try {
                 c  << teacherDistrict.district.code as String
             } catch (e) {
             }
         %>
     </g:each>
</g:if>
<div class="control-group">
    <label class="control-label" for="password">
        <g:message code="city.label" default="City" />
    </label>

    <div class="controls">
        <g:select name="cityId" from="${[]}"  multiple="true"  data-placeholder="请选择" />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="enabled">
        <g:message code="department.label" default="Department" />
    </label>

    <div class="controls">
        <g:select name="departmentId" from="${com.baoming.Department.list()}" optionKey="id"  optionValue="name" noSelection="${['':message(code: 'default.select.zd.message')]}" value="${teacherInstance?.department?.id}" />
    </div>
</div>

<div class="control-group">
    <label class="control-label" for="enabled">
        <g:message code="teacher.taskNumber.label" default="Task" />
    </label>

    <div class="controls">
        <g:textField name="taskNumber" required="" value="${teacherInstance?.taskNumber?:0}"/>
    </div>
</div>


<div class="control-group">
	<label class="control-label" for="enabled">
		<g:message code="user.enabled.label" default="Enabled" />
	</label>

    <div class="controls">
	<g:checkBox name="enabled" value="${(!teacherInstance?.id)?true:(teacherInstance?.enabled)}" />
    </div>
</div>




<g:hiddenField name="districtUrl" value="${createLink(action: 'districtOfCityOpts',controller: 'api')}"  title="${c?c.join(','):''}" />


