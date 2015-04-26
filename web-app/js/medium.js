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
    function distOpts(cityId) {
        var districtUrl = $("#districtUrl").val();
        var selectedId =  $("#districtUrl").attr("title")    ;
        $("#district").load(districtUrl+"?id="+cityId+"&selected="+selectedId);
    }
    ////////

    $("#studentProvince").change(function(){
        var t = $(this);
        studentCityOpts(t.val())
    })

    $("#studentCity").change(function(){
        var t = $(this);
        studentDistOpts(t.val());
    })

    studentCityOpts($("#studentProvince").val())
    function studentCityOpts(provinceId) {
        var cityUrl = $("#cityUrl").val();
        var selectedId =  $("#studentCityVal").val();
        $("#studentCity").load(cityUrl+"?id="+provinceId+"&selected="+selectedId,function(){
            studentDistOpts($("#studentCity").val());
        });
    }
    function studentDistOpts(cityId) {
        var districtUrl = $("#districtUrl").val();
        var selectedId =  $("#studentDistrictVal").val()  ;
        $("#studentDistrict").load(districtUrl+"?id="+cityId+"&selected="+selectedId);
    }

    $("#mediumPlan").change(function(){
        _setPlan($(this).val());
    })

    _setPlan($("#mediumPlan").val());
    function _setPlan(mediumPlanId) {
        var _url = $("#mediumPlanUrl").val();
        var _selected =   $("#mediumPlanUrl").attr("title");
        _url += "/"+mediumPlanId;
        var _plan = $("#plan");
        _plan.html("")        ;
        $.getJSON(_url,function(data){
            var str = "";
            $.each(data,function(index,val){
                var id = val['id'];
                var name = val['name'];
                var sel = "";
                if(id == _selected) {
                    sel = "selected='selected'";
                }
                 str += "<option "+sel+" value=\""+id+"\">"+val.name+"</option>";
            })
            $("#plan").html(str);
        })
    }


    $('#editForm').validate({
        rules: {

            name:{
                maxlength:8,
                required: true
            } ,
            code:{
                maxlength:32,
                required: true
            },
            number:{
                isIdCardNo:true,
                required: true
            },
            gener:{
                required: true
            },
            districtId:{
                required: true
            },
            teacherId:{
                required: true
            },

            'mediumPlan.id':{
                required: true
            },
            plan:{
                required: true
            },
            studentDistrictId:{
                required: true
            },

            description:{
                maxlength:256
            }
             ,
            voucherPathInp:{
                required:function(){
                    return !$("#voucherPath").val()
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