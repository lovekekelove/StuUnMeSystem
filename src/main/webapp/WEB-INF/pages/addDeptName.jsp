
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加系部</title>
</head>
<body style="width: 90%">

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加系部</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">


                    <div class="form-group">
                        <label for="deptName" class="col-sm-2 control-label">系部名称:</label>
                        <div class="col-sm-10">
                            <input type="text" name="deptName" class="form-control" id="deptName" placeholder="请输入您要添加的系部名称">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" onclick="add()" class="btn btn-primary" id="emp_save_btn">Save</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!--标题-->
    <div class="row">
        <div class="col-md-6"></div>
        <div class="col-md-5">
            <h2>系部信息</h2>
        </div>
    </div>
    <!--按钮-->
    <div class="row">
        <div class="pull-right">
            <button class="btn btn-success" id="addEmp_modal_btn">新增</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div class="col-md-12 ">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th></th>
                    <th>ID</th>
                    <th>DeptName</th>
                    <th>Delete</th>
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

    var totalRecord,currentNum;
    function add() {
        var deptName=$("#deptName").val();
        if(deptName == ''){
            layer.msg("名称不能为空！",{anim:6}) ;
            return false;
        }
        $.ajax({
            url:"${staticPath}/addDeptName",
            type:"GET",
            dataType: "json",
            data:{"deptName":deptName},
            success:function (result) {
              if(result.code==100){
                  layer.load(0,{time:2000});
                  setTimeout(function (args) {
                      layer.msg("添加成功！");
                  },2000);
                     setTimeout(function () {
                         $('#empAdd').modal('hide');
                         to_page(totalRecord);
                     },3000);
              }else {
                  layer.load(0,{time:2000});
                  setTimeout(function (args) {
                      layer.msg("添加失败！系部存在！");
                  },2000);
                  setTimeout(function () {
                      $('#empAdd').modal('hide');
                      to_page(1);
                  },3000);
              }
            }
        });
    }

    $(function () {
        to_page(1);
    });

    //分页
    function to_page(pn) {
        $.ajax({
            url:"${staticPath}/deptNames",
            data:"pn="+pn,
            type:"GET",
            dataType:"json",
            success:function(result){
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
        var deptNames=result.extend.pageInfo.list;
        $.each(deptNames,function (index,item) {
            var deptTd1 = $("<th ></th>");
            var deptTd=$("<th ></th>").append(item.id);
            var deptNameTd=$("<th ></th>").append(item.deptname);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            //为删除按钮添加一个自定义属性，来表示员工的ID
            delBtn.attr("del_id",item.id);
            var btnTd=$("<th ></th>").append(delBtn);
            //append()方法执行完以后还会返回原来的元素
            $("<tr></tr>").append(deptTd1)
                .append(deptTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //显示分页信息
    function build_page_(result) {
        //清空
        $("#page_info").empty();
        $("#page_info").append($("<h4></h4>").append("当前第<mark>"+result.extend.pageInfo.pageNum+"</mark>页，" +
            "总共<mark>"+result.extend.pageInfo.pages+"</mark>页，" +
            "总共<mark>"+result.extend.pageInfo.total+"</mark>记录"));
        totalRecord=result.extend.pageInfo.total;
        currentNum=result.extend.pageInfo.pageNum;
    }
    //显示分页条
    function build_page_nav(result) {
        //清空
        $("#age_nav").empty();

        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));

        if(result.extend.pageInfo.hasPreviousPage == false){
            prePageLi.addClass("disabled");
            firstPageLi.addClass("disabled");
        }else{
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numPageLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
                numPageLi.addClass("active");
            }
            numPageLi.click(function(){
                to_page(item);
            });
            ul.append(numPageLi);
        });

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));

        if(result.extend.pageInfo.hasNextPage == false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
        }

        ul.append(nextPageLi).append(lastPageLi);
        var nvaEle=$("<nva></nva>").append(ul);
        nvaEle.appendTo("#age_nav");
    }

    //弹出模态框
    $("#addEmp_modal_btn").click(function(){
        //清除表单数据和样式
        reset_form("#empAdd form");
        //弹出模态框
        $("#empAdd").modal({
            backdrop:"static"
        });
    });
    //清除表单数据和样式
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }

    $(document).on("click",".del_btn",function(){
        //1.弹出是否删除确认框
        var deptName=$(this).parents("tr").find("th:eq(1)").text();
        var id=$(this).attr("del_id");

        layer.confirm("确认删除用户  "+deptName+" 吗？", {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.ajax({
            url:"${staticPath}/delDeptName?id="+id,
            type:"get",
            dataType:"json",
            success:function (result) {
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
        }, function(){

        });
    });


</script>
</html>

