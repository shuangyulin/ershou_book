var bookSell_manage_tool = null; 
$(function () { 
	initBookSellManageTool(); //建立BookSell管理对象
	bookSell_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#bookSell_manage").datagrid({
		url : 'BookSell/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "sellId",
		sortOrder : "desc",
		toolbar : "#bookSell_manage_tool",
		columns : [[
			{
				field : "sellId",
				title : "出售id",
				width : 70,
			},
			{
				field : "bookPhoto",
				title : "图书主图",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "bookName",
				title : "图书名称",
				width : 140,
			},
			{
				field : "bookClassObj",
				title : "图书类别",
				width : 140,
			},
			{
				field : "publish",
				title : "出版社",
				width : 140,
			},
			{
				field : "author",
				title : "作者",
				width : 140,
			},
			{
				field : "sellPrice",
				title : "出售价格",
				width : 70,
			},
			{
				field : "xjcd",
				title : "新旧程度",
				width : 140,
			},
			{
				field : "userObj",
				title : "发布用户",
				width : 140,
			},
			{
				field : "addTime",
				title : "用户发布时间",
				width : 140,
			},
		]],
	});

	$("#bookSellEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#bookSellEditForm").form("validate")) {
					//验证表单 
					if(!$("#bookSellEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#bookSellEditForm").form({
						    url:"BookSell/" + $("#bookSell_sellId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#bookSellEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#bookSellEditDiv").dialog("close");
			                        bookSell_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#bookSellEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#bookSellEditDiv").dialog("close");
				$("#bookSellEditForm").form("reset"); 
			},
		}],
	});
});

function initBookSellManageTool() {
	bookSell_manage_tool = {
		init: function() {
			$.ajax({
				url : "BookClass/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#bookClassObj_bookClassId_query").combobox({ 
					    valueField:"bookClassId",
					    textField:"bookClassName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{bookClassId:0,bookClassName:"不限制"});
					$("#bookClassObj_bookClassId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#bookSell_manage").datagrid("reload");
		},
		redo : function () {
			$("#bookSell_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#bookSell_manage").datagrid("options").queryParams;
			queryParams["bookName"] = $("#bookName").val();
			queryParams["bookClassObj.bookClassId"] = $("#bookClassObj_bookClassId_query").combobox("getValue");
			queryParams["publish"] = $("#publish").val();
			queryParams["author"] = $("#author").val();
			queryParams["xjcd"] = $("#xjcd").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").val();
			$("#bookSell_manage").datagrid("options").queryParams=queryParams; 
			$("#bookSell_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#bookSellQueryForm").form({
			    url:"BookSell/OutToExcel",
			});
			//提交表单
			$("#bookSellQueryForm").submit();
		},
		remove : function () {
			var rows = $("#bookSell_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var sellIds = [];
						for (var i = 0; i < rows.length; i ++) {
							sellIds.push(rows[i].sellId);
						}
						$.ajax({
							type : "POST",
							url : "BookSell/deletes",
							data : {
								sellIds : sellIds.join(","),
							},
							beforeSend : function () {
								$("#bookSell_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#bookSell_manage").datagrid("loaded");
									$("#bookSell_manage").datagrid("load");
									$("#bookSell_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#bookSell_manage").datagrid("loaded");
									$("#bookSell_manage").datagrid("load");
									$("#bookSell_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#bookSell_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BookSell/" + rows[0].sellId +  "/update",
					type : "get",
					data : {
						//sellId : rows[0].sellId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (bookSell, response, status) {
						$.messager.progress("close");
						if (bookSell) { 
							$("#bookSellEditDiv").dialog("open");
							$("#bookSell_sellId_edit").val(bookSell.sellId);
							$("#bookSell_sellId_edit").validatebox({
								required : true,
								missingMessage : "请输入出售id",
								editable: false
							});
							$("#bookSell_bookPhoto").val(bookSell.bookPhoto);
							$("#bookSell_bookPhotoImg").attr("src", bookSell.bookPhoto);
							$("#bookSell_bookName_edit").val(bookSell.bookName);
							$("#bookSell_bookName_edit").validatebox({
								required : true,
								missingMessage : "请输入图书名称",
							});
							$("#bookSell_bookClassObj_bookClassId_edit").combobox({
								url:"BookClass/listAll",
							    valueField:"bookClassId",
							    textField:"bookClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#bookSell_bookClassObj_bookClassId_edit").combobox("select", bookSell.bookClassObjPri);
									//var data = $("#bookSell_bookClassObj_bookClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#bookSell_bookClassObj_bookClassId_edit").combobox("select", data[0].bookClassId);
						            //}
								}
							});
							$("#bookSell_publish_edit").val(bookSell.publish);
							$("#bookSell_publish_edit").validatebox({
								required : true,
								missingMessage : "请输入出版社",
							});
							$("#bookSell_author_edit").val(bookSell.author);
							$("#bookSell_author_edit").validatebox({
								required : true,
								missingMessage : "请输入作者",
							});
							$("#bookSell_sellPrice_edit").val(bookSell.sellPrice);
							$("#bookSell_sellPrice_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入出售价格",
								invalidMessage : "出售价格输入不对",
							});
							$("#bookSell_xjcd_edit").val(bookSell.xjcd);
							$("#bookSell_xjcd_edit").validatebox({
								required : true,
								missingMessage : "请输入新旧程度",
							});
							bookSell_sellDesc_editor.setContent(bookSell.sellDesc, false);
							$("#bookSell_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#bookSell_userObj_user_name_edit").combobox("select", bookSell.userObjPri);
									//var data = $("#bookSell_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#bookSell_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#bookSell_addTime_edit").val(bookSell.addTime);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
