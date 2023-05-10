$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('bookSell_sellDesc_edit');
	var bookSell_sellDesc_edit = UE.getEditor('bookSell_sellDesc_edit'); //出售说明编辑器
	bookSell_sellDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "BookSell/" + $("#bookSell_sellId_edit").val() + "/update",
		type : "get",
		data : {
			//sellId : $("#bookSell_sellId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookSell, response, status) {
			$.messager.progress("close");
			if (bookSell) { 
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
				bookSell_sellDesc_edit.setContent(bookSell.sellDesc);
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#bookSellModifyButton").click(function(){ 
		if ($("#bookSellEditForm").form("validate")) {
			$("#bookSellEditForm").form({
			    url:"BookSell/" +  $("#bookSell_sellId_edit").val() + "/update",
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
			$("#bookSellEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
