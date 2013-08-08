$(function(){

    $( "#confirmDialog" ).dialog({
        title:'提示',
        autoOpen: false,
        height: 160,
        width: 300,
        buttons: {


        }
    });

    $(".btn-danger").click(function(e){
        e.preventDefault();
        var url = $(this).attr("href");
        var tr = $(this).parents("tr");
        $('#confirmDialog').dialog('option', 'buttons', {
            "确认": function() {
                $.post(url,function(data){
                    if(data.status == '1'){
                        if(tr) tr.fadeOut()
                    }
                },'json')
                $(this).dialog("close");
            },
            "取消": function() {
            $( this ).dialog( "close" );
        }
        });
        $('#confirmDialog').dialog('open');

        /*$('#confirmModal .btn-primary').click(function(){
            $.post(url,function(data){
                $('#confirmModal').modal('hide');
                if(data.status == '1'){
                    tr.fadeOut()
                }
            },'json')
        })*/

    })

})

/*

jQuery.validator.addMethod("phone", function(value, element) {
    var tel = /^(130|131|132|133|134|135|136|137|138|139|150|153|157|158|159|180|187|188|189)\d{8}$/;
    return tel.test(value) || this.optional(element);
}, "请输入正确的手机号码");
jQuery.validator.addMethod("stringCheck", function(value, element) {
    return this.optional(element) || /^[\u0391-\uFFE5\w]+$/.test(value);
}, "只能包括中文字、英文字母、数字和下划线");
//身份证号码验证
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
    return this.optional(element) || idCardNoUtil.checkIdCardNo(value);
}, "请正确输入您的身份证号码");
//邮政编码验证
jQuery.validator.addMethod("isZipCode", function(value, element) {
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "请正确填写您的邮政编码");*/
