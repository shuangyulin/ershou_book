package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class BookSeek {
    /*求购id*/
    private Integer seekId;
    public Integer getSeekId(){
        return seekId;
    }
    public void setSeekId(Integer seekId){
        this.seekId = seekId;
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

    /*求购价格*/
    @NotNull(message="必须输入求购价格")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
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

    /*求购说明*/
    @NotEmpty(message="求购说明不能为空")
    private String seekDesc;
    public String getSeekDesc() {
        return seekDesc;
    }
    public void setSeekDesc(String seekDesc) {
        this.seekDesc = seekDesc;
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
    	JSONObject jsonBookSeek=new JSONObject(); 
		jsonBookSeek.accumulate("seekId", this.getSeekId());
		jsonBookSeek.accumulate("bookPhoto", this.getBookPhoto());
		jsonBookSeek.accumulate("bookName", this.getBookName());
		jsonBookSeek.accumulate("bookClassObj", this.getBookClassObj().getBookClassName());
		jsonBookSeek.accumulate("bookClassObjPri", this.getBookClassObj().getBookClassId());
		jsonBookSeek.accumulate("publish", this.getPublish());
		jsonBookSeek.accumulate("author", this.getAuthor());
		jsonBookSeek.accumulate("price", this.getPrice());
		jsonBookSeek.accumulate("xjcd", this.getXjcd());
		jsonBookSeek.accumulate("seekDesc", this.getSeekDesc());
		jsonBookSeek.accumulate("userObj", this.getUserObj().getName());
		jsonBookSeek.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonBookSeek.accumulate("addTime", this.getAddTime());
		return jsonBookSeek;
    }}