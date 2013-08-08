$(function(){

    $('.form-horizontal').validate({
        rules: {
            username: {
                rangelength:[4,20],
                stringCheck:true,
                required: true
            },
            password:{
                minlength:6,
                required: true
            }
            ,
            name:{
                maxlength:8,
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
    })
})