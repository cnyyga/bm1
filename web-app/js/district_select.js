$(function(){

    $("#province").change(function(){
         var t = $(this);
        cityOpts(t.val())
    })

    $("#city").change(function(){
        var t = $(this);
        distOpts(t.val());
       // schoolOpts(t.val()) ;
    })

    cityOpts($("#province").val())
    function cityOpts(provinceId) {
        var cityUrl = $("#cityUrl").val();
        var selectedId =  $("#cityUrl").attr("title")
        $("#city").load(cityUrl+"?id="+provinceId+"&selected="+selectedId,function(){
            distOpts($("#city").val())

        });
    }

    $("#district").change(function(){
        var t = $(this);
       // distOpts(t.val());
        schoolOpts(t.val()) ;
    })

    function distOpts(cityId) {
        var districtUrl = $("#districtUrl").val();
        var selectedId =  $("#districtUrl").attr("title")
        $("#district").load(districtUrl+"?id="+cityId+"&selected="+selectedId,function(){
            schoolOpts($("#district").val())
        });
    }

    function schoolOpts(cityId) {
        var schoolUrl = $("#schoolUrl").val();
        var selectedId =  $("#schoolUrl").attr("title")
        $("#middleSchooleId").load(schoolUrl+"?id="+cityId+"&selected="+selectedId);
    }

})