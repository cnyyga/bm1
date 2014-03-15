$(function(){
    $('#editForm').validate({
        rules: {
            name: {
                required: true
            },
            number:{
                required: true
            }
            ,
            plan:{
                required: true
            }  ,
            phone:{
                required: true
            }  ,
            middlePlan:{
                required:function(){
                    var collegeType = $("#collegeType").val()
                    return  collegeType== 'VOCATION'
                }
            }

        },
        highlight: function(label) {
            $(label).closest('.control-group').addClass('error');
            $(label).closest('.control-group').removeClass('success');
        },
        success: function(label) {
            label
                .text('OK!').addClass('valid')
                .closest('.control-group').addClass('success');
        }
    })
})