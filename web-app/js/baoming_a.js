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
        //distOpts(t.val());
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

    $('#editForm').validate({
        rules: {
            username: {
                rangelength:[6,20],
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
            } ,
            code:{
                maxlength:32,
                required: true
            } ,
            admissionTicketNumber:{
                maxlength:32
            },
            number:{
                isIdCardNo:true,
                required: true
            },
            gener:{
                required: true
            },
            birthday:{
                date: true,
                required: true
            },
            'politicalStatus.id':{
                required: true
            },
            'nation.id':{
                required: true
            },
            districtId:{
                required: true
            },
            //'middleSchool.id':{
            //    required: true
            //},
            address:{
                maxlength:80
            }
            ,
            tel:{
                maxlength:16
            }
            ,
            phone:{
                maxlength:11,
                phoneCN:true ,
                required: true
            }
            ,
            email:{
                maxlength:64,
                email:true
            }
            ,
            'studentType.id':{
                required: true
            }
            ,
            score:{
                required:true,
                maxlength:8,
                digits:true
            } ,
            postcode:{
                isZipCode:true
            }
            ,
            qq:{
                digits:true,
                maxlength:16
            }
            ,
            description:{
                maxlength:256
            }
            ,
            level:{
                maxlength:8
            }
            ,
            artsScore:{
                digits:true,
                maxlength: 8
            } ,
            sportsScore:{
                digits:true,
                maxlength: 8
            }
            ,
            'payment.name':{
                maxlength: 8
            }
            ,
            'payment.account':{
                maxlength: 24
            }
            ,
            'payment.amount':{
                number:true,
                maxlength: 8
            }
            ,
            'payment.date':{
                date: true
            }
            ,
            val_code:{
                required: true
            }
            /*,
            planId:{
                required: true
            }*/
            ,docPic:{
                accept: ['jpg','gif','png','bmp','JPG','GIF','PNG','BMP']
            }  ,
            admissionTicketPicInp:{
                required:function(){
                    return !$("#admissionTicketPic").val()
                },
                accept: ['jpg','gif','png','bmp','JPG','GIF','PNG','BMP']
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