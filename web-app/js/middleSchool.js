$(function(){

    $('.form-horizontal').validate({
        rules: {
            name: {
                maxlength:64,
                required: true
            },
            code:{
                maxlength:64,
                required: true
            }

        },
        highlight: function(label) {
            $(label).closest('.inp_box').addClass('error');
        },
        success: function(label) {
            label
                .text('OK!').addClass('valid')
                .closest('.inp_box').addClass('success');
            $(label).closest('.inp_box').removeClass('error');
        }
    }) ;


    $("#province").change(function(){
        var t = $(this);
        cityOpts(t.val())
    })

    cityOpts($("#province").val())
    function cityOpts(provinceId) {
        var cityUrl = $("#cityUrl").val();
        var selectedId =  $("#cityUrl").attr("title")
        $("#city").load(cityUrl+"?id="+provinceId+"&selected="+selectedId,function(){
            distOpts($("#city").val())
        });
    }

    function distOpts(cityId) {
        var districtUrl = $("#districtUrl").val();
        var selectedId =  $("#districtUrl").attr("title")
        $("#district").load(districtUrl+"?id="+cityId+"&selected="+selectedId);
    }
})