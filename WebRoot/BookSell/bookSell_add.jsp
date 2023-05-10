<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookSell.css" />
<div id="bookSellAddDiv">
	<form id="bookSellAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书主图:</span>
			<span class="inputControl">
				<input id="bookPhotoFile" name="bookPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">图书名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_bookName" name="bookSell.bookName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">图书类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_bookClassObj_bookClassId" name="bookSell.bookClassObj.bookClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">出版社:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_publish" name="bookSell.publish" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">作者:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_author" name="bookSell.author" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出售价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_sellPrice" name="bookSell.sellPrice" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">新旧程度:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_xjcd" name="bookSell.xjcd" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">出售说明:</span>
			<span class="inputControl">
				<script name="bookSell.sellDesc" id="bookSell_sellDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">发布用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_userObj_user_name" name="bookSell.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">用户发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookSell_addTime" name="bookSell.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookSellAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookSellClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookSell/js/bookSell_add.js"></script> 
