$(function () {
    $(".J_menuItem").on('click', function () {
        var url = $(this).attr('href');
        $("#J_iframe").attr('src', url);
        return false;
    });

    $('#searchform').submit(function (e) {
        $('#J_iframe').attr('src', '/show/search?searchkey=' + $('#searchkey').val());
        return false;
    });

    // $(function setIframeHeight() {
    //     var iframe ;//高度初始化600，为了14寸笔记本
    //     iframe =$('.mainiframe');
    //     iframe.height=document.getElementById("sidebar").offsetHeight-56;

//        if (iframe) {
//            var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
//            if (iframeWin.document.body) {
//                iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
//            }
//        }

    })
});