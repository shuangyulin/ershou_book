<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSeek.css" />
<div id="bookSeek_editDiv">
	<form id="bookSeekEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">求购id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSeek_seekId_edit" name="bookSeek.seekId" value="<%=request.getParameter("seekId") %>" style="width:200px" />
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
				<script id="bookSeek_seekDesc_edit" name="bookSeek.seekDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="bookSeekModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookSeek/js/bookSeek_modify.js"></script> 
