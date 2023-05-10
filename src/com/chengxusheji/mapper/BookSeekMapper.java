package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BookSeek;

public interface BookSeekMapper {
	/*添加求购信息*/
	public void addBookSeek(BookSeek bookSeek) throws Exception;

	/*按照查询条件分页查询求购记录*/
	public ArrayList<BookSeek> queryBookSeek(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有求购记录*/
	public ArrayList<BookSeek> queryBookSeekList(@Param("where") String where) throws Exception;

	/*按照查询条件的求购记录数*/
	public int queryBookSeekCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条求购记录*/
	public BookSeek getBookSeek(int seekId) throws Exception;

	/*更新求购记录*/
	public void updateBookSeek(BookSeek bookSeek) throws Exception;

	/*删除求购记录*/
	public void deleteBookSeek(int seekId) throws Exception;

}
