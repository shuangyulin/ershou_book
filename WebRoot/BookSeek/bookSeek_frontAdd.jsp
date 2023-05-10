<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookClass" %>
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
<title>求购添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>BookSeek/frontlist">求购管理</a></li>
  			<li class="active">添加求购</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="bookSeekAddForm" id="bookSeekAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="bookSeek_bookPhoto" class="col-md-2 text-right">图书主图:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="bookSeek_bookPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="bookSeek_bookPhoto" name="bookSeek.bookPhoto"/>
					    <input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_bookName" class="col-md-2 text-right">图书名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_bookName" name="bookSeek.bookName" class="form-control" placeholder="请输入图书名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_bookClassObj_bookClassId" class="col-md-2 text-right">图书类别:</label>
				  	 <div class="col-md-8">
					    <select id="bookSeek_bookClassObj_bookClassId" name="bookSeek.bookClassObj.bookClassId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_publish" class="col-md-2 text-right">出版社:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_publish" name="bookSeek.publish" class="form-control" placeholder="请输入出版社">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_author" class="col-md-2 text-right">作者:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_author" name="bookSeek.author" class="form-control" placeholder="请输入作者">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_price" class="col-md-2 text-right">求购价格:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_price" name="bookSeek.price" class="form-control" placeholder="请输入求购价格">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_xjcd" class="col-md-2 text-right">新旧程度:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_xjcd" name="bookSeek.xjcd" class="form-control" placeholder="请输入新旧程度">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_seekDesc" class="col-md-2 text-right">求购说明:</label>
				  	 <div class="col-md-8">
							    <textarea name="bookSeek.seekDesc" id="bookSeek_seekDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_userObj_user_name" class="col-md-2 text-right">发布用户:</label>
				  	 <div class="col-md-8">
					    <select id="bookSeek_userObj_user_name" name="bookSeek.userObj.user_name" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="bookSeek_addTime" class="col-md-2 text-right">用户发布时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="bookSeek_addTime" name="bookSeek.addTime" class="form-control" placeholder="请输入用户发布时间">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxBookSeekAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#bookSeekAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var bookSeek_seekDesc_editor = UE.getEditor('bookSeek_seekDesc'); //求购说明编辑器
var basePath = "<%=basePath%>";
	//提交添加求购信息
	function ajaxBookSeekAdd() { 
		//提交之前先验证表单
		$("#bookSeekAddForm").data('bootstrapValidator').validate();
		if(!$("#bookSeekAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(bookSeek_seekDesc_editor.getContent() == "") {
			alert('求购说明不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "BookSeek/add",
			dataType : "json" , 
			data: new FormData($("#bookSeekAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#bookSeekAddForm").find("input").val("");
					$("#bookSeekAddForm").find("textarea").val("");
					bookSeek_seekDesc_editor.setContent("");
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
	//验证求购添加表单字段
	$('#bookSeekAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"bookSeek.bookName": {
				validators: {
					notEmpty: {
						message: "图书名称不能为空",
					}
				}
			},
			"bookSeek.publish": {
				validators: {
					notEmpty: {
						message: "出版社不能为空",
					}
				}
			},
			"bookSeek.author": {
				validators: {
					notEmpty: {
						message: "作者不能为空",
					}
				}
			},
			"bookSeek.price": {
				validators: {
					notEmpty: {
						message: "求购价格不能为空",
					},
					numeric: {
						message: "求购价格不正确"
					}
				}
			},
			"bookSeek.xjcd": {
				validators: {
					notEmpty: {
						message: "新旧程度不能为空",
					}
				}
			},
		}
	}); 
	//初始化图书类别下拉框值 
	$.ajax({
		url: basePath + "BookClass/listAll",
		type: "get",
		success: function(bookClasss,response,status) { 
			$("#bookSeek_bookClassObj_bookClassId").empty();
			var html="";
    		$(bookClasss).each(function(i,bookClass){
    			html += "<option value='" + bookClass.bookClassId + "'>" + bookClass.bookClassName + "</option>";
    		});
    		$("#bookSeek_bookClassObj_bookClassId").html(html);
    	}
	});
	//初始化发布用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#bookSeek_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#bookSeek_userObj_user_name").html(html);
    	}
	});
})
</script>
</body>
</html>
