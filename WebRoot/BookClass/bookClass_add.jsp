<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookClass.css" />
<div id="bookClassAddDiv">
	<form id="bookClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookClass_bookClassName" name="bookClass.bookClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookClass/js/bookClass_add.js"></script> 
