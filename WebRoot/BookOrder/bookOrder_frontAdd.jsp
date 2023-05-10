<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookSell" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>图书订单添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>BookOrder/frontlist">图书订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#bookOrderAdd" aria-controls="bookOrderAdd" role="tab" data-toggle="tab">添加图书订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="bookOrderList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="bookOrderAdd"> 
				      	<form class="form-horizontal" name="bookOrderAddForm" id="bookOrderAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="bookOrder_bookSellObj_sellId" class="col-md-2 text-right">图书信息:</label>
						  	 <div class="col-md-8">
							    <select id="bookOrder_bookSellObj_sellId" name="bookOrder.bookSellObj.sellId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_userObj_user_name" class="col-md-2 text-right">意向用户:</label>
						  	 <div class="col-md-8">
							    <select id="bookOrder_userObj_user_name" name="bookOrder.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_price" class="col-md-2 text-right">意向出价:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="bookOrder_price" name="bookOrder.price" class="form-control" placeholder="请输入意向出价">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_orderMemo" class="col-md-2 text-right">用户备注:</label>
						  	 <div class="col-md-8">
							    <textarea id="bookOrder_orderMemo" name="bookOrder.orderMemo" rows="8" class="form-control" placeholder="请输入用户备注"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="bookOrder_addTime" class="col-md-2 text-right">下单时间:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="bookOrder_addTime" name="bookOrder.addTime" class="form-control" placeholder="请输入下单时间">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxBookOrderAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#bookOrderAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加图书订单信息
	function ajaxBookOrderAdd() { 
		//提交之前先验证表单
		$("#bookOrderAddForm").data('bootstrapValidator').validate();
		if(!$("#bookOrderAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BookOrder/add",
			dataType : "json" , 
			data: new FormData($("#bookOrderAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#bookOrderAddForm").find("input").val("");
					$("#bookOrderAddForm").find("textarea").val("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证图书订单添加表单字段
	$('#bookOrderAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"bookOrder.price": {
				validators: {
					notEmpty: {
						message: "意向出价不能为空",
					},
					numeric: {
						message: "意向出价不正确"
					}
				}
			},
		}
	}); 
	//初始化图书信息下拉框值 
	$.ajax({
		url: basePath + "BookSell/listAll",
		type: "get",
		success: function(bookSells,response,status) { 
			$("#bookOrder_bookSellObj_sellId").empty();
			var html="";
    		$(bookSells).each(function(i,bookSell){
    			html += "<option value='" + bookSell.sellId + "'>" + bookSell.bookName + "</option>";
    		});
    		$("#bookOrder_bookSellObj_sellId").html(html);
    	}
	});
	//初始化意向用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#bookOrder_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#bookOrder_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
