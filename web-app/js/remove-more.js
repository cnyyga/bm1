$(function(){
    $( "#dialog-del" ).dialog({
        title:'提示',
        autoOpen: false,
        height: 150,
        width: 250,
        modal: true,
        buttons: {
            "关闭": function(){
                $(this).dialog("close")
            }
        }
    });

    $("#chk_all").change(function(){
        var chked = $(this).attr("checked");
        console.log(!!chked)
            $(".student-chk").each(function(){
                $(this).attr("checked",!!chked);
                if(!!chked){
                    $(this).parent().addClass("checked")   ;
                }else{
                    $(this).parent().removeClass("checked")   ;
                }
            })

    })

     $("#delAllBtn").click(function(){
         var studs = $(".student-chk:checked") ;
         var url = $(this).attr("url");
         $( "#dialog-del" ).dialog('option', 'buttons', { "关闭": function(){
             $(this).dialog("close")
         }})
         if(!studs || studs.length == 0) {
             $( "#dialog-del").html("<h3>请选择需要删除的学生</h3>").dialog('open')
             return
         }
         $( "#dialog-del" ).dialog('option', 'buttons', {
             "确定":function(){
                 var studIds = '';
                 studs.each(function(){
                      if(studIds) {
                          studIds +=','
                      }
                     studIds += $(this).val() ;
                 })
                 $.post(url,{ids:studIds},function(data){
                     $( "#dialog-del" ).dialog('option', 'buttons', { "关闭": function(){
                         $(this).dialog("close")
                     }})
                     if(data.status == '1') {
                         $( "#dialog-del" ).dialog('option', 'buttons', { "关闭": function(){
                             $(this).dialog("close");
                             window.location.reload();
                         }})
                         $( "#dialog-del").html("已经成功删除"+data.successNum+"条记录，失败"+data.failureNum+"条记录")
                     }else{
                         $( "#dialog-del").html("删除失败")
                     }
                 },'json')
            },
             "取消": function(){
                 $(this).dialog("close")
             } })
         $( "#dialog-del").html("<h3>是否确定删除？</h3>").dialog('open')
     })
})