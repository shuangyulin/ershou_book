package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.BookClass;

public interface BookClassMapper {
	/*添加图书类别信息*/
	public void addBookClass(BookClass bookClass) throws Exception;

	/*按照查询条件分页查询图书类别记录*/
	public ArrayList<BookClass> queryBookClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有图书类别记录*/
	public ArrayList<BookClass> queryBookClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的图书类别记录数*/
	public int queryBookClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条图书类别记录*/
	public BookClass getBookClass(int bookClassId) throws Exception;

	/*更新图书类别记录*/
	public void updateBookClass(BookClass bookClass) throws Exception;

	/*删除图书类别记录*/
	public void deleteBookClass(int bookClassId) throws Exception;

}
