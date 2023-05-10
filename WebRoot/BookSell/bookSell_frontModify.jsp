<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookSell" %>
<%@ page import="com.chengxusheji.po.BookClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的bookClassObj信息
    List<BookClass> bookClassList = (List<BookClass>)request.getAttribute("bookClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    BookSell bookSell = (BookSell)request.getAttribute("bookSell");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改图书出售信息</TITLE>
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
  		<li class="active">图书出售信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="bookSellEditForm" id="bookSellEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="bookSell_sellId_edit" class="col-md-3 text-right">出售id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="bookSell_sellId_edit" name="bookSell.sellId" class="form-control" placeholder="请输入出售id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="bookSell_bookPhoto_edit" class="col-md-3 text-right">图书主图:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="bookSell_bookPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="bookSell_bookPhoto" name="bookSell.bookPhoto"/>
			    <input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_bookName_edit" class="col-md-3 text-right">图书名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_bookName_edit" name="bookSell.bookName" class="form-control" placeholder="请输入图书名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_bookClassObj_bookClassId_edit" class="col-md-3 text-right">图书类别:</label>
		  	 <div class="col-md-9">
			    <select id="bookSell_bookClassObj_bookClassId_edit" name="bookSell.bookClassObj.bookClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_publish_edit" class="col-md-3 text-right">出版社:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_publish_edit" name="bookSell.publish" class="form-control" placeholder="请输入出版社">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_author_edit" class="col-md-3 text-right">作者:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_author_edit" name="bookSell.author" class="form-control" placeholder="请输入作者">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_sellPrice_edit" class="col-md-3 text-right">出售价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_sellPrice_edit" name="bookSell.sellPrice" class="form-control" placeholder="请输入出售价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_xjcd_edit" class="col-md-3 text-right">新旧程度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_xjcd_edit" name="bookSell.xjcd" class="form-control" placeholder="请输入新旧程度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_sellDesc_edit" class="col-md-3 text-right">出售说明:</label>
		  	 <div class="col-md-9">
			    <script name="bookSell.sellDesc" id="bookSell_sellDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_userObj_user_name_edit" class="col-md-3 text-right">发布用户:</label>
		  	 <div class="col-md-9">
			    <select id="bookSell_userObj_user_name_edit" name="bookSell.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSell_addTime_edit" class="col-md-3 text-right">用户发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSell_addTime_edit" name="bookSell.addTime" class="form-control" placeholder="请输入用户发布时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBookSellModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#bookSellEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var bookSell_sellDesc_editor = UE.getEditor('bookSell_sellDesc_edit'); //出售说明编辑框
var basePath = "<%=basePath%>";
/*弹出修改图书出售界面并初始化数据*/
function bookSellEdit(sellId) {
  bookSell_sellDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(sellId);
  });
}
 function ajaxModifyQuery(sellId) {
	$.ajax({
		url :  basePath + "BookSell/" + sellId + "/update",
		type : "get",
		dataType: "json",
		success : function (bookSell, response, status) {
			if (bookSell) {
				$("#bookSell_sellId_edit").val(bookSell.sellId);
				$("#bookSell_bookPhoto").val(bookSell.bookPhoto);
				$("#bookSell_bookPhotoImg").attr("src", basePath +　bookSell.bookPhoto);
				$("#bookSell_bookName_edit").val(bookSell.bookName);
				$.ajax({
					url: basePath + "BookClass/listAll",
					type: "get",
					success: function(bookClasss,response,status) { 
						$("#bookSell_bookClassObj_bookClassId_edit").empty();
						var html="";
		        		$(bookClasss).each(function(i,bookClass){
		        			html += "<option value='" + bookClass.bookClassId + "'>" + bookClass.bookClassName + "</option>";
		        		});
		        		$("#bookSell_bookClassObj_bookClassId_edit").html(html);
		        		$("#bookSell_bookClassObj_bookClassId_edit").val(bookSell.bookClassObjPri);
					}
				});
				$("#bookSell_publish_edit").val(bookSell.publish);
				$("#bookSell_author_edit").val(bookSell.author);
				$("#bookSell_sellPrice_edit").val(bookSell.sellPrice);
				$("#bookSell_xjcd_edit").val(bookSell.xjcd);
				bookSell_sellDesc_editor.setContent(bookSell.sellDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#bookSell_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#bookSell_userObj_user_name_edit").html(html);
		        		$("#bookSell_userObj_user_name_edit").val(bookSell.userObjPri);
					}
				});
				$("#bookSell_addTime_edit").val(bookSell.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交图书出售信息表单给服务器端修改*/
function ajaxBookSellModify() {
	$.ajax({
		url :  basePath + "BookSell/" + $("#bookSell_sellId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#bookSellEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#bookSellQueryForm").submit();
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
    bookSellEdit("<%=request.getParameter("sellId")%>");
 })
 </script> 
</body>
</html>

