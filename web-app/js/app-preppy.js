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

    $('#editForm').validate({
        rules: {
            name: {
                required: true,
                maxlength:10
            },
            number:{
                required: true,
                isIdCardNo:true
            },
            password:{
                required: function(){
                    var _id= $("#id").val();
                    return (!_id ||_id == '')
                },
                maxlength:16
            },
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
            'nation.id':{
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
            }
            ,
            'preppyPlan.id':{
                required: true
            }
            ,
            combobox:{
                required: true
            }
            ,
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
            },
            family:{
                required: true
            },
            studentCateories:{
                required: true
            },
            birthday_year:{
                required: true
            },
            birthday_month:{
                required: true
            },
            birthday_day:{
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
    })

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


    _show_material($("#reviewStatus").val());
    $("#reviewStatus").change(function(){
        _show_material($(this).val());
    });
    function _show_material(rsval) {
        var id=-1;
        if(rsval == 'JSPG'){
            id=2;
        }else if(rsval == 'JSZZ'){
            id=3;
        }else if(rsval == 'GJSZZ'){
            id=4;
        }
        $(".material-content").hide();
        $(".material-content li").hide();
        $(".material-content li").each(function(){
            var _class = $(this).attr("class");
            if(_class.indexOf(id) != -1){
                $(this).show();
                $(".material-content").show();
            }
        })
    }

})