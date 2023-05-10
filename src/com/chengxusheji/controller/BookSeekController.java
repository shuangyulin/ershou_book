package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.BookSeekService;
import com.chengxusheji.po.BookSeek;
import com.chengxusheji.service.BookClassService;
import com.chengxusheji.po.BookClass;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//BookSeek管理控制层
@Controller
@RequestMapping("/BookSeek")
public class BookSeekController extends BaseController {

    /*业务层对象*/
    @Resource BookSeekService bookSeekService;

    @Resource BookClassService bookClassService;
    @Resource UserInfoService userInfoService;
	@InitBinder("bookClassObj")
	public void initBinderbookClassObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookClassObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("bookSeek")
	public void initBinderBookSeek(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookSeek.");
	}
	/*跳转到添加BookSeek视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BookSeek());
		/*查询所有的BookClass信息*/
		List<BookClass> bookClassList = bookClassService.queryAllBookClass();
		request.setAttribute("bookClassList", bookClassList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "BookSeek_add";
	}

	/*客户端ajax方式提交添加求购信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BookSeek bookSeek, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			bookSeek.setBookPhoto(this.handlePhotoUpload(request, "bookPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        bookSeekService.addBookSeek(bookSeek);
        message = "求购添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询求购信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String bookName,@ModelAttribute("bookClassObj") BookClass bookClassObj,String publish,String author,String xjcd,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (bookName == null) bookName = "";
		if (publish == null) publish = "";
		if (author == null) author = "";
		if (xjcd == null) xjcd = "";
		if (addTime == null) addTime = "";
		if(rows != 0)bookSeekService.setRows(rows);
		List<BookSeek> bookSeekList = bookSeekService.queryBookSeek(bookName, bookClassObj, publish, author, xjcd, userObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    bookSeekService.queryTotalPageAndRecordNumber(bookName, bookClassObj, publish, author, xjcd, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookSeekService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookSeekService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BookSeek bookSeek:bookSeekList) {
			JSONObject jsonBookSeek = bookSeek.getJsonObject();
			jsonArray.put(jsonBookSeek);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询求购信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BookSeek> bookSeekList = bookSeekService.queryAllBookSeek();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BookSeek bookSeek:bookSeekList) {
			JSONObject jsonBookSeek = new JSONObject();
			jsonBookSeek.accumulate("seekId", bookSeek.getSeekId());
			jsonBookSeek.accumulate("bookName", bookSeek.getBookName());
			jsonArray.put(jsonBookSeek);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询求购信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String bookName,@ModelAttribute("bookClassObj") BookClass bookClassObj,String publish,String author,String xjcd,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (bookName == null) bookName = "";
		if (publish == null) publish = "";
		if (author == null) author = "";
		if (xjcd == null) xjcd = "";
		if (addTime == null) addTime = "";
		List<BookSeek> bookSeekList = bookSeekService.queryBookSeek(bookName, bookClassObj, publish, author, xjcd, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    bookSeekService.queryTotalPageAndRecordNumber(bookName, bookClassObj, publish, author, xjcd, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookSeekService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookSeekService.getRecordNumber();
	    request.setAttribute("bookSeekList",  bookSeekList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("bookName", bookName);
	    request.setAttribute("bookClassObj", bookClassObj);
	    request.setAttribute("publish", publish);
	    request.setAttribute("author", author);
	    request.setAttribute("xjcd", xjcd);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<BookClass> bookClassList = bookClassService.queryAllBookClass();
	    request.setAttribute("bookClassList", bookClassList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "BookSeek/bookSeek_frontquery_result"; 
	}

     /*前台查询BookSeek信息*/
	@RequestMapping(value="/{seekId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer seekId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键seekId获取BookSeek对象*/
        BookSeek bookSeek = bookSeekService.getBookSeek(seekId);

        List<BookClass> bookClassList = bookClassService.queryAllBookClass();
        request.setAttribute("bookClassList", bookClassList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("bookSeek",  bookSeek);
        return "BookSeek/bookSeek_frontshow";
	}

	/*ajax方式显示求购修改jsp视图页*/
	@RequestMapping(value="/{seekId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer seekId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键seekId获取BookSeek对象*/
        BookSeek bookSeek = bookSeekService.getBookSeek(seekId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBookSeek = bookSeek.getJsonObject();
		out.println(jsonBookSeek.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新求购信息*/
	@RequestMapping(value = "/{seekId}/update", method = RequestMethod.POST)
	public void update(@Validated BookSeek bookSeek, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String bookPhotoFileName = this.handlePhotoUpload(request, "bookPhotoFile");
		if(!bookPhotoFileName.equals("upload/NoImage.jpg"))bookSeek.setBookPhoto(bookPhotoFileName); 


		try {
			bookSeekService.updateBookSeek(bookSeek);
			message = "求购更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "求购更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除求购信息*/
	@RequestMapping(value="/{seekId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer seekId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  bookSeekService.deleteBookSeek(seekId);
	            request.setAttribute("message", "求购删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "求购删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条求购记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String seekIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = bookSeekService.deleteBookSeeks(seekIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出求购信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String bookName,@ModelAttribute("bookClassObj") BookClass bookClassObj,String publish,String author,String xjcd,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(bookName == null) bookName = "";
        if(publish == null) publish = "";
        if(author == null) author = "";
        if(xjcd == null) xjcd = "";
        if(addTime == null) addTime = "";
        List<BookSeek> bookSeekList = bookSeekService.queryBookSeek(bookName,bookClassObj,publish,author,xjcd,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BookSeek信息记录"; 
        String[] headers = { "求购id","图书主图","图书名称","图书类别","出版社","作者","求购价格","新旧程度","发布用户","用户发布时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<bookSeekList.size();i++) {
        	BookSeek bookSeek = bookSeekList.get(i); 
        	dataset.add(new String[]{bookSeek.getSeekId() + "",bookSeek.getBookPhoto(),bookSeek.getBookName(),bookSeek.getBookClassObj().getBookClassName(),bookSeek.getPublish(),bookSeek.getAuthor(),bookSeek.getPrice() + "",bookSeek.getXjcd(),bookSeek.getUserObj().getName(),bookSeek.getAddTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"BookSeek.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
