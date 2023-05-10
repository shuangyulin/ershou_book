<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookOrder" %>
<%@ page import="com.chengxusheji.po.BookSell" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的bookSellObj信息
    List<BookSell> bookSellList = (List<BookSell>)request.getAttribute("bookSellList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    BookOrder bookOrder = (BookOrder)request.getAttribute("bookOrder");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改图书订单信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">图书订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="bookOrderEditForm" id="bookOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="bookOrder_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="bookOrder_bookSellObj_sellId_edit" class="col-md-3 text-right">图书信息:</label>
		  	 <div class="col-md-9">
			    <select id="bookOrder_bookSellObj_sellId_edit" name="bookOrder.bookSellObj.sellId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_userObj_user_name_edit" class="col-md-3 text-right">意向用户:</label>
		  	 <div class="col-md-9">
			    <select id="bookOrder_userObj_user_name_edit" name="bookOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_price_edit" class="col-md-3 text-right">意向出价:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookOrder_price_edit" name="bookOrder.price" class="form-control" placeholder="请输入意向出价">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_orderMemo_edit" class="col-md-3 text-right">用户备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="bookOrder_orderMemo_edit" name="bookOrder.orderMemo" rows="8" class="form-control" placeholder="请输入用户备注"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookOrder_addTime_edit" class="col-md-3 text-right">下单时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookOrder_addTime_edit" name="bookOrder.addTime" class="form-control" placeholder="请输入下单时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBookOrderModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#bookOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改图书订单界面并初始化数据*/
function bookOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "BookOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (bookOrder, response, status) {
			if (bookOrder) {
				$("#bookOrder_orderId_edit").val(bookOrder.orderId);
				$.ajax({
					url: basePath + "BookSell/listAll",
					type: "get",
					success: function(bookSells,response,status) { 
						$("#bookOrder_bookSellObj_sellId_edit").empty();
						var html="";
		        		$(bookSells).each(function(i,bookSell){
		        			html += "<option value='" + bookSell.sellId + "'>" + bookSell.bookName + "</option>";
		        		});
		        		$("#bookOrder_bookSellObj_sellId_edit").html(html);
		        		$("#bookOrder_bookSellObj_sellId_edit").val(bookOrder.bookSellObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#bookOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#bookOrder_userObj_user_name_edit").html(html);
		        		$("#bookOrder_userObj_user_name_edit").val(bookOrder.userObjPri);
					}
				});
				$("#bookOrder_price_edit").val(bookOrder.price);
				$("#bookOrder_orderMemo_edit").val(bookOrder.orderMemo);
				$("#bookOrder_addTime_edit").val(bookOrder.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交图书订单信息表单给服务器端修改*/
function ajaxBookOrderModify() {
	$.ajax({
		url :  basePath + "BookOrder/" + $("#bookOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#bookOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#bookOrderQueryForm").submit();
            }else{
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
    bookOrderEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

