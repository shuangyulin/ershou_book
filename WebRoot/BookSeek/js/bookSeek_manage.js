var bookSeek_manage_tool = null; 
$(function () { 
	initBookSeekManageTool(); //建立BookSeek管理对象
	bookSeek_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#bookSeek_manage").datagrid({
		url : 'BookSeek/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "seekId",
		sortOrder : "desc",
		toolbar : "#bookSeek_manage_tool",
		columns : [[
			{
				field : "seekId",
				title : "求购id",
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
				field : "price",
				title : "求购价格",
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

	$("#bookSeekEditDiv").dialog({
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
				if ($("#bookSeekEditForm").form("validate")) {
					//验证表单 
					if(!$("#bookSeekEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#bookSeekEditForm").form({
						    url:"BookSeek/" + $("#bookSeek_seekId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#bookSeekEditForm").form("validate"))  {
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
			                        $("#bookSeekEditDiv").dialog("close");
			                        bookSeek_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#bookSeekEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#bookSeekEditDiv").dialog("close");
				$("#bookSeekEditForm").form("reset"); 
			},
		}],
	});
});

function initBookSeekManageTool() {
	bookSeek_manage_tool = {
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
			$("#bookSeek_manage").datagrid("reload");
		},
		redo : function () {
			$("#bookSeek_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#bookSeek_manage").datagrid("options").queryParams;
			queryParams["bookName"] = $("#bookName").val();
			queryParams["bookClassObj.bookClassId"] = $("#bookClassObj_bookClassId_query").combobox("getValue");
			queryParams["publish"] = $("#publish").val();
			queryParams["author"] = $("#author").val();
			queryParams["xjcd"] = $("#xjcd").val();
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").val();
			$("#bookSeek_manage").datagrid("options").queryParams=queryParams; 
			$("#bookSeek_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#bookSeekQueryForm").form({
			    url:"BookSeek/OutToExcel",
			});
			//提交表单
			$("#bookSeekQueryForm").submit();
		},
		remove : function () {
			var rows = $("#bookSeek_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var seekIds = [];
						for (var i = 0; i < rows.length; i ++) {
							seekIds.push(rows[i].seekId);
						}
						$.ajax({
							type : "POST",
							url : "BookSeek/deletes",
							data : {
								seekIds : seekIds.join(","),
							},
							beforeSend : function () {
								$("#bookSeek_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#bookSeek_manage").datagrid("loaded");
									$("#bookSeek_manage").datagrid("load");
									$("#bookSeek_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#bookSeek_manage").datagrid("loaded");
									$("#bookSeek_manage").datagrid("load");
									$("#bookSeek_manage").datagrid("unselectAll");
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
			var rows = $("#bookSeek_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BookSeek/" + rows[0].seekId +  "/update",
					type : "get",
					data : {
						//seekId : rows[0].seekId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (bookSeek, response, status) {
						$.messager.progress("close");
						if (bookSeek) { 
							$("#bookSeekEditDiv").dialog("open");
							$("#bookSeek_seekId_edit").val(bookSeek.seekId);
							$("#bookSeek_seekId_edit").validatebox({
								required : true,
								missingMessage : "请输入求购id",
								editable: false
							});
							$("#bookSeek_bookPhoto").val(bookSeek.bookPhoto);
							$("#bookSeek_bookPhotoImg").attr("src", bookSeek.bookPhoto);
							$("#bookSeek_bookName_edit").val(bookSeek.bookName);
							$("#bookSeek_bookName_edit").validatebox({
								required : true,
								missingMessage : "请输入图书名称",
							});
							$("#bookSeek_bookClassObj_bookClassId_edit").combobox({
								url:"BookClass/listAll",
							    valueField:"bookClassId",
							    textField:"bookClassName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#bookSeek_bookClassObj_bookClassId_edit").combobox("select", bookSeek.bookClassObjPri);
									//var data = $("#bookSeek_bookClassObj_bookClassId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#bookSeek_bookClassObj_bookClassId_edit").combobox("select", data[0].bookClassId);
						            //}
								}
							});
							$("#bookSeek_publish_edit").val(bookSeek.publish);
							$("#bookSeek_publish_edit").validatebox({
								required : true,
								missingMessage : "请输入出版社",
							});
							$("#bookSeek_author_edit").val(bookSeek.author);
							$("#bookSeek_author_edit").validatebox({
								required : true,
								missingMessage : "请输入作者",
							});
							$("#bookSeek_price_edit").val(bookSeek.price);
							$("#bookSeek_price_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入求购价格",
								invalidMessage : "求购价格输入不对",
							});
							$("#bookSeek_xjcd_edit").val(bookSeek.xjcd);
							$("#bookSeek_xjcd_edit").validatebox({
								required : true,
								missingMessage : "请输入新旧程度",
							});
							bookSeek_seekDesc_editor.setContent(bookSeek.seekDesc, false);
							$("#bookSeek_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#bookSeek_userObj_user_name_edit").combobox("select", bookSeek.userObjPri);
									//var data = $("#bookSeek_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#bookSeek_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#bookSeek_addTime_edit").val(bookSeek.addTime);
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
