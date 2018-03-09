<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>动态管理</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>动态管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="form-group">
        </div>
        <div class="form-group">
            <div class="col-sm-2" id="state">
                <select class="form-control" name="state">
                    <option value="1">通过</option>
                    <option value="2">未通过</option>
                </select>
            </div>
            <button class="btn btn-success " id="search_btn">搜索</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>id</th>
                    <th>头像</th>
                    <th>标题</th>
                    <th>姓名</th>
                    <th>昵称</th>
                    <th>发布时间</th>
                    <th>浏览量</th>
                    <th>赞数</th>
                    <th>审核</th>
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
        <div class="col-md-5" id="page_info">

        </div>
        <!--分页条信息-->
        <div class="col-md-5" id="age_nav">

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
        var state = $("#state select").val();//状态
        $.ajax({
            url: "${staticPath}/getManagerTopicList",
            data: {"pn": pn, "state": state},
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

    //显示员工列表
    function build_emps_table(result) {
        //先清空table表格
        $("#emps_table tbody").empty();
        var news_manager_list = result.extend.pageInfo.list;
        $.each(news_manager_list, function (index, item) {
            var news_id = $("<th ></th>").append(item.id);
            var imgTd = $("<th ></th>").append($("<img style='width: 38px;height: 38px;'/>").addClass("img-circle").attr("src", item.imgHeah));
            var news_title = $("<th ></th>").append(item.title.length > 20 ? item.title.substring(0, 20) + "..." : item.title);
            var send_name = $("<th ></th>").append(item.name);
            var from_dept = $("<th ></th>").append(item.nickname);
            var send_time = $("<th ></th>").append(formatDateTime(item.ttime));
            var news_look_num = $("<th ></th>").append(item.tclickcount + "次");
            var zan_num = $("<th ></th>").append(item.tzan + "次");
            var topic_state = $("<th ></th>").append(item.tstaus == 1 ? "通过" : "未通过");
            var delBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                data-placement=\"top\" title=\"删除动态\"></i>").addClass("glyphicon glyphicon-trash del_btn");
            delBtn.attr("del_id", item.id);

            if (item.tstaus == 2) {
                var check_Btn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                    "                   data-placement=\"top\" title=\"审核动态\"></i>")
                    .addClass("glyphicon glyphicon-ok check_btn");
                check_Btn.attr("check_id", item.id);
            }

            var btnTd = $("<th ></th>").append(check_Btn == null ? "" : check_Btn).append("&nbsp;&nbsp;&nbsp;&nbsp;").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(news_id)
                .append(imgTd)
                .append(news_title)
                .append(send_name)
                .append(from_dept)
                .append(send_time)
                .append(news_look_num)
                .append(zan_num)
                .append(topic_state)
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

    //删除动态
    $(document).on("click", ".del_btn", function () {

        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(2)").text();
        var id = $(this).attr("del_id");
        layer.confirm("确认删除 " + deptName + " 这个动态吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/delMyTopic?id=" + id,
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
    //动态审核
    $(document).on("click", ".check_btn", function () {
        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(2)").text();
        var id = $(this).attr("check_id");
        alert(id);
        layer.confirm("确认通过审核 " + deptName + "这个动态吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/updatetopic?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.msg("审核成功！");
                    } else {
                        layer.msg("审核失败！");
                    }
                    setTimeout(function () {
                        to_page(currentNum);
                    }, 3000);
                }
            });
        }, function () {

        });
    });

</script>
</html>







