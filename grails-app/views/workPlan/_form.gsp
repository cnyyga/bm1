<%@ page import="com.baoming.WorkPlan" %>



<div class="control-group">
	<label class="control-label" for="name">
		<g:message code="workPlan.name.label" default="Name" />
	</label>

    <div class="controls">
	<g:textField name="name" value="${workPlanInstance?.name}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="area">
		<g:message code="workPlan.area.label" default="Area" />
	</label>

    <div class="controls">
	<g:textField name="area" value="${workPlanInstance?.area}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="num">
		<g:message code="workPlan.num.label" default="Num" />
	</label>

    <div class="controls">
	<g:field name="num" type="number" value="${workPlanInstance.num}" required=""/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="startDate">
		<g:message code="workPlan.date.label" default="Start Date" />
	</label>

    <div class="controls">
	<g:datePicker name="startDate" precision="day" relativeYears="[0..1]"  value="${workPlanInstance?.startDate}"  />
        至	<g:datePicker name="endDate" precision="day" relativeYears="[0..1]" value="${workPlanInstance?.endDate}"  />

    </div>
</div>


<div class="control-group">
	<label class="control-label" for="middleSchools">
		<g:message code="workPlan.middleSchools.label" default="Middle Schools" />
	</label>

    <div class="controls">
	<g:textField name="middleSchools" value="${workPlanInstance?.middleSchools}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="tel">
		<g:message code="workPlan.tel.label" default="Tel" />
	</label>

    <div class="controls">
	<g:textField name="tel" value="${workPlanInstance?.tel}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="result">
		<g:message code="workPlan.result.label" default="Result" />
	</label>

    <div class="controls">
	<g:textField name="result" value="${workPlanInstance?.result}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="opinion">
		<g:message code="workPlan.opinion.label" default="Opinion" />
	</label>

    <div class="controls">
	<g:textField name="opinion" value="${workPlanInstance?.opinion}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="materialObject">
		<g:message code="workPlan.materialObject.label" default="Material Object" />
	</label>

    <div class="controls">
	<g:textField name="materialObject" value="${workPlanInstance?.materialObject}"/>
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="materialNum">
        <g:message code="workPlan.materialNum.label" default="Material Num" />
    </label>

    <div class="controls">
        <g:field name="materialNum" type="number" value="${workPlanInstance.materialNum}" required=""/>
    </div>
</div>
<div class="control-group">
	<label class="control-label" for="materialTel">
		<g:message code="workPlan.materialTel.label" default="Material Tel" />
	</label>

    <div class="controls">
	<g:textField name="materialTel" value="${workPlanInstance?.materialTel}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="questions">
		<g:message code="workPlan.questions.label" default="Questions" />
	</label>

    <div class="controls">
	<g:textField name="questions" value="${workPlanInstance?.questions}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="hasOpinion">
		<g:message code="workPlan.hasOpinion.label" default="Has Opinion" />
	</label>

    <div class="controls">
	<g:field name="hasOpinion" type="number" value="${workPlanInstance.hasOpinion}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="pic">
		<g:message code="workPlan.pic.label" default="Pic" />
	</label>

    <div class="controls">
	<g:textField name="pic" value="${workPlanInstance?.pic}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="carFare">
		<g:message code="workPlan.carFare.label" default="Car Fare" />
	</label>

    <div class="controls">
	<g:textField name="carFare" value="${workPlanInstance?.carFare}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="cityCarFare">
		<g:message code="workPlan.cityCarFare.label" default="City Car Fare" />
	</label>

    <div class="controls">
	<g:textField name="cityCarFare" value="${workPlanInstance?.cityCarFare}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="accommodation">
		<g:message code="workPlan.accommodation.label" default="Accommodation" />
	</label>

    <div class="controls">
	<g:textField name="accommodation" value="${workPlanInstance?.accommodation}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="entertainment">
		<g:message code="workPlan.entertainment.label" default="Entertainment" />
	</label>

    <div class="controls">
	<g:textField name="entertainment" value="${workPlanInstance?.entertainment}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="amount">
		<g:message code="workPlan.amount.label" default="Amount" />
	</label>

    <div class="controls">
	<g:textField name="amount" value="${workPlanInstance?.amount}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="attendSeminar">
		<g:message code="workPlan.attendSeminar.label" default="Attend Seminar" />
	</label>

    <div class="controls">
	<g:field name="attendSeminar" type="number" value="${workPlanInstance.attendSeminar}"/>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="workPlan">
		<g:message code="workPlan.workPlan.label" default="Work Plan" />
	</label>

    <div class="controls">
	<g:textField name="workPlan" value="${workPlanInstance?.workPlan}"/>
    </div>
</div>




