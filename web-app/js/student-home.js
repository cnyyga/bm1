$(function(){
      var uls = $("ul.dashboard-list")
      uls.each(function(){
          setContent($(this))
      })

    function setContent(ul) {
        var year = $("#year").val();
        var url = $(ul).attr("req-content-url")    ;
        $(ul).append('<div id="loading" class="center">Loading...<div class="center"></div></div>');
        $(ul).load(url,{year:year})
    }
})