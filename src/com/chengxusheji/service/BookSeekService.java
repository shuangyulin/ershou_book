package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BookClass;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.BookSeek;

import com.chengxusheji.mapper.BookSeekMapper;
@Service
public class BookSeekService {

	@Resource BookSeekMapper bookSeekMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加求购记录*/
    public void addBookSeek(BookSeek bookSeek) throws Exception {
    	bookSeekMapper.addBookSeek(bookSeek);
    }

    /*按照查询条件分页查询求购记录*/
    public ArrayList<BookSeek> queryBookSeek(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSeek.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSeek.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSeek.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSeek.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSeek.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_bookSeek.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSeek.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return bookSeekMapper.queryBookSeek(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BookSeek> queryBookSeek(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSeek.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSeek.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSeek.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSeek.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSeek.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookSeek.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSeek.addTime like '%" + addTime + "%'";
    	return bookSeekMapper.queryBookSeekList(where);
    }

    /*查询所有求购记录*/
    public ArrayList<BookSeek> queryAllBookSeek()  throws Exception {
        return bookSeekMapper.queryBookSeekList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSeek.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSeek.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSeek.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSeek.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSeek.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookSeek.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSeek.addTime like '%" + addTime + "%'";
        recordNumber = bookSeekMapper.queryBookSeekCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取求购记录*/
    public BookSeek getBookSeek(int seekId) throws Exception  {
        BookSeek bookSeek = bookSeekMapper.getBookSeek(seekId);
        return bookSeek;
    }

    /*更新求购记录*/
    public void updateBookSeek(BookSeek bookSeek) throws Exception {
        bookSeekMapper.updateBookSeek(bookSeek);
    }

    /*删除一条求购记录*/
    public void deleteBookSeek (int seekId) throws Exception {
        bookSeekMapper.deleteBookSeek(seekId);
    }

    /*删除多条求购信息*/
    public int deleteBookSeeks (String seekIds) throws Exception {
    	String _seekIds[] = seekIds.split(",");
    	for(String _seekId: _seekIds) {
    		bookSeekMapper.deleteBookSeek(Integer.parseInt(_seekId));
    	}
    	return _seekIds.length;
    }
}
