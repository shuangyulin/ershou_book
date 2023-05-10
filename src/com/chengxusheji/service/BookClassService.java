package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.BookClass;

import com.chengxusheji.mapper.BookClassMapper;
@Service
public class BookClassService {

	@Resource BookClassMapper bookClassMapper;
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

    /*添加图书类别记录*/
    public void addBookClass(BookClass bookClass) throws Exception {
    	bookClassMapper.addBookClass(bookClass);
    }

    /*按照查询条件分页查询图书类别记录*/
    public ArrayList<BookClass> queryBookClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return bookClassMapper.queryBookClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<BookClass> queryBookClass() throws Exception  { 
     	String where = "where 1=1";
    	return bookClassMapper.queryBookClassList(where);
    }

    /*查询所有图书类别记录*/
    public ArrayList<BookClass> queryAllBookClass()  throws Exception {
        return bookClassMapper.queryBookClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = bookClassMapper.queryBookClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取图书类别记录*/
    public BookClass getBookClass(int bookClassId) throws Exception  {
        BookClass bookClass = bookClassMapper.getBookClass(bookClassId);
        return bookClass;
    }

    /*更新图书类别记录*/
    public void updateBookClass(BookClass bookClass) throws Exception {
        bookClassMapper.updateBookClass(bookClass);
    }

    /*删除一条图书类别记录*/
    public void deleteBookClass (int bookClassId) throws Exception {
        bookClassMapper.deleteBookClass(bookClassId);
    }

    /*删除多条图书类别信息*/
    public int deleteBookClasss (String bookClassIds) throws Exception {
    	String _bookClassIds[] = bookClassIds.split(",");
    	for(String _bookClassId: _bookClassIds) {
    		bookClassMapper.deleteBookClass(Integer.parseInt(_bookClassId));
    	}
    	return _bookClassIds.length;
    }
}
