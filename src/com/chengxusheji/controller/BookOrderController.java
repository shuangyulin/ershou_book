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
import com.chengxusheji.service.BookOrderService;
import com.chengxusheji.po.BookOrder;
import com.chengxusheji.service.BookSellService;
import com.chengxusheji.po.BookSell;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//BookOrder管理控制层
@Controller
@RequestMapping("/BookOrder")
public class BookOrderController extends BaseController {

    /*业务层对象*/
    @Resource BookOrderService bookOrderService;

    @Resource BookSellService bookSellService;
    @Resource UserInfoService userInfoService;
	@InitBinder("bookSellObj")
	public void initBinderbookSellObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookSellObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("bookOrder")
	public void initBinderBookOrder(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookOrder.");
	}
	/*跳转到添加BookOrder视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new BookOrder());
		/*查询所有的BookSell信息*/
		List<BookSell> bookSellList = bookSellService.queryAllBookSell();
		request.setAttribute("bookSellList", bookSellList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "BookOrder_add";
	}

	/*客户端ajax方式提交添加图书订单信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated BookOrder bookOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        bookOrderService.addBookOrder(bookOrder);
        message = "图书订单添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询图书订单信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("bookSellObj") BookSell bookSellObj,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (addTime == null) addTime = "";
		if(rows != 0)bookOrderService.setRows(rows);
		List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(bookSellObj, userObj, addTime, page);
	    /*计算总的页数和总的记录数*/
	    bookOrderService.queryTotalPageAndRecordNumber(bookSellObj, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookOrderService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(BookOrder bookOrder:bookOrderList) {
			JSONObject jsonBookOrder = bookOrder.getJsonObject();
			jsonArray.put(jsonBookOrder);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询图书订单信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<BookOrder> bookOrderList = bookOrderService.queryAllBookOrder();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(BookOrder bookOrder:bookOrderList) {
			JSONObject jsonBookOrder = new JSONObject();
			jsonBookOrder.accumulate("orderId", bookOrder.getOrderId());
			jsonArray.put(jsonBookOrder);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询图书订单信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("bookSellObj") BookSell bookSellObj,@ModelAttribute("userObj") UserInfo userObj,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (addTime == null) addTime = "";
		List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(bookSellObj, userObj, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    bookOrderService.queryTotalPageAndRecordNumber(bookSellObj, userObj, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = bookOrderService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookOrderService.getRecordNumber();
	    request.setAttribute("bookOrderList",  bookOrderList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("bookSellObj", bookSellObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("addTime", addTime);
	    List<BookSell> bookSellList = bookSellService.queryAllBookSell();
	    request.setAttribute("bookSellList", bookSellList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "BookOrder/bookOrder_frontquery_result"; 
	}

     /*前台查询BookOrder信息*/
	@RequestMapping(value="/{orderId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer orderId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键orderId获取BookOrder对象*/
        BookOrder bookOrder = bookOrderService.getBookOrder(orderId);

        List<BookSell> bookSellList = bookSellService.queryAllBookSell();
        request.setAttribute("bookSellList", bookSellList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("bookOrder",  bookOrder);
        return "BookOrder/bookOrder_frontshow";
	}

	/*ajax方式显示图书订单修改jsp视图页*/
	@RequestMapping(value="/{orderId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer orderId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键orderId获取BookOrder对象*/
        BookOrder bookOrder = bookOrderService.getBookOrder(orderId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonBookOrder = bookOrder.getJsonObject();
		out.println(jsonBookOrder.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新图书订单信息*/
	@RequestMapping(value = "/{orderId}/update", method = RequestMethod.POST)
	public void update(@Validated BookOrder bookOrder, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			bookOrderService.updateBookOrder(bookOrder);
			message = "图书订单更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "图书订单更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除图书订单信息*/
	@RequestMapping(value="/{orderId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer orderId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  bookOrderService.deleteBookOrder(orderId);
	            request.setAttribute("message", "图书订单删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "图书订单删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条图书订单记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String orderIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = bookOrderService.deleteBookOrders(orderIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出图书订单信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("bookSellObj") BookSell bookSellObj,@ModelAttribute("userObj") UserInfo userObj,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(addTime == null) addTime = "";
        List<BookOrder> bookOrderList = bookOrderService.queryBookOrder(bookSellObj,userObj,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "BookOrder信息记录"; 
        String[] headers = { "订单id","图书信息","意向用户","意向出价","用户备注","下单时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<bookOrderList.size();i++) {
        	BookOrder bookOrder = bookOrderList.get(i); 
        	dataset.add(new String[]{bookOrder.getOrderId() + "",bookOrder.getBookSellObj().getBookName(),bookOrder.getUserObj().getName(),bookOrder.getPrice() + "",bookOrder.getOrderMemo(),bookOrder.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"BookOrder.xls");//filename是下载的xls的名，建议最好用英文 
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
