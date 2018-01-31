$(function () {
    $(document).on("click", ".J_menuItem", function () {
        var url = $(this).attr('href');
        $("#J_iframe").attr('src', url);
        setTimeout(function () {
            $("body").removeClass("sidebar-open");
            $("body").addClass("sidebar-collapse");
        }, 1500);
        return false;
    });
    $('#searchform').submit(function (e) {
        $('#J_iframe').attr('src', '/show/search?searchkey=' + $('#searchkey').val());
        return false;
    });

});