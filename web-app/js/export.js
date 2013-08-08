$(function(){
    $( "#dialog-export" ).dialog({
        title:'设置导出字段',
        autoOpen: false,
        height: 400,
        width: 600,
        modal: true,
        buttons: {
            "确定":ok,
            "取消": function(){
                  $(this).dialog("close")
            }
        }
    });
    $(".ui-dialog-buttonset button").addClass('btn') ;
    $(".ui-dialog-buttonset button:first").addClass('btn-primary') ;

    function ok() {
        var dg = $("#dialog-export");
        var chks = dg.find("input[type='checkbox']:checked");
        var p = ''
        chks.each(function(i){
            if(p != '') {
                p += ','
            }
            p += $(this).attr('name')
        })
        if(p == '') {
            alert("请选择导出字段")
            return;
        }
        var url = $("#exportUrl").val();
        var name = $("#name").val()    ;
        var year = $("#year").val();
        var audit = $("#audit").val();
        var city = $("#city");
        if(city) {
            city = $("#city").val();
        }
        var district = $("#district").val();
        if(city) {
            district = $("#district").val();
        }
        var middleSchooleId = $("#middleSchooleId").val();
        var planId = $("#planId").val();
        var teacherId = $("select[name='teacherId']");
        if(teacherId) {
            teacherId = teacherId.val()
        }
        url += "?f="+p+"&name="+name+"&year="+year+"&cityId="+city+"&districtId="+district+"&audit="+audit+"&middleSchooleId="+middleSchooleId
        url += "&planId="+planId+ "&teacherId="+teacherId  ;
        $("#dialog-export").dialog("close")
        window.open(url)

    }

    $(".export-all").click(function(){
        var chked = $(this).attr("checked");
        $("#dialog-export input[type='checkbox'][name!='all']").each(function(){
            $(this).attr("checked",!!chked);
            if(!!chked){
                $(this).parent().addClass("checked")   ;
            }else{
                $(this).parent().removeClass("checked")   ;
            }
        })
    })
    $("#exportBtn").click(function(){
        $( "#dialog-export" ).dialog('open');
    })
})