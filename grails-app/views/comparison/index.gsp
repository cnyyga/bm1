
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'comparison.label')}" />
		<title>${entityName}</title>
        <g:javascript src="student-imp.js"/>
        <script>
        $(function(){
            $(".dl-ab").click(function(e){
                e.preventDefault();
                var url = $(this).attr("rel");
                window.open(url)
            })
        })
        </script>
	</head>

	<body>
    <div>
        <ul class="breadcrumb">
            <li>
                <a href="${createLink(uri: '/')}">Home</a> <span class="divider">/</span>
            </li>
            <li>
                <a href="javascript:void 0">${entityName}</a>
            </li>
        </ul>
    </div>

    <g:if test="${flash.message}">
        <div class="alert alert-error">${flash.message}</div>
    </g:if>

    <div class="row-fluid sortable">
        <div class="box span12">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> ${entityName} </h2>
            </div>
            <div class="box-content ">
                <g:uploadForm class="form-horizontal" action="sub" name="admissionForm" >
                    <g:hiddenField name="type" value="1"/>
                    <fieldset>
                        <div class="control-group">
                            <label class="control-label" for="docFile">
                                <g:message code="download.upload.label"/><g:message code="comparison.a.label"/>
                            </label>
                            <div class="controls">
                                <input type="file" name="docFile" id="docFile" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="docFile">
                                <g:message code="download.upload.label"/><g:message code="comparison.b.label"/>
                            </label>
                            <div class="controls">
                                <input type="file" name="docFile1" id="docFile1" />
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary btn-stu-import">${message(code: 'comparison.button.label')}</button>
                        </div>
                    </fieldset>
                </g:uploadForm>
            </div>
        </div><!--/span-->

    </div><!--/row-->
    <div class="row-fluid sortable">
        <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> A多 </h2>
            </div>
            <div class="box-content ">
                ${a?:0}条
                <g:if test="${a}" ><a class="dl-ab" href="javascript:void 0" rel="${createLink(action: 'd',params: [type:'a'])}">下载</a></g:if>
            </div>
        </div>
        <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> AB重复 </h2>
            </div>
            <div class="box-content ">
                ${ab?:0}条
                <g:if test="${ab}" ><a class="dl-ab" href="javascript:void 0" rel="${createLink(action: 'd',params: [type:'ab'])}">下载</a></g:if>
            </div>
        </div>
        <div class="box span4">
            <div class="box-header well" data-original-title>
                <h2><i class="icon-zoom-in"></i> B多 </h2>
            </div>
            <div class="box-content ">
                ${b?:0}条
                <g:if test="${b}" ><a class="dl-ab" href="javascript:void 0" rel="${createLink(action: 'd',params: [type:'b'])}">下载</a></g:if>
            </div>
        </div>
    </div><!--/span-->
	</body>
</html>
