var bookClass_manage_tool = null; 
$(function () { 
	initBookClassManageTool(); //建立BookClass管理对象
	bookClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#bookClass_manage").datagrid({
		url : 'BookClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "bookClassId",
		sortOrder : "desc",
		toolbar : "#bookClass_manage_tool",
		columns : [[
			{
				field : "bookClassId",
				title : "类别编号",
				width : 70,
			},
			{
				field : "bookClassName",
				title : "类别名称",
				width : 140,
			},
		]],
	});

	$("#bookClassEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#bookClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#bookClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#bookClassEditForm").form({
						    url:"BookClass/" + $("#bookClass_bookClassId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#bookClassEditForm").form("validate"))  {
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
			                        $("#bookClassEditDiv").dialog("close");
			                        bookClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#bookClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#bookClassEditDiv").dialog("close");
				$("#bookClassEditForm").form("reset"); 
			},
		}],
	});
});

function initBookClassManageTool() {
	bookClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#bookClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#bookClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#bookClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#bookClassQueryForm").form({
			    url:"BookClass/OutToExcel",
			});
			//提交表单
			$("#bookClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#bookClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var bookClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							bookClassIds.push(rows[i].bookClassId);
						}
						$.ajax({
							type : "POST",
							url : "BookClass/deletes",
							data : {
								bookClassIds : bookClassIds.join(","),
							},
							beforeSend : function () {
								$("#bookClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#bookClass_manage").datagrid("loaded");
									$("#bookClass_manage").datagrid("load");
									$("#bookClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#bookClass_manage").datagrid("loaded");
									$("#bookClass_manage").datagrid("load");
									$("#bookClass_manage").datagrid("unselectAll");
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
			var rows = $("#bookClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "BookClass/" + rows[0].bookClassId +  "/update",
					type : "get",
					data : {
						//bookClassId : rows[0].bookClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (bookClass, response, status) {
						$.messager.progress("close");
						if (bookClass) { 
							$("#bookClassEditDiv").dialog("open");
							$("#bookClass_bookClassId_edit").val(bookClass.bookClassId);
							$("#bookClass_bookClassId_edit").validatebox({
								required : true,
								missingMessage : "请输入类别编号",
								editable: false
							});
							$("#bookClass_bookClassName_edit").val(bookClass.bookClassName);
							$("#bookClass_bookClassName_edit").validatebox({
								required : true,
								missingMessage : "请输入类别名称",
							});
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
