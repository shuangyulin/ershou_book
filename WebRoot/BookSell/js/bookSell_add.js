$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('bookSell_sellDesc');
	var bookSell_sellDesc_editor = UE.getEditor('bookSell_sellDesc'); //出售说明编辑框
	$("#bookSell_bookName").validatebox({
		required : true, 
		missingMessage : '请输入图书名称',
	});

	$("#bookSell_bookClassObj_bookClassId").combobox({
	    url:'BookClass/listAll',
	    valueField: "bookClassId",
	    textField: "bookClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookSell_bookClassObj_bookClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#bookSell_bookClassObj_bookClassId").combobox("select", data[0].bookClassId);
            }
        }
	});
	$("#bookSell_publish").validatebox({
		required : true, 
		missingMessage : '请输入出版社',
	});

	$("#bookSell_author").validatebox({
		required : true, 
		missingMessage : '请输入作者',
	});

	$("#bookSell_sellPrice").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入出售价格',
		invalidMessage : '出售价格输入不对',
	});

	$("#bookSell_xjcd").validatebox({
		required : true, 
		missingMessage : '请输入新旧程度',
	});

	$("#bookSell_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookSell_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#bookSell_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#bookSellAddButton").click(function () {
		if(bookSell_sellDesc_editor.getContent() == "") {
			alert("请输入出售说明");
			return;
		}
		//验证表单 
		if(!$("#bookSellAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#bookSellAddForm").form({
			    url:"BookSell/add",
			    onSubmit: function(){
					if($("#bookSellAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#bookSellAddForm").form("clear");
                        bookSell_sellDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#bookSellAddForm").submit();
		}
	});

	//单击清空按钮
	$("#bookSellClearButton").click(function () { 
		$("#bookSellAddForm").form("clear"); 
	});
});
