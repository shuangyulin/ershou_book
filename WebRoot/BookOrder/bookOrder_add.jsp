<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" />
<div id="bookOrderAddDiv">
	<form id="bookOrderAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">图书信息:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_bookSellObj_sellId" name="bookOrder.bookSellObj.sellId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">意向用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_userObj_user_name" name="bookOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">意向出价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_price" name="bookOrder.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">用户备注:</span>
			<span class="inputControl">
				<textarea id="bookOrder_orderMemo" name="bookOrder.orderMemo" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_addTime" name="bookOrder.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookOrderAddButton" class="easyui-linkbutton">添加</a>
			<a id="bookOrderClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookOrder/js/bookOrder_add.js"></script> 
