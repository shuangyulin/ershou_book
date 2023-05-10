package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BookClass;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.BookSell;

import com.chengxusheji.mapper.BookSellMapper;
@Service
public class BookSellService {

	@Resource BookSellMapper bookSellMapper;
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

    /*添加图书出售记录*/
    public void addBookSell(BookSell bookSell) throws Exception {
    	bookSellMapper.addBookSell(bookSell);
    }

    /*按照查询条件分页查询图书出售记录*/
    public ArrayList<BookSell> queryBookSell(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSell.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSell.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSell.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSell.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSell.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_bookSell.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSell.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return bookSellMapper.queryBookSell(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BookSell> queryBookSell(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSell.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSell.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSell.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSell.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSell.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookSell.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSell.addTime like '%" + addTime + "%'";
    	return bookSellMapper.queryBookSellList(where);
    }

    /*查询所有图书出售记录*/
    public ArrayList<BookSell> queryAllBookSell()  throws Exception {
        return bookSellMapper.queryBookSellList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String bookName,BookClass bookClassObj,String publish,String author,String xjcd,UserInfo userObj,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(!bookName.equals("")) where = where + " and t_bookSell.bookName like '%" + bookName + "%'";
    	if(null != bookClassObj && bookClassObj.getBookClassId()!= null && bookClassObj.getBookClassId()!= 0)  where += " and t_bookSell.bookClassObj=" + bookClassObj.getBookClassId();
    	if(!publish.equals("")) where = where + " and t_bookSell.publish like '%" + publish + "%'";
    	if(!author.equals("")) where = where + " and t_bookSell.author like '%" + author + "%'";
    	if(!xjcd.equals("")) where = where + " and t_bookSell.xjcd like '%" + xjcd + "%'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_bookSell.userObj='" + userObj.getUser_name() + "'";
    	if(!addTime.equals("")) where = where + " and t_bookSell.addTime like '%" + addTime + "%'";
        recordNumber = bookSellMapper.queryBookSellCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取图书出售记录*/
    public BookSell getBookSell(int sellId) throws Exception  {
        BookSell bookSell = bookSellMapper.getBookSell(sellId);
        return bookSell;
    }

    /*更新图书出售记录*/
    public void updateBookSell(BookSell bookSell) throws Exception {
        bookSellMapper.updateBookSell(bookSell);
    }

    /*删除一条图书出售记录*/
    public void deleteBookSell (int sellId) throws Exception {
        bookSellMapper.deleteBookSell(sellId);
    }

    /*删除多条图书出售信息*/
    public int deleteBookSells (String sellIds) throws Exception {
    	String _sellIds[] = sellIds.split(",");
    	for(String _sellId: _sellIds) {
    		bookSellMapper.deleteBookSell(Integer.parseInt(_sellId));
    	}
    	return _sellIds.length;
    }
}
