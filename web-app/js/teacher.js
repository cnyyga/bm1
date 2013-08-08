$(function(){
    var url = $("#districtUrl").val();
    var selectedId = $("#districtUrl").attr("title")
    $("#cityId").load(url,{selectedId:selectedId},function(){
        $("#cityId").chosen();
    })

})