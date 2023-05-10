<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSell.css" /> 

<div id="bookSell_manage"></div>
<div id="bookSell_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="bookSell_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="bookSell_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="bookSell_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="bookSell_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="bookSell_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="bookSellQueryForm" method="post">
			图书名称：<input type="text" class="textbox" id="bookName" name="bookName" style="width:110px" />
			图书类别：<input class="textbox" type="text" id="bookClassObj_bookClassId_query" name="bookClassObj.bookClassId" style="width: auto"/>
			出版社：<input type="text" class="textbox" id="publish" name="publish" style="width:110px" />
			作者：<input type="text" class="textbox" id="author" name="author" style="width:110px" />
			新旧程度：<input type="text" class="textbox" id="xjcd" name="xjcd" style="width:110px" />
			发布用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			用户发布时间：<input type="text" class="textbox" id="addTime" name="addTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="bookSell_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="bookSellEditDiv">
	<form id="bookSellEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出售id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_sellId_edit" name="bookSell.sellId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">图书主图:</span>
			<span class="inputControl">
				<img id="bookSell_bookPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="bookSell_bookPhoto" name="bookSell.bookPhoto"/>
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_bookName_edit" name="bookSell.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookSell_bookClassObj_bookClassId_edit" name="bookSell.bookClassObj.bookClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_publish_edit" name="bookSell.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_author_edit" name="bookSell.author" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出售价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_sellPrice_edit" name="bookSell.sellPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">新旧程度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_xjcd_edit" name="bookSell.xjcd" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出售说明:</span>
			<span class="inputControl">
				<script name="bookSell.sellDesc" id="bookSell_sellDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookSell_userObj_user_name_edit" name="bookSell.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_addTime_edit" name="bookSell.addTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var bookSell_sellDesc_editor = UE.getEditor('bookSell_sellDesc_edit'); //出售说明编辑器
</script>
<script type="text/javascript" src="BookSell/js/bookSell_manage.js"></script> 
