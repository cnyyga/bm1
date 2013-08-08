<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="BaoMing"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'img', file: 'favicon.ico')}" type="image/x-icon">

    <!-- The styles -->
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-cerulean.css')}" type="text/css">

    <link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'charisma-app.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.8.21.custom.css')}" type="text/css">
   <link rel="stylesheet" href="${resource(dir: 'css', file: 'fullcalendar.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'fullcalendar.print.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'chosen.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'uniform.default.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'colorbox.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.cleditor.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.noty.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'noty_theme_default.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'elfinder.min.css')}" type="text/css">
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'elfinder.theme.css')}" type="text/css">
   %{-- <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.iphone.toggle.css')}" type="text/css">--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'opa-icons.css')}" type="text/css">
    %{--<link rel="stylesheet" href="${resource(dir: 'css', file: 'uploadify.css')}" type="text/css">--}%
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main-manager.css')}" type="text/css">

    <!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <g:javascript src="html5.js"/>
	<![endif]-->
    <!-- The fav icon -->
    <!-- jQuery -->
  %{--  <g:javascript library="jquery"/>--}%
    <r:layoutResources />
     <g:javascript src="jquery-1.8.3.js"/>
    <!-- jQuery UI -->
    <g:javascript src="jquery-ui-1.9.2.custom.min.js"  />
    <!-- transition / effect library -->
        <g:javascript src="bootstrap-transition.js"  />
    <!-- alert enhancer library -->
    <g:javascript src="bootstrap-alert.js"  />
    <!-- modal / dialog library -->
     <g:javascript src="bootstrap-modal.js"  />
    <!-- custom dropdown library -->
    <g:javascript src="bootstrap-dropdown.js"  />
    <!-- scrolspy library -->
    <g:javascript src="bootstrap-scrollspy.js"  />
    <!-- library for creating tabs -->
    <g:javascript src="bootstrap-tab.js"  />
    <!-- library for advanced tooltip -->
    <g:javascript src="bootstrap-tooltip.js"  />
    <!-- popover effect library -->
    <g:javascript src="bootstrap-popover.js"  />
    <!-- button enhancer library -->
    <g:javascript src="bootstrap-button.js"  />
    <!-- accordion library (optional, not used in demo) -->
    <g:javascript src="bootstrap-collapse.js"  />
    <!-- carousel slideshow library (optional, not used in demo) -->
    <g:javascript src="bootstrap-carousel.js"  />
    <!-- autocomplete library -->
    <g:javascript src="bootstrap-typeahead.js"  />
    <!-- tour library -->
      %{-- <g:javascript src="bootstrap-tour.js"  />--}%
     <!-- library for cookie management -->
 <g:javascript src="jquery.cookie.js"  />
    <!--calander plugin -->
 <g:javascript src="fullcalendar.min.js"  />
 <!-- data table plugin -->
 <g:javascript src="jquery.dataTables.min.js"  />

 <!-- chart libraries start -->
%{-- <g:javascript src="excanvas.js"  />
 <g:javascript src="jquery.dataTables.min.js"  />
 <g:javascript src="jquery.flot.min.js"  />
 <g:javascript src="jquery.flot.stack.js"  />
 <g:javascript src="jquery.flot.resize.min.js"  />--}%

 <!-- chart libraries end -->

 <!-- select or dropdown enhancer -->
 <g:javascript src="jquery.chosen.min.js"  />
 <!-- checkbox, radio, and file input styler -->
 <g:javascript src="jquery.uniform.min.js"  />
 <!-- plugin for gallery image view -->
 <g:javascript src="jquery.colorbox.min.js"  />
 <!-- rich text editor library -->
 <g:javascript src="jquery.cleditor.min.js"  />
 <!-- notification plugin -->
 <g:javascript src="jquery.noty.js"  />
 <!-- file manager library -->
%{-- <g:javascript src="jquery.elfinder.min.js"  />--}%
 <!-- star rating plugin -->
 <g:javascript src="jquery.raty.min.js"  />
%{-- <!-- for iOS style toggle switch -->
 <g:javascript src="jquery.iphone.toggle.js"  />--}%
 <!-- autogrowing textarea plugin -->
 <g:javascript src="jquery.autogrow-textarea.js"  />
 <!-- multiple file upload plugin -->
%{-- <g:javascript src="jquery.uploadify-3.1.min.js"  />--}%
 <!-- history.js for cross-browser state change on ajax -->
 <g:javascript src="jquery.history.js"  />
 <!-- application script for Charisma demo -->
 <g:javascript src="charisma.js"  />
    <g:javascript src="main.js"/>

    <g:layoutHead/>

</head>
	<body>
       <g:render template="/layouts/header"/>
        <div class="container-fluid">
            <div class="row-fluid">
              <g:render template="/layouts/left"/>
                <div id="content" class="span10">
                    <g:layoutBody/>
                </div>
            </div>
           <g:render template="/layouts/footer"/>
        </div>

		<r:layoutResources />


	</body>
</html>
