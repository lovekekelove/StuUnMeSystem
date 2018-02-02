<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>角色管理</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>权限管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <%--<c:if test="${roseId ==1}"> </c:if>--%>
        <div class="col-md-2"></div>
        <div class="row">
            <div class="pull-right">
                <button class="btn btn-success" id="addEmp_modal_btn">新增</button>
            </div>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>权限</th>
                    <th>父Id</th>
                    <th>URL</th>
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
        var name = $("#serch").val();
        $.ajax({
            url: "${staticPath}/rightManagers",
            data: {"pn": pn, "name": name},
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

    $("#btn_serch").click(function () {
        to_page(1);
    });

    //显示员工列表
    function build_emps_table(result) {
        //先清空table表格
        $("#emps_table tbody").empty();
        var deptstus = result.extend.pageInfo.list;
        $.each(deptstus, function (index, item) {
            var IDTd = $("<th ></th>").append(item.id);
            var rightTd = $("<th ></th>").append(item.right);
            var fidTd = $("<th ></th>").append(item.fid == null ? "主菜单栏" : item.fid);
            var urlTd = $("<th ></th>").append(item.url);
            var checkBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                   data-placement=\"top\" title=\"修改权限\"></i>")
                .addClass("glyphicon glyphicon-paperclip check_btn");

            var delBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                data-placement=\"top\" title=\"删除权限\"></i>").addClass("glyphicon glyphicon-trash del_btn");
            // var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
            //     .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            //     .append("删除");

            delBtn.attr("del_id", item.id);
            checkBtn.attr("check_id", item.id);
            var btnTd = $("<th ></th>")
                .append(checkBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(IDTd)
                .append(rightTd)
                .append(fidTd)
                .append(urlTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }


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
        var prePageLi = $("<li></li>").append($("<a style='cursor: pointer'></a>").append("&laquo;"));

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

        var nextPageLi = $("<li></li>").append($("<a style='cursor: pointer'></a>").append("&raquo;"));
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

    //删除权限
    $(document).on("click", ".del_btn", function () {

        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(1)").text();
        var id = $(this).attr("del_id");
        layer.confirm("确认删除 " + deptName + " 吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/deleteRight?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 1000});
                        setTimeout(function (args) {
                            layer.msg("删除成功！");
                        }, 1500);
                    }
                    else {
                        layer.load(0, {time: 1000});
                        setTimeout(function (args) {
                            layer.msg("删除失败！");
                        }, 1500);
                    }
                    setTimeout(function () {
                        to_page(currentNum);
                    }, 2000);
                }
            });
        }, function () {

        });
    });
    //权限修改
    $(document).on("click", ".check_btn", function () {
        var id = $(this).attr("check_id");
        layer.open({
            type: 2,
            title: '权限修改',
            shadeClose: false,
            shade: 0.6,
            anim: 1,
            // maxmin: true, //开启最大化最小化按钮
            area: ['364px', '364px'],
            content: '${staticPath}/updateRightJsp?id=' + id,
            end: function () {
                to_page(currentNum);
            }
        });
    });

    //权限添加
    $(document).on("click", "#addEmp_modal_btn", function () {
        layer.open({
            type: 2,
            title: '权限添加',
            shadeClose: false,
            shade: 0.6,
            anim: 1,
            // maxmin: true, //开启最大化最小化按钮
            area: ['364px', '364px'],
            content: '${staticPath}/rightJsp',
            end: function () {
                to_page(totalRecord);
            }
        });

    });


</script>
</html>




