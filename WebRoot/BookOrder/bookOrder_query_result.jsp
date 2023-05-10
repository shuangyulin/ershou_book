<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookOrder.css" /> 

<div id="bookOrder_manage"></div>
<div id="bookOrder_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="bookOrder_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="bookOrder_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="bookOrder_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="bookOrder_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="bookOrder_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="bookOrderQueryForm" method="post">
			图书信息：<input class="textbox" type="text" id="bookSellObj_sellId_query" name="bookSellObj.sellId" style="width: auto"/>
			意向用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			下单时间：<input type="text" class="textbox" id="addTime" name="addTime" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="bookOrder_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="bookOrderEditDiv">
	<form id="bookOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="bookOrder_orderId_edit" name="bookOrder.orderId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="BookOrder/js/bookOrder_manage.js"></script> 
