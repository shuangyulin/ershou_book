<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSeek.css" /> 

<div id="bookSeek_manage"></div>
<div id="bookSeek_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="bookSeek_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="bookSeek_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="bookSeek_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="bookSeek_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="bookSeek_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="bookSeekQueryForm" method="post">
			图书名称：<input type="text" class="textbox" id="bookName" name="bookName" style="width:110px" />
			图书类别：<input class="textbox" type="text" id="bookClassObj_bookClassId_query" name="bookClassObj.bookClassId" style="width: auto"/>
			出版社：<input type="text" class="textbox" id="publish" name="publish" style="width:110px" />
			作者：<input type="text" class="textbox" id="author" name="author" style="width:110px" />
			新旧程度：<input type="text" class="textbox" id="xjcd" name="xjcd" style="width:110px" />
			发布用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			用户发布时间：<input type="text" class="textbox" id="addTime" name="addTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="bookSeek_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="bookSeekEditDiv">
	<form id="bookSeekEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">求购id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_seekId_edit" name="bookSeek.seekId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">图书主图:</span>
			<span class="inputControl">
				<img id="bookSeek_bookPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="bookSeek_bookPhoto" name="bookSeek.bookPhoto"/>
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_bookName_edit" name="bookSeek.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookSeek_bookClassObj_bookClassId_edit" name="bookSeek.bookClassObj.bookClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_publish_edit" name="bookSeek.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_author_edit" name="bookSeek.author" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求购价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_price_edit" name="bookSeek.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">新旧程度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_xjcd_edit" name="bookSeek.xjcd" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求购说明:</span>
			<span class="inputControl">
				<script name="bookSeek.seekDesc" id="bookSeek_seekDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookSeek_userObj_user_name_edit" name="bookSeek.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_addTime_edit" name="bookSeek.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var bookSeek_seekDesc_editor = UE.getEditor('bookSeek_seekDesc_edit'); //求购说明编辑器
</script>
<script type="text/javascript" src="BookSeek/js/bookSeek_manage.js"></script> 
