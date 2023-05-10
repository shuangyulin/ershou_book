package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BookOrder {
    /*订单id*/
    private Integer orderId;
    public Integer getOrderId(){
        return orderId;
    }
    public void setOrderId(Integer orderId){
        this.orderId = orderId;
    }

    /*图书信息*/
    private BookSell bookSellObj;
    public BookSell getBookSellObj() {
        return bookSellObj;
    }
    public void setBookSellObj(BookSell bookSellObj) {
        this.bookSellObj = bookSellObj;
    }

    /*意向用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*意向出价*/
    @NotNull(message="必须输入意向出价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*用户备注*/
    private String orderMemo;
    public String getOrderMemo() {
        return orderMemo;
    }
    public void setOrderMemo(String orderMemo) {
        this.orderMemo = orderMemo;
    }

    /*下单时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBookOrder=new JSONObject(); 
		jsonBookOrder.accumulate("orderId", this.getOrderId());
		jsonBookOrder.accumulate("bookSellObj", this.getBookSellObj().getBookName());
		jsonBookOrder.accumulate("bookSellObjPri", this.getBookSellObj().getSellId());
		jsonBookOrder.accumulate("userObj", this.getUserObj().getName());
		jsonBookOrder.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonBookOrder.accumulate("price", this.getPrice());
		jsonBookOrder.accumulate("orderMemo", this.getOrderMemo());
		jsonBookOrder.accumulate("addTime", this.getAddTime());
		return jsonBookOrder;
    }}