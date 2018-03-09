<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>评论管理</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>评论管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <%--<c:if test="${roseId ==1}"> </c:if>--%>
        <div class="col-md"></div>

    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>评论人</th>
                    <th>动态标题</th>
                    <th>评论时间</th>
                    <th>内容</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <!--显示分页信息-->
    <div class="row">
        <div class="col-md-1"></div>
        <!--分页文字信息-->
        <div class="col-md-7" id="page_info">

        </div>
        <!--分页条信息-->
        <div class="col-md-4" id="age_nav">

        </div>

    </div>
</div>
</body>
<script>
    $(function () {
        layer.load(0, {time: 1000});
    });

    var totalRecord, currentNum;
    $(function () {
        to_page(1);
    });

    //分页
    function to_page(pn) {
        var serch_var = $("#serch").val();
        $.ajax({
            url: "${staticPath}/commentMan",
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

    //显示员工列表
    function build_emps_table(result) {
        //先清空table表格
        $("#emps_table tbody").empty();
        var deptstus = result.extend.pageInfo.list;
        $.each(deptstus, function (index, item) {
            var IDTd = $("<th ></th>").append(item.comId);
            var nickname = $("<th ></th>").append(item.nickname);
            var title_Td = $("<th ></th>").append(item.title);
            var createTimeTd = $("<th ></th>").append(formatDateTime(item.comTime));
            var countTd = $("<th ></th>").append(item.comCount.length > 15 ? item.comCount.substring(0, 15) + "..." : item.comCount);

            var lookBtn = $("<button></button>").addClass("btn btn-success btn-sm  look_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-tag"))
                .append("查看");
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            delBtn.attr("del_id", item.comId);
            lookBtn.attr("topic_id", item.topicId);
            var btnTd = $("<th ></th>").append(lookBtn).append(" ").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(IDTd)
                .append(nickname)
                .append(title_Td)
                .append(createTimeTd)
                .append(countTd)
                .append(btnTd)
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


    $(document).on("click", ".look_btn", function () {
        var id = $(this).attr("topic_id");
        window.location.href = "${staticPath}/lookTopic?id=" + id;
    });


    $(document).on("click", ".del_btn", function () {

        //1.弹出是否删除确认框
        var CommentName = $(this).parents("tr").find("th:eq(3)").text();
        var id = $(this).attr("del_id");
        layer.confirm("确认删除 " + CommentName + " 这条评论吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/delComment?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("删除成功！");
                    } else {
                        layer.msg("删除失败！");
                    }
                    setTimeout(function () {
                        to_page(currentNum);
                    }, 1000);
                }
            });
        }, function () {

        });
    });


</script>
</html>





