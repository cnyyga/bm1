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
            'plan.id':{
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
            juniorSchool:{
                required: true,
                maxlength:80
            },
            juniorAuthenticator:{
                required: true,
                maxlength:80
            } ,
            highSchool:{
                required: true,
                maxlength:80
            },
            highAuthenticator:{
                required: true,
                maxlength:80
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
                maxlength:20
            },
            juniorStart_year:{
                required: true
            }
            ,
            juniorStart_month:{
                required: true
            }
            ,
            juniorEnd_year:{
                required: true
            }
            ,
            juniorEnd_month:{
                required: true
            }
            ,
            highStart_year:{
                required: true
            }
            ,
            highStart_month:{
                required: true
            }
            ,
            highEnd_year:{
                required: true
            }
            ,
            highEnd_month:{
                required: true
            },family:{
                required: true
            },studentCateories:{
                required: true
            },birthday:{
                required: true
            },birthday_year:{
                required: true
            },birthday_month:{
                required: true
            },birthday_day:{
                required: true
            },
            type:{
                required: true
            },
            leiBie:{
                required: true
            },
            beforeFamily:{
                required: true
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

    var _txt =   $("#preppyPlanUrl").attr("select-txt");
    var _str = "<option value=\"\">"+_txt+"</option>";

    var opts = $("#studentCateories option");
    $("#studentCateories").append(opts);
    family($("#family").val());
    function family(cate) {
        $("#studentCateories").empty();
        $("#studentCateories").append(_str);
        if(cate == 'JIANGSU'){
            var opts1 = opts.slice(4,10);
            $("#studentCateories").append(opts1);
        }else if(cate == 'OTHER'){
            var opts2 = opts.slice(10,12);
            $("#studentCateories").append(opts2);
        }
        $("#studentCateories").val($("#studentCateories").attr("attr-sel"));
    }

    $("#studentCateories").change(function(){
        setPlans($(this).val())
    });
    setPlans($("#studentCateories").val());
    function setPlans(type) {
        if(!type || type == ''){
            return;
        }
        var _url = $("#preppyPlanUrl").val();
        var _selected =   $("#preppyPlanUrl").attr("title");
        var _txt =   $("#preppyPlanUrl").attr("select-txt");
        $("select[name='plan.id']").html('');
        $.getJSON(_url,{type:type},function(data){
            var str = "<option value=\"\">"+_txt+"</option>";
            $.each(data,function(index,val){
                var id = val['id'];
                var name = val['name'];
                var sel = "";
                if(id == _selected) {
                    sel = "selected='selected'";
                }
                str += "<option "+sel+" value=\""+id+"\">"+val.name+"</option>";
            })
            $("select[name='plan.id']").html(str);
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