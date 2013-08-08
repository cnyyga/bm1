$(function(){

    $("#editForm input[name='type']").val('1') ;
    $("#editForm input[name='code']").val('')  ;
    $("#editForm input[name='name']").val('') ;
    $("#editForm input[name='parentId']").val('') ;
    $("#editForm input[name='id']").val('') ;

    $("#tree").treeview({
        collapsed: true,
        animated: "medium",
        persist: "location"
    });

    $("#editForm").validate({
        rules: {
            code:{
                required: true,
                maxlength: 16
            },
            name: {
                required: true,
                maxlength: 16
            }
        }
    })
    $("#tree a").live("click",function(e){
        e.preventDefault();
        var str = $(this).attr("rel");
        var obj = str.split('|');
        var type = obj[0];
        var code = obj[1];
        var name = obj[2];
        if(type == '3') {
            $(".area-add").hide();
        }else{
            $(".area-add").show()
        }

        var parentId ='' ;
        var parentName = '';
        if(type != '1'){
            var parentUl = $(this).parent().parent().prev() ;
            var parentRel =  parentUl.attr("rel")   ;
            var _obj = parentRel.split('|');
            //if(type == '2') {
                parentId = _obj[1]  ;
                parentName = _obj[2]  ;
            //} else{
            //    parentId = _obj[3]  ;
             //   parentName = _obj[4]  ;
            //}

        }
       // $("#editForm input[name='code']").attr("readonly",true)
        $("#tree").data("parentName",name);
        $("#tree").data("parentCode",code);
        $("#tree").data("parentType",type);
        $("#editForm input[name='id']").val(code);
        $("#editForm input[name='parentId']").val(parentId);
        $("#editForm .area-parent").html(parentName);
        $("#editForm input[name='code']").val(code);
        $("#editForm input[name='name']").val(name);
        $("#editForm input[name='type']").val(type);
         $(".area-th").html("<i class=\"icon-edit\"></i>编辑"+name) ;
         /* $("#tree").data("areaName",con);
        $(".tree-form").load(url,function(){
            $(".area-th").html("<i class=\"icon-edit\"></i>编辑"+con) ;
            $(".alert-error").hide();
            $(".alert-success").hide();
        })*/
    })

    $("#editForm").live("submit",function(e){
        e.preventDefault();
        //$("#editForm input[name='code']").attr("readonly",true)
        var url = $(this).attr("action")
        var id = $("#editForm input[name='id']").val();
        var parentId = $("#editForm input[name='parentId']").val();
        var code = $("#editForm input[name='code']").val();
        var name = $("#editForm input[name='name']").val();
        var type = $("#editForm input[name='type']").val();
        var parentName = $("#editForm span.area-parent").html();

        var oldCode = $("#tree").data("parentCode");
        if(!code || !name){
            return
        }

        $.post(url,{id:id,parentId:parentId,code:code,name:name,type:type},function(data){
             var res = $.parseJSON(data)
            if(res.status == '1'){
                $("#editForm input[name='id']").val(code);
                $("#tree").data("parentName",name);
                $("#tree").data("parentCode",code);
                $("#tree").data("parentType",type);
                $(".area-th").html("<i class=\"icon-edit\"></i>编辑"+name) ;
                $(".alert-success").show();
                $(".alert-error").hide();
                if(id){
                    if(type == '1') {
                        var li = $("#province"+oldCode)
                        li.attr('id',"province"+code) ;
                        var a = li.children('a')
                        a.attr("rel","1|"+code+"|"+name);
                        a.html(name)
                    }
                    if(type == '2') {
                        var li = $("#city"+oldCode)
                        li.attr('id',"city"+code) ;
                        var a = li.children('a')
                        a.attr("rel","2|"+code+"|"+name+"|"+parentId+"|"+parentName);
                        a.html(name)
                    }
                    if(type == '3') {
                        var li = $("#district"+oldCode)
                        li.attr('id',"district"+code) ;
                        var a = li.children('a')
                        a.attr("rel","3|"+code+"|"+name+"|"+parentId+"|"+parentName);
                        a.html(name)
                    }
                    $("#editForm input[name='id']").val(code);
                }else{
                    if(type == '1') {
                        var li = "<li id=\"province"+code+"\" class=\"last\"><a href=\"javascript:void 0\"  rel=\"1|"+code+"|"+name+"\">"+name+"</a></li>" ;
                        var lastli = $("#tree").children().last();
                        lastli.removeClass("last")
                        lastli.removeClass("lastExpandable");
                        lastli.removeClass("lastCollapsable");
                        lastli.children().first().removeClass("lastExpandable-hitarea");
                        lastli.children().first().removeClass("lastCollapsable-hitarea");
                        $("#tree").append(li);
                    }
                    if(type == '2') {
                        var province = $("#province"+parentId);
                        var ulObj = province.children("ul") ;

                        if(!ulObj || ulObj.length == 0) {
                            var lastli = $("#tree").children().last();
                            var nul = "<div class=\"hitarea collapsable-hitarea\"></div>";
                            province.addClass("collapsable")
                            if(lastli.attr("id") == province.attr("id")) {
                                province.addClass("lastCollapsable")
                                nul = "<div class=\"hitarea collapsable-hitarea lastCollapsable-hitarea\"></div>";
                            }
                            var ht = province.html()
                            nul += ht+"<ul style=\"display: block;\">"
                            nul += "<li id=\"city"+code+"\" class=\"last\"><a rel=\"2|"+code+"|"+name+"|"+parentId+"|"+parentName+"\" href=\"javascript:void 0\" class=\"\">"+name+"</a>"
                            nul += "</ul>"
                            province.html(nul)
                        }else{
                            var listr = "<li id=\"city"+code+"\" class=\"last\"><a href=\"javascript:void 0\"  rel=\"2|"+code+"|"+name+"|"+parentId+"|"+parentName+"\">"+name+"</a></li>" ;
                            var lastli = ulObj.children().last();
                            lastli.removeClass("last")
                            lastli.removeClass("lastExpandable");
                            lastli.removeClass("lastCollapsable");
                            lastli.children().first().removeClass("lastExpandable-hitarea");
                            lastli.children().first().removeClass("lastCollapsable-hitarea");
                            ulObj.append(listr);
                        }
                    }
                    if(type == '3') {
                        var cityObj = $("#city"+parentId);
                        var proObj = cityObj.parent()
                        var ulObj = cityObj.children("ul") ;

                        if(!ulObj || ulObj.length == 0) {
                            var lastli = proObj.children().last();
                            var nul = "<div class=\"hitarea collapsable-hitarea\"></div>";
                            cityObj.addClass("collapsable")
                            if(lastli.attr("id") == cityObj.attr("id")) {
                                cityObj.addClass("lastCollapsable")
                                nul = "<div class=\"hitarea collapsable-hitarea lastCollapsable-hitarea\"></div>";
                            }
                            var ht = cityObj.html()
                            nul += ht+"<ul style=\"display: block;\">"
                            nul += "<li id=\"city"+code+"\" class=\"last\"><a rel=\"3|"+code+"|"+name+"|"+parentId+"|"+parentName+"\" href=\"javascript:void 0\" class=\"\">"+name+"</a>"
                            nul += "</ul>"
                            cityObj.html(nul)
                        }else{
                            var listr = "<li id=\"city"+code+"\" class=\"last\"><a href=\"javascript:void 0\"  rel=\"3|"+code+"|"+name+"|"+parentId+"|"+parentName+"\">"+name+"</a></li>" ;
                            var lastli = ulObj.children().last();
                            lastli.removeClass("last")
                            lastli.removeClass("lastExpandable");
                            lastli.removeClass("lastCollapsable");
                            lastli.children().first().removeClass("lastExpandable-hitarea");
                            lastli.children().first().removeClass("lastCollapsable-hitarea");
                            ulObj.append(listr);
                        }
                    }
                }
            }else{
                $(".alert-error").show();
                $(".alert-success").hide();
            }
        })
    })

    $(".area-add").live("click",function(){
       // $("#editForm input[name='code']").attr("readonly",false)
        var parentName = $("#tree").data("parentName");
        var parentCode =$("#tree").data("parentCode");
        var parentType =$("#tree").data("parentType");
        if(parentType == '2') {
            $(this).hide();
        }else{
            $(this).show()
        }
        var con = parentName;
        if(!con) {
            con = "新建节点"
        }else{
            con = " 新建"+con+"子节点"
        }

        var type = ''
        if(parentType == '3'){
            return
        }
        $(".alert-error").hide();
        $(".alert-success").hide();

        $("#editForm input[type='text'],#editForm input[type='hidden']").val('')
        if(parentType == '1'){
            type = '2' ;
        }
        if(parentType == '2'){
            type = '3';
        }
        $(".area-th").html("<i class=\"icon-edit\"></i>"+con);

        $("#editForm input[name='parentId']").val(parentCode);
        $("#editForm .area-parent").html(parentName);
        $("#editForm input[name='type']").val(type) ;

    })

    $(".area-add-root").live("click",function(){
        $(".alert-error").hide();
        $(".alert-success").hide();
        $("#editForm input[type='text'],#editForm input[type='hidden']").val('')
        $(".area-th").html("<i class=\"icon-edit\"></i>新建节点");
        $("#editForm input[name='type']").val('1');
    })

    $(".area-remove").click(function(e){
        e.preventDefault();
        var id = $("#editForm input[name='id']").val();
        var type = $("#editForm input[name='type']").val();
        if(!id || id == '' || !type || type == ''){
            return
        }
        var liId = (type == '1'?'province':(type == '2'?'city':(type == '3'?'district':'')));
        liId = $("#"+liId+id);
        var url = $(this).attr("rel");
        $.post(url,{id:id,type:type},function(data){
             if(data.status == '1'){
                 $(".alert-success").show();
                 $(".alert-error").hide();
                 liId.fadeOut()
                 $("#editForm input[type='text'],#editForm input[type='hidden']").val('')
             }else{
                 $(".alert-error").show();
                 $(".alert-success").hide();
             }
        },'json')
    })
})
