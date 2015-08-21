<%@ page import="com.baoming.WorkPlan" %>
<style>
    textarea{
        width: 80%;
    }
</style>
<h2 style="text-align: center;margin: 15px auto;padding: 0;">招生老师定期工作汇报及工作计划</h2>
<h4>一、基本信息</h4>
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
        <br/>至<br/>	<g:datePicker name="endDate" precision="day" relativeYears="[-1..1]" value="${workPlanInstance?.endDate}"  />

    </div>
</div>

<h4>二、【联系中学情况】 </h4>
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
        <g:textArea name="result" rows="3" cols="" >${workPlanInstance?.result}</g:textArea>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="opinion">
		<g:message code="workPlan.opinion.label" default="Opinion" />
	</label>

    <div class="controls">
    <g:textArea name="opinion" rows="3" cols="">${workPlanInstance?.opinion}</g:textArea>

    </div>
</div>

<h4>三、【材料发放情况】  </h4>

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
    <g:textArea name="questions" rows="3" cols="">${workPlanInstance?.questions}</g:textArea>
    </div>
</div>

<div class="control-group">
	<label class="control-label" for="hasOpinion">
		<g:message code="workPlan.hasOpinion.label" default="Has Opinion" />
	</label>

    <div class="controls">

        <g:select name="hasOpinion" from="[[id:0,label:'无'],[id:1,label:'有']]" optionKey="id" optionValue="label" value="${workPlanInstance.hasOpinion}"/>

    </div>
</div>

<div class="control-group">
	<label class="control-label" for="pic">
		<g:message code="workPlan.pic.label" default="Pic" />
	</label>

    <div class="controls">
	<g:hiddenField name="pic" value="${workPlanInstance?.pic}"/>
        <input type="file" name="fileInp" />
        <g:if test="${workPlanInstance?.pic}">
            <img src="${createLink(controller: 'api',action: 'img',id: workPlanInstance?.pic)}" style="max-height:80px"/>
        </g:if>
    </div>
</div>

<h4>四、【本周期工作开支】   </h4>

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

<h4>五、【其他工作】    </h4>

<div class="control-group">
	<label class="control-label" for="attendSeminar">
		<g:message code="workPlan.attendSeminar.label" default="Attend Seminar" />
	</label>

    <div class="controls">
        <g:select name="attendSeminar" from="[[id:0,label:'无'],[id:1,label:'有']]" optionKey="id" optionValue="label" value="${workPlanInstance.attendSeminar}"/>

    </div>
</div>

<div class="control-group">
	<label class="control-label" for="workPlan">
		<g:message code="workPlan.workPlan.label" default="Work Plan" />
	</label>

    <div class="controls">
    <g:textArea name="workPlan" rows="3" cols="">${workPlanInstance?.workPlan}</g:textArea>
    </div>
</div>




