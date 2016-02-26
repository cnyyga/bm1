$(function(){
    var _opts = $("#collegeSignUp").find("option");
    $(".btn-stu-review").click(function(e){
        e.preventDefault();
        var id = $(this).attr("rel");
        var url =  $(this).attr("href");
        $( "#reviewModal").data("studentId",id);
        $( "#reviewModal").data("studentUrl",url);
        //$( "#dialog-review" ).dialog('open');
        $('#reviewModal').modal('show') ;
        $('#loading').remove();
        $('#reviewFormContent').fadeIn();
        $("#reviewModal .modal-footer").fadeIn()
        $("#reviewModal select[name='reviewStatus']").val('');
        $("#reviewModal #reviewDescription").val('');

        var _remark2=$(this).prev();
        var _remark1=_remark2.prev();
        var _remark=_remark1.prev();
        var _preppyPlan=_remark.prev();
        var _collegeSignUp=_preppyPlan.prev();
        var _family=_collegeSignUp.prev();
        var _reviewStatus=_family.prev();
        if(_family.val() == "OTHER"){
            $("#collegeSignUp").html(_opts[0]);
        }else{
            $("#collegeSignUp").append(_opts);
        }
        $("#reviewStatus11").val(_reviewStatus.val());
        $("#collegeSignUp").val(_collegeSignUp.val());
        $("#preppyPlan").val(_preppyPlan.val());
        $("#remark").val(_remark.val());
        $("#remark1").val(_remark1.val());
        $("#remark2").val(_remark2.val());
    })


    $("#reviewModal .save-student-review").click(function() {
        var studentId =  $( "#reviewModal").data("studentId");
        var studentUrl =  $( "#reviewModal").data("studentUrl");
        if(!studentId){
            $("#reviewModal").modal('hide');
            return
        }
        var reviewStatus = $("#reviewModal select[name='reviewStatus']").val();
        var reviewDescription = $("#reviewModal #reviewDescription").val();
        $('#loading').remove();
        $('#reviewFormContent').fadeOut().parent().append('<div id="loading" class="center">Loading...<div class="center"></div></div>');
        $("#reviewModal .modal-footer").fadeOut();
        var _params = {reviewStatus:""+reviewStatus,reviewDescription:reviewDescription+"",
            collegeSignUp:$("#collegeSignUp").val(), preppyPlan:$("#preppyPlan").val(),
            remark:$("#remark").val(), remark1:$("#remark1").val(), remark2:$("#remark2").val()};
        $.post(studentUrl,_params,function(data){
            if(data.status == '1') {
                 $('#loading').html('<b>审核成功</b>');
                 if(data.reviewStatusId) {
                     var span = $("#studentTd"+studentId).find("span.label") ;
                     if(data.reviewStatusId == 1){
                         span.removeClass('label-success label-warning').addClass('label-important')  ;
                     }else if(data.reviewStatusId == 2){
                         span.removeClass('label-important label-warning').addClass('label-success') ;
                     }else {
                         span.removeClass('label-important label-success').addClass('label-warning') ;
                     }
                     span.text(data.reviewStatusLab) ;
                 }
            }else{
                $('#loading').html('<b>审核失败</b>');
            }
            setTimeout(function () {
                $("#reviewModal").modal('hide');
            }, 3000);
        },'json')

    })


})