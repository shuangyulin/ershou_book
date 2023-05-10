<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.BookSeek" %>
<%@ page import="com.chengxusheji.po.BookClass" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<BookSeek> bookSeekList = (List<BookSeek>)request.getAttribute("bookSeekList");
    //获取所有的bookClassObj信息
    List<BookClass> bookClassList = (List<BookClass>)request.getAttribute("bookClassList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String bookName = (String)request.getAttribute("bookName"); //图书名称查询关键字
    BookClass bookClassObj = (BookClass)request.getAttribute("bookClassObj");
    String publish = (String)request.getAttribute("publish"); //出版社查询关键字
    String author = (String)request.getAttribute("author"); //作者查询关键字
    String xjcd = (String)request.getAttribute("xjcd"); //新旧程度查询关键字
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //用户发布时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>求购查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>BookSeek/frontlist">求购信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>BookSeek/bookSeek_frontAdd.jsp" style="display:none;">添加求购</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<bookSeekList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		BookSeek bookSeek = bookSeekList.get(i); //获取到求购对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>BookSeek/<%=bookSeek.getSeekId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=bookSeek.getBookPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		求购id:<%=bookSeek.getSeekId() %>
			     	</div>
			     	<div class="field">
	            		图书名称:<%=bookSeek.getBookName() %>
			     	</div>
			     	<div class="field">
	            		图书类别:<%=bookSeek.getBookClassObj().getBookClassName() %>
			     	</div>
			     	<div class="field">
	            		出版社:<%=bookSeek.getPublish() %>
			     	</div>
			     	<div class="field">
	            		作者:<%=bookSeek.getAuthor() %>
			     	</div>
			     	<div class="field">
	            		求购价格:<%=bookSeek.getPrice() %>
			     	</div>
			     	<div class="field">
	            		新旧程度:<%=bookSeek.getXjcd() %>
			     	</div>
			     	<div class="field">
	            		发布用户:<%=bookSeek.getUserObj().getName() %>
			     	</div>
			     	<div class="field">
	            		用户发布时间:<%=bookSeek.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>BookSeek/<%=bookSeek.getSeekId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="bookSeekEdit('<%=bookSeek.getSeekId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="bookSeekDelete('<%=bookSeek.getSeekId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>求购查询</h1>
		</div>
		<form name="bookSeekQueryForm" id="bookSeekQueryForm" action="<%=basePath %>BookSeek/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="bookName">图书名称:</label>
				<input type="text" id="bookName" name="bookName" value="<%=bookName %>" class="form-control" placeholder="请输入图书名称">
			</div>
            <div class="form-group">
            	<label for="bookClassObj_bookClassId">图书类别：</label>
                <select id="bookClassObj_bookClassId" name="bookClassObj.bookClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(BookClass bookClassTemp:bookClassList) {
	 					String selected = "";
 					if(bookClassObj!=null && bookClassObj.getBookClassId()!=null && bookClassObj.getBookClassId().intValue()==bookClassTemp.getBookClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=bookClassTemp.getBookClassId() %>" <%=selected %>><%=bookClassTemp.getBookClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="publish">出版社:</label>
				<input type="text" id="publish" name="publish" value="<%=publish %>" class="form-control" placeholder="请输入出版社">
			</div>
			<div class="form-group">
				<label for="author">作者:</label>
				<input type="text" id="author" name="author" value="<%=author %>" class="form-control" placeholder="请输入作者">
			</div>
			<div class="form-group">
				<label for="xjcd">新旧程度:</label>
				<input type="text" id="xjcd" name="xjcd" value="<%=xjcd %>" class="form-control" placeholder="请输入新旧程度">
			</div>
            <div class="form-group">
            	<label for="userObj_user_name">发布用户：</label>
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
				<label for="addTime">用户发布时间:</label>
				<input type="text" id="addTime" name="addTime" value="<%=addTime %>" class="form-control" placeholder="请输入用户发布时间">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="bookSeekEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;求购信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="bookSeek.seekDesc" id="bookSeek_seekDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#bookSeekEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxBookSeekModify();">提交</button>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var bookSeek_seekDesc_edit = UE.getEditor('bookSeek_seekDesc_edit'); //求购说明编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.bookSeekQueryForm.currentPage.value = currentPage;
    document.bookSeekQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.bookSeekQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.bookSeekQueryForm.currentPage.value = pageValue;
    documentbookSeekQueryForm.submit();
}

/*弹出修改求购界面并初始化数据*/
function bookSeekEdit(seekId) {
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
				bookSeek_seekDesc_edit.setContent(bookSeek.seekDesc, false);
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
				$('#bookSeekEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除求购信息*/
function bookSeekDelete(seekId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "BookSeek/deletes",
			data : {
				seekIds : seekId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#bookSeekQueryForm").submit();
					//location.href= basePath + "BookSeek/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

