<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>纳新管理</title>
</head>
<body style="width: 90%">

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>纳新管理</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="form-group">
            <br>
            <br>
        </div>

        <div class="form-group">
            <div class="col-sm-2" id="deptName">
                <select class="form-control" name="deptName">
                    <option value="">系部:</option>
                </select>
            </div>
            <div class="col-sm-2" id="jibie">
                <select class="form-control" name="dId">
                    <option value="">年级:</option>
                </select>
            </div>
            <div class="col-sm-2" id="dept">
                <select class="form-control" name="dId">
                    <option value="">部门：</option>
                </select>
            </div>
            <div class="col-sm-2" id="state">
                <select class="form-control" name="state">
                    <option value="3">未通知</option>
                    <option value="4">等待面试</option>
                </select>
            </div>
            <button class="btn btn-success " id="search_btn">搜索</button>
        </div>
        <%--<c:if test="${roseId ==1}"> </c:if>--%>


    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>照片</th>
                    <th>学号</th>
                    <th>姓名</th>
                    <th>年级</th>
                    <th>系别</th>
                    <th>部门</th>
                    <th>班级</th>
                    <th>爱好</th>
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
        var deptNameId = $("#deptName select").val();//系部id
        var jiid = $("#jibie select").val();//年级
        var deptid = $("#dept select").val();//部门
        var classs = $("#classs select").val();//班级
        var state = $("#state select").val();//状态
        $.ajax({
            url: "${staticPath}/naxingmanager",
            data: {"pn": pn, "dId": deptNameId, "jiId": jiid, "deptId": deptid, "classId": classs, "state": state},
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
        var deptstus = result.extend.pageInfo.list;
        $.each(deptstus, function (index, item) {
            var imgTd = $("<th ></th>").append($("<img style='width: 38px;height: 38px;'/>").addClass("img-circle").attr("src", item.picture));
            var stu_id = $("<th ></th>").append(item.stuId);
            var stu_name = $("<th ></th>").append(item.name);
            var nianji_name = $("<th ></th>").append(item.dengJi);
            var dept_name = $("<th ></th>").append(item.deptName);
            var deptNameTd = $("<th ></th>").append(item.deptStuName);
            var class_name = $("<th ></th>").append(item.className);
            var speciality = $("<th ></th>").append(item.speciality.length > 5 ? item.speciality.substring(0, 5) + "..." : item.speciality);
            var stateTd = $("<th ></th>").append(item.state == '3' ? "未通知" : "等待面试");
            if (item.state == 3) {
                var changeRoseBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\"\n" +
                    "        data-placement=\"top\" title=\"发送通知\"></i>")
                    .addClass("glyphicon glyphicon-edit user_id");
            }

            var checkBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                   data-placement=\"top\" title=\"审核用户\"></i>")
                .addClass("glyphicon glyphicon-ok check_btn");

            var delBtn = $("<i style='cursor: pointer' data-toggle=\"tooltip\" +\n" +
                "                data-placement=\"top\" title=\"删除用户\"></i>").addClass("glyphicon glyphicon-trash del_btn");
            // var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
            //     .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
            //     .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            changeRoseBtn.attr("name", item.name);
            delBtn.attr("del_id", item.naId);
            checkBtn.attr("check_id", item.naId);
            var btnTd = $("<th ></th>").append(changeRoseBtn == null ? "" : changeRoseBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;")
                .append(checkBtn).append("&nbsp;&nbsp;&nbsp;&nbsp;").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>")
                .append(imgTd)
                .append(stu_id)
                .append(stu_name)
                .append(nianji_name)
                .append(dept_name)
                .append(deptNameTd)
                .append(class_name)
                .append(speciality)
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
        var deptName = $(this).parents("tr").find("th:eq(2)").text();
        var id = $(this).attr("del_id");

        layer.confirm("确认删除 " + deptName + " 吗？", {
            btn: ['确定', '取消'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/delNaXin?id=" + id,
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
    //发送通知
    $(document).on("click", ".user_id", function () {
        var name = $(this).attr("name");
        layer.open({
            type: 2,
            title: '发送通知==>>' + name,
            shadeClose: false,
            shade: false,
            // maxmin: true, //开启最大化最小化按钮
            area: ['780px', '510px'],
            content: '${staticPath}/sendMsg.jsp?name=' + name,
            end: function () {
                to_page(currentNum);
            }
        });
    });

    //用户审核
    $(document).on("click", ".check_btn", function () {
        //1.弹出是否删除确认框
        var deptName = $(this).parents("tr").find("th:eq(2)").text();
        var id = $(this).attr("check_id");

        layer.confirm("进入审核 " + deptName, {
            btn: ['通过', '不通过'] //按钮
        }, function () {
            $.ajax({
                url: "${staticPath}/updateNaXin?id=" + id,
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
            $.ajax({
                url: "${staticPath}/updateNoNaXin?id=" + id,
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
        });
    });



    //显示系部
    $(function () {
        $.ajax({
            url: "${staticPath}/deptNames2",
            type: "GET",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.deptNames, function () {
                    var optionEle = $("<option></option>").append(this.deptname).attr("value", this.id);
                    optionEle.appendTo("#deptName select");
                });
            }
        });
    });
    //显示年级
    $(function () {
        $.ajax({
            url: "${staticPath}/jibies",
            type: "GET",
            dataType: "json",
            success: function (result) {
                $.each(result.extend.jibies, function () {
                    var optionEle = $("<option></option>").append(this.dengji).attr("value", this.jid);
                    optionEle.appendTo("#jibie select");
                });
            }
        });
    });
    //显示部门
    $("#deptName select").change(function () {
        $("#dept select ").empty();
        $("#classs select").empty();
        var deptNameId = $("#deptName select").val();
        var jiid = $("#jibie select").val();
        $.ajax({
            url: "${staticPath}/depts",
            type: "GET",
            data: {"deptNameId": deptNameId},
            dataType: "json",
            success: function (result) {
                $.each(result.extend.list, function () {
                    var optionEle = $("<option></option>").append(this.deptStuName).attr("value", this.id);
                    optionEle.appendTo("#dept select");
                });
            }
        });


    });

    //显示部门
    $("#jibie select").change(function () {

        $("#classs select").empty();
        var deptNameId = $("#deptName select").val();
        var jiid = $("#jibie select").val();
        $.ajax({
            url: "${staticPath}/classs",
            type: "GET",
            data: {"deptNameId": deptNameId, "jiid": jiid},
            dataType: "json",
            success: function (result) {
                $.each(result.extend.list, function () {
                    var optionEle = $("<option></option>").append(this.className).attr("value", this.id);
                    optionEle.appendTo("#classs select");
                });
            }
        });

    });
</script>
</html>




