$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('bookSeek_seekDesc');
	var bookSeek_seekDesc_editor = UE.getEditor('bookSeek_seekDesc'); //求购说明编辑框
	$("#bookSeek_bookName").validatebox({
		required : true, 
		missingMessage : '请输入图书名称',
	});

	$("#bookSeek_bookClassObj_bookClassId").combobox({
	    url:'BookClass/listAll',
	    valueField: "bookClassId",
	    textField: "bookClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookSeek_bookClassObj_bookClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#bookSeek_bookClassObj_bookClassId").combobox("select", data[0].bookClassId);
            }
        }
	});
	$("#bookSeek_publish").validatebox({
		required : true, 
		missingMessage : '请输入出版社',
	});

	$("#bookSeek_author").validatebox({
		required : true, 
		missingMessage : '请输入作者',
	});

	$("#bookSeek_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入求购价格',
		invalidMessage : '求购价格输入不对',
	});

	$("#bookSeek_xjcd").validatebox({
		required : true, 
		missingMessage : '请输入新旧程度',
	});

	$("#bookSeek_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookSeek_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#bookSeek_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	//单击添加按钮
	$("#bookSeekAddButton").click(function () {
		if(bookSeek_seekDesc_editor.getContent() == "") {
			alert("请输入求购说明");
			return;
		}
		//验证表单 
		if(!$("#bookSeekAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#bookSeekAddForm").form({
			    url:"BookSeek/add",
			    onSubmit: function(){
					if($("#bookSeekAddForm").form("validate"))  { 
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
                        $("#bookSeekAddForm").form("clear");
                        bookSeek_seekDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#bookSeekAddForm").submit();
		}
	});

	//单击清空按钮
	$("#bookSeekClearButton").click(function () { 
		$("#bookSeekAddForm").form("clear"); 
	});
});
