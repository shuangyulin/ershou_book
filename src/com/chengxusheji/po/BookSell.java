package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BookSell {
    /*出售id*/
    private Integer sellId;
    public Integer getSellId(){
        return sellId;
    }
    public void setSellId(Integer sellId){
        this.sellId = sellId;
    }

    /*图书主图*/
    private String bookPhoto;
    public String getBookPhoto() {
        return bookPhoto;
    }
    public void setBookPhoto(String bookPhoto) {
        this.bookPhoto = bookPhoto;
    }

    /*图书名称*/
    @NotEmpty(message="图书名称不能为空")
    private String bookName;
    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    /*图书类别*/
    private BookClass bookClassObj;
    public BookClass getBookClassObj() {
        return bookClassObj;
    }
    public void setBookClassObj(BookClass bookClassObj) {
        this.bookClassObj = bookClassObj;
    }

    /*出版社*/
    @NotEmpty(message="出版社不能为空")
    private String publish;
    public String getPublish() {
        return publish;
    }
    public void setPublish(String publish) {
        this.publish = publish;
    }

    /*作者*/
    @NotEmpty(message="作者不能为空")
    private String author;
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }

    /*出售价格*/
    @NotNull(message="必须输入出售价格")
    private Float sellPrice;
    public Float getSellPrice() {
        return sellPrice;
    }
    public void setSellPrice(Float sellPrice) {
        this.sellPrice = sellPrice;
    }

    /*新旧程度*/
    @NotEmpty(message="新旧程度不能为空")
    private String xjcd;
    public String getXjcd() {
        return xjcd;
    }
    public void setXjcd(String xjcd) {
        this.xjcd = xjcd;
    }

    /*出售说明*/
    @NotEmpty(message="出售说明不能为空")
    private String sellDesc;
    public String getSellDesc() {
        return sellDesc;
    }
    public void setSellDesc(String sellDesc) {
        this.sellDesc = sellDesc;
    }

    /*发布用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*用户发布时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonBookSell=new JSONObject(); 
		jsonBookSell.accumulate("sellId", this.getSellId());
		jsonBookSell.accumulate("bookPhoto", this.getBookPhoto());
		jsonBookSell.accumulate("bookName", this.getBookName());
		jsonBookSell.accumulate("bookClassObj", this.getBookClassObj().getBookClassName());
		jsonBookSell.accumulate("bookClassObjPri", this.getBookClassObj().getBookClassId());
		jsonBookSell.accumulate("publish", this.getPublish());
		jsonBookSell.accumulate("author", this.getAuthor());
		jsonBookSell.accumulate("sellPrice", this.getSellPrice());
		jsonBookSell.accumulate("xjcd", this.getXjcd());
		jsonBookSell.accumulate("sellDesc", this.getSellDesc());
		jsonBookSell.accumulate("userObj", this.getUserObj().getName());
		jsonBookSell.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonBookSell.accumulate("addTime", this.getAddTime());
		return jsonBookSell;
    }}