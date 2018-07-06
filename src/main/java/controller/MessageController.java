package controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.JsyService;
import logic.Message;
import logic.User;

@Controller
public class MessageController {
	@Autowired
	JsyService service;
	
	@RequestMapping("message/messageList")
	public ModelAndView mesLogConmessageList(HttpSession session,HttpServletRequest request,Integer pageNum, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		String sort = request.getParameter("sort");
		sort = sort.substring(0, 1);
		User user = (User) request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		
		int messagecount = service.messagecount(searchType, searchContent, sort, memberid);
		List<Message> messagelist = service.messagelist(searchType, searchContent, pageNum, limit, sort, memberid);
		
		int maxpage = (int)((double)messagecount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int sendmesnum = messagecount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("messagecount", messagecount);
		mav.addObject("messagelist", messagelist);
		mav.addObject("sendmesnum", sendmesnum);
		mav.addObject("sort", sort);
		mav.setViewName("message/messageList");
		return mav;
	}
	
	@RequestMapping("message/messageInfo")
	public ModelAndView messageInfo(HttpServletRequest request, Integer sort, Integer pageNum, Integer messageno) {
		ModelAndView mav = new ModelAndView();
		
		Message mes = service.messageSelect(messageno);
		if(sort==1) {
			service.messageConfirm(messageno);
		}
		
		mav.addObject("sort", sort);
		mav.addObject("pageNum", pageNum);
		mav.addObject("message", mes);
		mav.setViewName("message/messageInfo");
		return mav;
	}
	
	@RequestMapping("message/messagedelete")
	public ModelAndView messageDelete(String[] idchks, Integer sort, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		for(String messageno : idchks) {
			service.messagedelete(messageno, sort);
			service.messageDBdelete(messageno);
		}
		mav.addObject("msg","삭제가 완료 되었습니다.");
		mav.addObject("url","messageList.jsy?sort="+sort+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping(value="message/messageWrite", method=RequestMethod.GET)
	public ModelAndView mesLogConmessageWrite(HttpSession session,String memberid) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberid", memberid);
		mav.addObject("message", new Message());
		return mav;
	}
	
	@RequestMapping(value="message/messageWrite", method=RequestMethod.POST)
	public ModelAndView messageWriteInsert(@Valid Message message, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("message", message);
			return mav;
		}
		User user = (User) request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		message.setSender(memberid);
		
		String[] receivers = message.getReceiver().split(",");
		for(String receiver : receivers) {
			try {
				int max = service.messageMax();
				message.setMessageno(max+1);
				message.setReceiver(receiver);
				service.messageWrite(message);
			}catch (Exception e) {
				mav.addObject("message", message);
				mav.addObject("msg","메세지 전송 실패");
				mav.addObject("url","messageWrite.jsy");
				mav.setViewName("alert");
				return mav;
			}
		}
		mav.addObject("msg","메세지 전송 완료");
		mav.addObject("url","messageList.jsy?sort=2");
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("message/autoIdComplete")
	public ModelAndView autoIdComplete(String memberid, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		request.setAttribute("memberid", memberid);
		return mav;
	}
}
