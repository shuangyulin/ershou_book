$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('bookSeek_seekDesc_edit');
	var bookSeek_seekDesc_edit = UE.getEditor('bookSeek_seekDesc_edit'); //求购说明编辑器
	bookSeek_seekDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "BookSeek/" + $("#bookSeek_seekId_edit").val() + "/update",
		type : "get",
		data : {
			//seekId : $("#bookSeek_seekId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (bookSeek, response, status) {
			$.messager.progress("close");
			if (bookSeek) { 
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
				bookSeek_seekDesc_edit.setContent(bookSeek.seekDesc);
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#bookSeekModifyButton").click(function(){ 
		if ($("#bookSeekEditForm").form("validate")) {
			$("#bookSeekEditForm").form({
			    url:"BookSeek/" +  $("#bookSeek_seekId_edit").val() + "/update",
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
			$("#bookSeekEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
