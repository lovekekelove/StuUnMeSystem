<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加系部</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>留言管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <%--<c:if test="${roseId ==1}"> </c:if>--%>
        <div class="col-md-2"></div>
        <div class="input-group input-group-sm " style="width: 250px;">
            <input type="text" name="table_search" id="serch" class="form-control pull-right" placeholder="输入昵称进行搜索">

            <div class="input-group-btn">
                <button class="btn btn-success" id="btn_serch"><i class="fa fa-search"></i></button>
            </div>
        </div>

        <div>
            <button class="btn btn-danger pull-right" id="delEmp_modal_btn">批量删除</button>
        </div>


    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>ID</th>
                    <th>头像</th>
                    <th>昵称</th>
                    <th>留言时间</th>
                    <th>内容</th>
                    <th>点赞次数</th>
                    <th>状态</th>
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
            url: "${staticPath}/leaves",
            data: {"pn": pn, "serch": serch_var},
            type: "GET",
            dataType: "json",
            success: function (result) {
                console.log(result)
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                build_page_(result);
                //3.//显示分页条
                build_page_nav(result);
            }
        });
    }

    $("#btn_serch").click(function () {
        to_page(1);
    });

    //显示员工列表
    function build_emps_table(result) {
        //先清空table表格
        $("#emps_table tbody").empty();
        var deptstus = result.extend.pageInfo.list;
        $.each(deptstus, function (index, item) {
            var checkTd = $("<th ><input type='checkbox' class='check_item'/></th>");
            var IDTd = $("<th ></th>").append(item.id);
            var imgTd = $("<th ></th>").append($("<img style='width: 38px;height: 38px;'/>").addClass("img-circle").attr("src", item.imgHeah));
            var deptNameTd = $("<th ></th>").append(item.nickname);
            var createTimeTd = $("<th ></th>").append(formatDateTime(item.creattime));
            var countTd = $("<th ></th>").append(item.count.length > 15 ? item.count.substring(0, 15) + "..." : item.count);
            var numTd = $("<th ></th>").append(item.zanNum == null ? "0次" : item.zanNum + "次");
            var stateTd = $("<th ></th>").append(item.state == 1 ? "通过" : "未通过");

            var checkBtn = $("<button></button>").addClass("btn btn-success btn-sm check_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("审核");

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            delBtn.attr("del_id", item.id);
            checkBtn.attr("check_id", item.id);
            var btnTd = $("<th ></th>").append(checkBtn).append(" ").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(checkTd)
                .append(IDTd)
                .append(imgTd)
                .append(deptNameTd)
                .append(createTimeTd)
                .append(countTd)
                .append(numTd)
                .append(stateTd)
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

    //弹出模态框
    $("#addEmp_modal_btn").click(function () {
        //清除表单数据和样式
        reset_form("#empAdd form");
        //弹出模态框
        $("#empAdd").modal({
            backdrop: "static"
        });
    });

    //清除表单数据和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    $(document).on("click", ".del_btn", function () {
        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(3)").text();
        var id = $(this).attr("del_id");

        layer.confirm("确认删除 " + deptName + " 的留言吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/delLeave?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("删除成功！");
                        }, 2000);
                    } else {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("删除失败！");
                        }, 2000);
                    }
                    setTimeout(function () {
                        to_page(currentNum);
                    }, 3000);
                }
            });
        }, function () {

        });
    });

    $(document).on("click", ".check_btn", function () {
        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(3)").text();
        var id = $(this).attr("check_id");

        layer.confirm("确认通过审核 " + deptName + " 的留言吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/updateLeave?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("审核成功！");
                        }, 2000);
                    } else {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("审核失败！");
                        }, 2000);
                    }
                    setTimeout(function () {
                        to_page(currentNum);
                    }, 3000);
                }
            });
        }, function () {

        });
    });

    ///////////////////////////////批量删除//////////////////////////////////
    //1.多选框的全选和全不选
    $("#check_all").click(function () {
        //attr获取checked时undefind;
        //我们这些dom原生的属性用prop；
        //attr用获取自定义属性的值
        //$(this).prop("checked")：指的是点击之后是true还是false
        $(".check_item").prop("checked", $(this).prop("checked"));
    });
    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择的元素是不是五个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });


    $("#delEmp_modal_btn").click(function () {

        if ($(".check_item:checked").length < 1) {
            layer.tips("请选择！", "#delEmp_modal_btn", {anim: 6});
            return false;
        }
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"), function () {
            del_ids += $(this).parents("tr").find("th:eq(1)").text() + "-";
            empNames += $(this).parents("tr").find("th:eq(3)").text() + ",";
        });
        empNames = empNames.substring(0, empNames.length - 1);
        del_ids = del_ids.substring(0, del_ids.length - 1);

        layer.confirm("确认删除 " + empNames + " 的留言吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/deleteLeaves/" + del_ids,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("删除成功！");
                        }, 2000);
                    } else {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("删除失败！");
                        }, 2000);
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



