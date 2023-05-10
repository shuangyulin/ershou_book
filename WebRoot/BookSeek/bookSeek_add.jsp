<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSeek.css" />
<div id="bookSeekAddDiv">
	<form id="bookSeekAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书主图:</span>
			<span class="inputControl">
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_bookName" name="bookSeek.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_bookClassObj_bookClassId" name="bookSeek.bookClassObj.bookClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_publish" name="bookSeek.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_author" name="bookSeek.author" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求购价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_price" name="bookSeek.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">新旧程度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_xjcd" name="bookSeek.xjcd" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">求购说明:</span>
			<span class="inputControl">
				<script name="bookSeek.seekDesc" id="bookSeek_seekDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_userObj_user_name" name="bookSeek.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_addTime" name="bookSeek.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookSeekAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookSeekClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookSeek/js/bookSeek_add.js"></script> 
