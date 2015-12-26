<div class="row-fluid sortable">
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i> <g:message code="home.student.teacher.more.label"/> </h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'teacher',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list" req-content-url="${createLink(controller: 'home',action: 'teacherAjax')}" >

                </ul>
            </div>
        </div><!--/span-->
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i>  <g:message code="home.student.city.more.label"/></h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'city',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list" req-content-url="${createLink(controller: 'home',action: 'cityAjax')}">

                </ul>
            </div>
        </div><!--/span-->

</div>
<div class="row-fluid sortable">
    <div class="box span6">
        <div class="box-header well" data-original-title>
            <h2><i class="icon-th"></i>  <g:message code="home.student.district.more.label"/></h2>
            <div style="float: right;">
                <a href="${createLink(controller: 'home',action: 'rank',params: [t:'district',year:params.year?:year])}" class=" btn-mini">more</a>
            </div>
        </div>
        <div class="box-content">
            <ul class="dashboard-list" req-content-url="${createLink(controller: 'home',action: 'districtAjax')}">

            </ul>
        </div>
    </div><!--/span-->

        %{--<div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i>  <g:message code="home.student.middleSchool.more.message"/></h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'middleSchool',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list" req-content-url="${createLink(controller: 'home',action: 'schoolAjax')}">

                </ul>
            </div>
        </div><!--/span-->--}%
        <div class="box span6">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-th"></i>  <g:message code="home.student.plan.more.label"/></h2>
                <div style="float: right;">
                    <a href="${createLink(controller: 'home',action: 'rank',params: [t:'plan',year:params.year?:year])}" class=" btn-mini">more</a>
                </div>
            </div>
            <div class="box-content">
                <ul class="dashboard-list" req-content-url="${createLink(controller: 'home',action: 'planAjax')}">

                </ul>
            </div>
        </div><!--/span-->
</div><!--/row-->