<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>新闻首页</title>
</head>
<body>
<div class="row">
    <div class="form-group">
        <div class="col-md-4"></div>
        <div class="col-md-8">
            <h1>校园新闻头条</h1>
        </div>
    </div>
    <br>
    <br>
    <br> <br>
    <br>
    <br>
    <div class="row" style="width: 60%; margin-left: 150px">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <div class="col-md-1"></div>
        <!--分页文字信息-->
        <div class="col-md-5" id="page_info">

        </div>
        <!--分页条信息-->
        <div class="col-md-5" id="age_nav">

        </div>

    </div>
</div>
</body>
<script>

    var totalRecord, currentNum;
    $(function () {
        to_page(1);
    });

    //分页
    function to_page(pn) {
        $("#emps_table tbody").empty();
        $.ajax({
            url: "${staticPath}/getNews",
            data: {"pn": pn},
            type: "GET",
            dataType: "json",
            success: function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_(result);
                //3.//显示分页条
                build_page_nav(result);
            }
        });
    }

    $("#search_btn").click(function () {
        to_page(1);
    });

    //显示新闻列表
    function build_emps_table(result) {
        var news_count = result.extend.pageInfo.list;
        $.each(news_count, function (index, item) {
            var stu_name = $("<th ></th>").append(item.deptName + "：");
            var nianji_name = $("<th ></th>").append($("<a  href='/lookNewsCount?id=" + item.id + "' ></a>")
                .append(item.title.length > 30 ? item.title.substring(0, 30) + "...." : item.title));
            var dept_name = $("<th ></th>").append(formatDateTime(item.sendTime));

            $("<tr></tr>")
                .append(stu_name)
                .append(nianji_name)
                .append(dept_name)
                .appendTo("#emps_table tbody");
        });
    }

    function formatDateTime(inputTime) {
        var date = new Date(inputTime);
        var y = date.getFullYear();
        var m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        var d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        var h = date.getHours();
        h = h < 10 ? ('0' + h) : h;
        var minute = date.getMinutes();
        var second = date.getSeconds();
        minute = minute < 10 ? ('0' + minute) : minute;
        second = second < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d + ' ' + h + ':' + minute + ':' + second;
    };


    //显示分页信息
    function build_page_(result) {
        //清空
        $("#page_info").empty();
        $("#page_info").append($("<h4></h4>").append("当前第<mark>" + result.extend.pageInfo.pageNum + "</mark>页，" +
            "总共<mark>" + result.extend.pageInfo.pages + "</mark>页，" +
            "总共<mark>" + result.extend.pageInfo.total + "</mark>记录"));
        totalRecord = result.extend.pageInfo.total;
        currentNum = result.extend.pageInfo.pageNum;
    }

    //显示分页条
    function build_page_nav(result) {
        //清空
        $("#age_nav").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        } else {
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numPageLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numPageLi.addClass("active");
            }
            numPageLi.click(function () {
                to_page(item);
            });
            ul.append(numPageLi);
        });

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(nextPageLi).append(lastPageLi);
        var nvaEle = $("<nva></nva>").append(ul);
        nvaEle.appendTo("#age_nav");
    }
</script>
</html>
