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
            <h2></h2>
        </div>
    </div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <!--按钮-->
    <div class="row">
        <%--<c:if test="${roseId ==1}"> </c:if>--%>
        <div class="col-md-4"></div>
        <div class="input-group input-group-sm " style="width: 400px;">
            <input type="text" name="table_search" id="serch" class="form-control pull-right" placeholder="输入邮箱进行搜索">
            <div class="input-group-btn">
                <button class="btn btn-success" id="btn_serch"><i class="fa fa-search"></i></button>
            </div>
        </div>

    </div>
    <br>
    <br>
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
<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script src="//res.layui.com/layui/dist/layui.js?t=1515376178709" charset="utf-8"></script>
<script>

    $("#btn_serch").click(function () {
        to_page();
    });


    //分页
    function to_page() {
        var email = $("#serch").val();
        $.ajax({
            url: "${staticPath}/findFriend",
            data: {"email": email},
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
        var deptstus = result.extend.user;
        var IDTd = $("<th ></th>").append(deptstus.id);
        var imgTd = $("<th ></th>").append($("<img style='width: 38px;height: 38px;'/>").addClass("img-circle").attr("src", deptstus.imgHeah));
        var deptNameTd = $("<th ></th>").append(deptstus.nickname);
        var countTd = $("<th ></th>").append(deptstus.name);
        var stateTd = $("<th ></th>").append(deptstus.state == '1' ? "通过审核" : "未通过审核");


        var addBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
            "                data-placement=\"top\" title=\"添加用户\"></i>").addClass("glyphicon glyphicon-plus-sign del_btn");
            // var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
            //     .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            //     .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID

        addBtn.attr("del_id", deptstus.id);
        var btnTd = $("<th ></th>").append(addBtn);
            //append()方法执行完以后还会返回原来的元素
        $("<tr style='background-color: #b0f0a0'></tr>")
                .append(IDTd)
                .append(imgTd)
                .append(deptNameTd)
                .append(countTd)
                .append(stateTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
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




