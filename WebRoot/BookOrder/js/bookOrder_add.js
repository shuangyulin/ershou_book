$(function () {
	$("#bookOrder_bookSellObj_sellId").combobox({
	    url:'BookSell/listAll',
	    valueField: "sellId",
	    textField: "bookName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookOrder_bookSellObj_sellId").combobox("getData"); 
            if (data.length > 0) {
                $("#bookOrder_bookSellObj_sellId").combobox("select", data[0].sellId);
            }
        }
	});
	$("#bookOrder_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#bookOrder_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#bookOrder_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#bookOrder_price").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入意向出价',
		invalidMessage : '意向出价输入不对',
	});

	//单击添加按钮
	$("#bookOrderAddButton").click(function () {
		//验证表单 
		if(!$("#bookOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#bookOrderAddForm").form({
			    url:"BookOrder/add",
			    onSubmit: function(){
					if($("#bookOrderAddForm").form("validate"))  { 
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
                        $("#bookOrderAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#bookOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#bookOrderClearButton").click(function () { 
		$("#bookOrderAddForm").form("clear"); 
	});
});
