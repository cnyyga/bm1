$(function(){
    var genderUrl = $("#genderchart").attr('dataUrl');
    var cityUrl = $("#citychart").attr('dataUrl');
    var middleSchoolUrl = $("#middleSchoolchart").attr('dataUrl');
    var reviewStatusUrl = $("#reviewStatuschart").attr('dataUrl');
    var teacherUrl = $("#teacherStatuschart").attr('dataUrl');
    var yearUrl = $("#yeaChart").attr('dataUrl');

    var sd = $("#startDate").val();
    var ed =  $("#endDate").val();

    var year =  $("#year").val();

    var biludPie =   {
        series: {
            pie: {
                show: true   ,
                label: {
                    show: true
                }
            }
        },
        grid: {
            hoverable: true,
            clickable: true
        },
        legend: {
            show: false
        }
    }
    var biuldLine = {
        series: {
            lines: { show: true  },
            points: { show: true }
        }, xaxis: { mode: "time" },
        grid: { hoverable: true, clickable: true, backgroundColor: { colors: ["#fff", "#eee"] } },
        yaxis: { },
        colors: ["#539F2E", "#3C67A5"]
    }

    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            top: y + 5,
            left: x + 5,
            border: '1px solid #fdd',
            padding: '2px',
            'background-color': '#dfeffc',
            opacity: 0.80
        }).appendTo("body").fadeIn(200);
    }

    $("#yeaChart").bind("plothover", function (event, pos, item) {
        $("#x").text(pos.x.toFixed(2));
        $("#y").text(pos.y.toFixed(2));

        if (item) {
            if (previousPoint != item.dataIndex) {
                previousPoint = item.dataIndex;
                $("#tooltip").remove();
                var x = item.datapoint[0].toFixed(2),
                    y = item.datapoint[1].toFixed(2);
                var d = new Date()
                d.setTime(x)
                showTooltip(item.pageX, item.pageY, d.getFullYear() + " , " + parseInt(y));
            }
        }
        else {
            $("#tooltip").remove();
            previousPoint = null;
        }
    });

    $.get(genderUrl,{year:year},function(data){
        $.plot($("#genderchart"), data, biludPie);
    },'json');
    $.get(cityUrl,{year:year},function(data){
        $.plot($("#citychart"), data, biludPie);
    },'json')  ;
    $.get(middleSchoolUrl,{year:year},function(data){
        $.plot($("#middleSchoolchart"), data, biludPie);
    },'json')
    ;
    $.get(reviewStatusUrl,{year:year},function(data){
        $.plot($("#reviewStatuschart"), data, biludPie);
    },'json')   ;
    $.get(teacherUrl,{year:year},function(data){
        $.plot($("#teacherStatuschart"), data, biludPie);
    },'json')     ;

    $.get(yearUrl,{year:year},function(data){
        $.plot($("#yeaChart"),[data] , biuldLine);
    },'json')
})


