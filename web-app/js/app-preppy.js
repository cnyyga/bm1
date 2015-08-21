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
            parentPhone:{
                required: true
            }  ,
            school:{
                required: true
            }  ,
            address:{
                required: true
            }  ,
            deposit:{
                required: true,
                number:true
            }  ,
            middlePlan:{
                required:function(){
                    var studentCateories = $("#studentCateories").val()
                    return  studentCateories== 'WG'
                }
            } ,
            hkbPathInp:{
                required: function(){
                    var vv = $("#hkbPath").val()
                    return  !vv || vv == ''
                }
            } ,
            hkbksyPathInp:{
                required: function(){
                    var vv = $("#hkbksyPath").val()
                    return  !vv || vv == ''
                }
            } ,
            cardPhotoPathInp:{
                required: function(){
                    var vv = $("#cardPhotoPath").val()
                    return  !vv || vv == ''
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

    $("#studentCateories").change(function(){
        category($(this).val());
    });

    category($("#studentCateories").val());
    function category(cate) {
        if(cate == 'SG')  {
             $(".pugao").show();
            $(".waisheng").hide();
            $(".zhongzhi").hide();
            $(".zhongzhi").hide();
           // $(".plan-area").html($("#pugaoArea").val())
        }else  if(cate == 'WG'){
            $(".pugao").hide();
            $(".waisheng").hide();
            $(".zhongzhi").show();
            //$(".plan-area").html($("#zhongzhiArea").val())
        }else  if(cate == 'SZ'){
            $(".pugao").hide();
            $(".zhongzhi").hide();
            $(".waisheng").show();
            //$(".plan-area").html($("#waiArea").val())
        }

        setPlans(cate,$("#preppyPlan").val())
    }

    $("#preppyPlan").change(function(){
        setPlans($("#studentCateories").val(),$(this).val())
    });

    function setPlans(type,preppyPlanId) {
        var _url = $("#preppyPlanUrl").val();
        var _selected =   $("#preppyPlanUrl").attr("title");
        _url += "/"+preppyPlanId;
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