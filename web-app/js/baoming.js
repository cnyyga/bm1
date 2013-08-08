$(function(){

    function provinceChange() {
        var city = $("input[name='city']");
        city.empty();
        $.get("")
    }

    $(".captcha_referer").click(function(){
        var s = $("#imageCaptcha").attr("src") ;
        var id = s.indexOf("=");
        var ss  = s.substring(0,id+1) ;
        var d = new Date();
        d = d.getTime() ;
        d += '';
        d = d.substring(0,10);
        ss += d;
        $("#imageCaptcha").attr("src",ss) ;
    })

    $("#loginForm .input-text").focus(function(){
        var t = $(this);
        var id = t.attr("id");
        if(id == 'username') {
            $("#loginForm #pwdUsername").hide();
        }else if(id == 'password') {
            $("#loginForm #pwdTip").hide();
        }
    })
    $("#loginForm .input-text").blur(function(){
        var t = $(this);
        var v = t.val();
        if(v && $.trim(v)!='') {
            return;
        }

        var id = t.attr("id");
        if(id == 'username') {
            $("#loginForm #pwdUsername").show();
        }else if(id == 'password') {
            $("#loginForm #pwdTip").show();
        }
    })

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

    $("#paymentDate").datepicker({
        defaultDate:"",
        changeMonth:true,
        numberOfMonths:1,
        dateFormat:'yy-mm-dd'
    }, $.datepicker.regional['zh-CN']);

    $('#regForm').validate({
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
           // 'middleSchool.id':{
           //     required: true
           // },
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
                phoneCN:true,
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
                maxlength:8,
                digits:true
            } ,
            postcode:{
                isZipCode:true
            }
            ,
            qq:{
                digits:true,
                maxlength:16,
                required: true
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
            ,
            //planId:{
               // required: true
           // },
            docPic:{
                accept: ['jpg','gif','png','bmp','JPG','GIF','PNG','BMP']
            }  ,
            admissionTicketPicInp:{
                required:true,
                accept: ['jpg','gif','png','bmp','JPG','GIF','PNG','BMP']
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
        },submitHandler: function(form) {
            var tjc = $("#combobox");
            var tjv = tjc.val();
            if(tjc && tjc.length > 0 & (!tjv || tjv == '')) {
                $("#combobox").focus() ;
            }else{
                form.submit();
            }
        }
    })
})