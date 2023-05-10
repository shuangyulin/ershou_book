<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" />
<div id="bookOrder_editDiv">
	<form id="bookOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">图书信息:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookOrder_bookSellObj_sellId_edit" name="bookOrder.bookSellObj.sellId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">意向用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="bookOrder_userObj_user_name_edit" name="bookOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">意向出价:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_price_edit" name="bookOrder.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">用户备注:</span>
			<span class="inputControl">
				<textarea id="bookOrder_orderMemo_edit" name="bookOrder.orderMemo" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">下单时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_addTime_edit" name="bookOrder.addTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="bookOrderModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/BookOrder/js/bookOrder_modify.js"></script> 
