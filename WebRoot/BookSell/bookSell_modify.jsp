<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSell.css" />
<div id="bookSell_editDiv">
	<form id="bookSellEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">出售id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_sellId_edit" name="bookSell.sellId" value="<%=request.getParameter("sellId") %>" style="width:200px" />
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
				<script id="bookSell_sellDesc_edit" name="bookSell.sellDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="bookSellModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookSell/js/bookSell_modify.js"></script> 
