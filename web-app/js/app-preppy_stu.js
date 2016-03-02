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
        var selectedId =  $("#studentDistrictVal").val()    ;
        $("#studentDistrict").load(districtUrl+"?id="+cityId+"&selected="+selectedId);
    }

    $("#preppyForm").validate({
        rules: {
            plan:{
                required: true
            }  ,
            phone:{
                required: true,
                phoneCN:true,
                maxlength:11
            }  ,
            parentPhone:{
                required: true,
                phoneCN:true,
                maxlength:11
            }  ,
            nation:{
                required: true
            }  ,
            province:{
                required: true
            }  ,
            city:{
                required: true
            }  ,
            district:{
                required: true
            }  ,
            town:{
                required: true,
                maxlength:50
            }  ,
            resume:{
                required: true,
                maxlength:500
            }
            ,
            address:{
                required: true,
                maxlength:80
            }
            ,
            qq:{
                required: true,
                digits:true,
                maxlength:10
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
    });

    $("#family").change(function(){
        family($(this).val());
        setPlans($("#studentCateories").val());
    });

    var opts = $("#studentCateories option");
    $("#studentCateories").append(opts);
    family($("#family").val());
    function family(cate) {
        $("#studentCateories").empty()
        if(cate == 'JIANGSU'){
            var opts1 = opts.slice(3,9);
            $("#studentCateories").append(opts1);
        }else{
            var opts2 = opts.slice(9,11);
            $("#studentCateories").append(opts2);
        }
        $("#studentCateories").val($("#studentCateories").attr("attr-sel"));
    }

    $("#studentCateories").change(function(){
        setPlans($(this).val())
    });
    setPlans($("#studentCateories").val());
    function setPlans(type) {
        var _url = $("#preppyPlanUrl").val();
        var _selected =   $("#preppyPlanUrl").attr("title");
        $("#planId").html('');
        $.getJSON(_url,{type:type},function(data){
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
            $("#planId").html(str);
        })
    }


    $("#birthday_year").change(function(){
        setage($(this).val());
    }) ;
    setage($("#birthday_year").val());
    function setage(year){
         var thisyear= $("#age").attr("this-year-attr");
        $("#age").val(thisyear-year);
    }


})