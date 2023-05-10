<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookSeek" %>
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
    BookSeek bookSeek = (BookSeek)request.getAttribute("bookSeek");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改求购信息</TITLE>
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
  		<li class="active">求购信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="bookSeekEditForm" id="bookSeekEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="bookSeek_seekId_edit" class="col-md-3 text-right">求购id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="bookSeek_seekId_edit" name="bookSeek.seekId" class="form-control" placeholder="请输入求购id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="bookSeek_bookPhoto_edit" class="col-md-3 text-right">图书主图:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="bookSeek_bookPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="bookSeek_bookPhoto" name="bookSeek.bookPhoto"/>
			    <input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_bookName_edit" class="col-md-3 text-right">图书名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_bookName_edit" name="bookSeek.bookName" class="form-control" placeholder="请输入图书名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_bookClassObj_bookClassId_edit" class="col-md-3 text-right">图书类别:</label>
		  	 <div class="col-md-9">
			    <select id="bookSeek_bookClassObj_bookClassId_edit" name="bookSeek.bookClassObj.bookClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_publish_edit" class="col-md-3 text-right">出版社:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_publish_edit" name="bookSeek.publish" class="form-control" placeholder="请输入出版社">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_author_edit" class="col-md-3 text-right">作者:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_author_edit" name="bookSeek.author" class="form-control" placeholder="请输入作者">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_price_edit" class="col-md-3 text-right">求购价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_price_edit" name="bookSeek.price" class="form-control" placeholder="请输入求购价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_xjcd_edit" class="col-md-3 text-right">新旧程度:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_xjcd_edit" name="bookSeek.xjcd" class="form-control" placeholder="请输入新旧程度">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_seekDesc_edit" class="col-md-3 text-right">求购说明:</label>
		  	 <div class="col-md-9">
			    <script name="bookSeek.seekDesc" id="bookSeek_seekDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_userObj_user_name_edit" class="col-md-3 text-right">发布用户:</label>
		  	 <div class="col-md-9">
			    <select id="bookSeek_userObj_user_name_edit" name="bookSeek.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="bookSeek_addTime_edit" class="col-md-3 text-right">用户发布时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="bookSeek_addTime_edit" name="bookSeek.addTime" class="form-control" placeholder="请输入用户发布时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxBookSeekModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#bookSeekEditForm .form-group {margin-bottom:5px;}  </style>
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
var bookSeek_seekDesc_editor = UE.getEditor('bookSeek_seekDesc_edit'); //求购说明编辑框
var basePath = "<%=basePath%>";
/*弹出修改求购界面并初始化数据*/
function bookSeekEdit(seekId) {
  bookSeek_seekDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(seekId);
  });
}
 function ajaxModifyQuery(seekId) {
	$.ajax({
		url :  basePath + "BookSeek/" + seekId + "/update",
		type : "get",
		dataType: "json",
		success : function (bookSeek, response, status) {
			if (bookSeek) {
				$("#bookSeek_seekId_edit").val(bookSeek.seekId);
				$("#bookSeek_bookPhoto").val(bookSeek.bookPhoto);
				$("#bookSeek_bookPhotoImg").attr("src", basePath +　bookSeek.bookPhoto);
				$("#bookSeek_bookName_edit").val(bookSeek.bookName);
				$.ajax({
					url: basePath + "BookClass/listAll",
					type: "get",
					success: function(bookClasss,response,status) { 
						$("#bookSeek_bookClassObj_bookClassId_edit").empty();
						var html="";
		        		$(bookClasss).each(function(i,bookClass){
		        			html += "<option value='" + bookClass.bookClassId + "'>" + bookClass.bookClassName + "</option>";
		        		});
		        		$("#bookSeek_bookClassObj_bookClassId_edit").html(html);
		        		$("#bookSeek_bookClassObj_bookClassId_edit").val(bookSeek.bookClassObjPri);
					}
				});
				$("#bookSeek_publish_edit").val(bookSeek.publish);
				$("#bookSeek_author_edit").val(bookSeek.author);
				$("#bookSeek_price_edit").val(bookSeek.price);
				$("#bookSeek_xjcd_edit").val(bookSeek.xjcd);
				bookSeek_seekDesc_editor.setContent(bookSeek.seekDesc, false);
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#bookSeek_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#bookSeek_userObj_user_name_edit").html(html);
		        		$("#bookSeek_userObj_user_name_edit").val(bookSeek.userObjPri);
					}
				});
				$("#bookSeek_addTime_edit").val(bookSeek.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交求购信息表单给服务器端修改*/
function ajaxBookSeekModify() {
	$.ajax({
		url :  basePath + "BookSeek/" + $("#bookSeek_seekId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#bookSeekEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#bookSeekQueryForm").submit();
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
    bookSeekEdit("<%=request.getParameter("seekId")%>");
 })
 </script> 
</body>
</html>

