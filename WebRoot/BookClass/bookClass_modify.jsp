<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookClass.css" />
<div id="bookClass_editDiv">
	<form id="bookClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">类别编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookClass_bookClassId_edit" name="bookClass.bookClassId" value="<%=request.getParameter("bookClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookClass_bookClassName_edit" name="bookClass.bookClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookClass/js/bookClass_modify.js"></script> 
