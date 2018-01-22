
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../common/base.jsp" %>
<%@ include file="../../common/commons.jsp" %>
<html>
<head>
    <title>添加班级</title>
</head>
<body style="width: 90%">
<div class="tab-pane" id="updata_id">
    <form class="form-horizontal">
        <div class="form-group">
        </div>
        <div class="form-group">
            <label  class="col-sm-5 control-label">年级:</label>
            <div class="col-sm-3">
                <input type="text"  name="dengji"    class="form-control" id="dengji" placeholder="请输入添加的年级——例 18">
                <span  class="help-block"></span>
            </div>
        </div>


    </form>
    <div class="form-group">
        <div class="col-sm-offset-6">
            <button onclick="add()" class="btn btn-success" id="add-btn">确认</button>
        </div>
    </div>

</div>
</body>
<script>
    function add() {
        var dengji=$("#dengji").val();
        if(dengji == ''){
            layer.msg("名称不能为空！",{anim:6}) ;
            return false;
        }

        $.ajax({
            url:"${staticPath}/addJiBie",
            type:"GET",
            dataType: "json",
            data:{"dengji":dengji},
            success:function (result) {
                if(result.code==100){
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("添加成功！");
                    },2000);
                }else {
                    layer.load(0,{time:2000});
                    setTimeout(function (args) {
                        layer.msg("添加失败！部门存在！");
                    },2000);
                }
                setTimeout(function () {
                    window.location.href="/addJibieJsp";
                },3000);
            }
        });
    }


</script>
</html>



