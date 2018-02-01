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

    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        layer.load(0, {time: 1000});
    });


    //分页
    function to_page() {
        var name = $("#serch").val();
        $.ajax({
            url: "${staticPath}/user/userManagers",
            data: {"name": name},
            type: "GET",
            dataType: "json",
            success: function (result) {
                //1.解析并显示员工数据
                build_emps_table(result);
            }
        });
    }

    $("#btn_serch").click(function () {
        to_page();
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

</script>
</html>




