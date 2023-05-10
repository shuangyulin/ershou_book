package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BookClass {
    /*类别编号*/
    private Integer bookClassId;
    public Integer getBookClassId(){
        return bookClassId;
    }
    public void setBookClassId(Integer bookClassId){
        this.bookClassId = bookClassId;
    }

    /*类别名称*/
    @NotEmpty(message="类别名称不能为空")
    private String bookClassName;
    public String getBookClassName() {
        return bookClassName;
    }
    public void setBookClassName(String bookClassName) {
        this.bookClassName = bookClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBookClass=new JSONObject(); 
		jsonBookClass.accumulate("bookClassId", this.getBookClassId());
		jsonBookClass.accumulate("bookClassName", this.getBookClassName());
		return jsonBookClass;
    }}