<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>用户管理</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>用户管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <%--<c:if test="${roseId ==1}"> </c:if>--%>
        <div class="col-md-2"></div>
        <div class="input-group input-group-sm " style="width: 250px;">
            <input type="text" name="table_search" id="serch" class="form-control pull-right" placeholder="输入姓名进行搜索">

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
                    <th>姓名</th>
                    <th>角色</th>
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
            url: "${staticPath}/user/userManagers",
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
            var checkTd = $("<th ><input type='checkbox' class='check_item'/></th>");
            var IDTd = $("<th ></th>").append(item.id);
            var imgTd = $("<th ></th>").append($("<img style='width: 38px;height: 38px;'/>").addClass("img-circle").attr("src", item.imgHeah));
            var deptNameTd = $("<th ></th>").append(item.nickname);
            var countTd = $("<th ></th>").append(item.name);
            var numTd = $("<th ></th>").append(item.roseName);
            var stateTd = $("<th ></th>").append(item.state == '1' ? "通过" : "未通过");

            var changeRoseBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\"\n" +
                "        data-placement=\"top\" title=\"角色修改\"></i>")
                .addClass("glyphicon glyphicon-edit rose_btn");

            var showBtn = $("<i style='cursor: pointer' data-toggle=\\\"tooltip\\\"\\n\" +\n" +
                "                    data-placement=\"top\" title=\"个人资料\"></i>")
                .addClass("glyphicon glyphicon-user show_btn");

            var checkBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                   data-placement=\"top\" title=\"审核用户\"></i>")
                .addClass("glyphicon glyphicon-ok check_btn");

            var delBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                data-placement=\"top\" title=\"删除用户\"></i>").addClass("glyphicon glyphicon-trash del_btn");
            // var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
            //     .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            //     .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            changeRoseBtn.attr("rose_id", item.id);
            showBtn.attr("show_id", item.id);
            delBtn.attr("del_id", item.id);
            checkBtn.attr("check_id", item.id);
            var btnTd = $("<th ></th>").append(changeRoseBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;")
                .append(showBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;")
                .append(checkBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(checkTd)
                .append(IDTd)
                .append(imgTd)
                .append(deptNameTd)
                .append(countTd)
                .append(numTd)
                .append(stateTd)
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

    //删除用户
    $(document).on("click", ".del_btn", function () {

        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(3)").text();
        var id = $(this).attr("del_id");

        layer.confirm("确认删除 " + deptName + " 吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/user/delUser?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("删除成功！");
                        }, 2000);
                    } else if (result.extend.error == 1) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("不能删除自己！");
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
    //角色修改
    $(document).on("click", ".rose_btn", function () {
        var id = $(this).attr("rose_id");
        layer.open({
            type: 2,
            title: '角色修改',
            shadeClose: false,
            shade: false,
            // maxmin: true, //开启最大化最小化按钮
            area: ['264px', '254px'],
            content: '${staticPath}/user/checkRose?id=' + id,
            end: function () {
                to_page(currentNum);
            }
        });
    });
    //查看个人资料
    $(document).on("click", ".show_btn", function () {
        var id = $(this).attr("show_id");
        var show = layer.open({
            type: 2,
            title: '用户资料',
            shadeClose: false,
            shade: false,
            // maxmin: true, //开启最大化最小化按钮
            //area: ['264px', '254px'],
            content: '${staticPath}/user/stuInfo?id=' + id
        });
        layer.full(show);
    });
    //用户审核
    $(document).on("click", ".check_btn", function () {
        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(3)").text();
        var id = $(this).attr("check_id");

        layer.confirm("确认通过审核 " + deptName + " 吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/user/updateUser?id=" + id,
                type: "get",
                dataType: "json",
                success: function (result) {
                    if (result.code == 100) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("审核成功！");
                        }, 2000);
                    } else if (result.extend.error == 1) {
                        layer.load(0, {time: 2000});
                        setTimeout(function (args) {
                            layer.msg("不能删除自己！");
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

        layer.confirm("确认删除 " + empNames + " 吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/user/deleteUsers/" + del_ids,
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



