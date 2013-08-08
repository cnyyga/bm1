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
    })
})