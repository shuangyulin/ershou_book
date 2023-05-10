<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookOrder" %>
<%@ page import="com.chengxusheji.po.BookSell" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<BookOrder> bookOrderList = (List<BookOrder>)request.getAttribute("bookOrderList");
    //获取所有的bookSellObj信息
    List<BookSell> bookSellList = (List<BookSell>)request.getAttribute("bookSellList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    BookSell bookSellObj = (BookSell)request.getAttribute("bookSellObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //下单时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>图书订单查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#bookOrderListPanel" aria-controls="bookOrderListPanel" role="tab" data-toggle="tab">图书订单列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>BookOrder/bookOrder_frontAdd.jsp" style="display:none;">添加图书订单</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="bookOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单id</td><td>图书信息</td><td>意向用户</td><td>意向出价</td><td>用户备注</td><td>下单时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<bookOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		BookOrder bookOrder = bookOrderList.get(i); //获取到图书订单对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=bookOrder.getOrderId() %></td>
 											<td><%=bookOrder.getBookSellObj().getBookName() %></td>
 											<td><%=bookOrder.getUserObj().getName() %></td>
 											<td><%=bookOrder.getPrice() %></td>
 											<td><%=bookOrder.getOrderMemo() %></td>
 											<td><%=bookOrder.getAddTime() %></td>
 											<td>
 												<a href="<%=basePath  %>BookOrder/<%=bookOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="bookOrderEdit('<%=bookOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="bookOrderDelete('<%=bookOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>图书订单查询</h1>
		</div>
		<form name="bookOrderQueryForm" id="bookOrderQueryForm" action="<%=basePath %>BookOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="bookSellObj_sellId">图书信息：</label>
                <select id="bookSellObj_sellId" name="bookSellObj.sellId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(BookSell bookSellTemp:bookSellList) {
	 					String selected = "";
 					if(bookSellObj!=null && bookSellObj.getSellId()!=null && bookSellObj.getSellId().intValue()==bookSellTemp.getSellId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=bookSellTemp.getSellId() %>" <%=selected %>><%=bookSellTemp.getBookName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">意向用户：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">下单时间:</label>
				<input type="text" id="addTime" name="addTime" value="<%=addTime %>" class="form-control" placeholder="请输入下单时间">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="bookOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;图书订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#bookOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBookOrderModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.bookOrderQueryForm.currentPage.value = currentPage;
    document.bookOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.bookOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.bookOrderQueryForm.currentPage.value = pageValue;
    documentbookOrderQueryForm.submit();
}

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
				$('#bookOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除图书订单信息*/
function bookOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "BookOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#bookOrderQueryForm").submit();
					//location.href= basePath + "BookOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

