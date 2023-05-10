package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BookSell;

public interface BookSellMapper {
	/*添加图书出售信息*/
	public void addBookSell(BookSell bookSell) throws Exception;

	/*按照查询条件分页查询图书出售记录*/
	public ArrayList<BookSell> queryBookSell(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有图书出售记录*/
	public ArrayList<BookSell> queryBookSellList(@Param("where") String where) throws Exception;

	/*按照查询条件的图书出售记录数*/
	public int queryBookSellCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条图书出售记录*/
	public BookSell getBookSell(int sellId) throws Exception;

	/*更新图书出售记录*/
	public void updateBookSell(BookSell bookSell) throws Exception;

	/*删除图书出售记录*/
	public void deleteBookSell(int sellId) throws Exception;

}
