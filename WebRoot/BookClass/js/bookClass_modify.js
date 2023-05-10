$(function () {
	$.ajax({
		url : "BookClass/" + $("#bookClass_bookClassId_edit").val() + "/update",
		type : "get",
		data : {
			//bookClassId : $("#bookClass_bookClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookClass, response, status) {
			$.messager.progress("close");
			if (bookClass) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#bookClassModifyButton").click(function(){ 
		if ($("#bookClassEditForm").form("validate")) {
			$("#bookClassEditForm").form({
			    url:"BookClass/" +  $("#bookClass_bookClassId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#bookClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
