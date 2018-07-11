package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Hire;
import logic.JsyService;
import logic.User;

@Controller
public class AdminController {
	@Autowired
	JsyService service;
	
	@RequestMapping("admin/admin")
	public ModelAndView admin(Integer membergrade,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userList = service.userList(membergrade);
		mav.addObject("userlist", userList);
		return mav;
	}
	
	@RequestMapping("admin/superviseHire")
	public ModelAndView superviseHire(Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Hire hire = new Hire();
		int limit = 15;
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int suphirelistcount = service.suphirelistcount(searchRegion, searchEdu, searchCarr, searchCareer, searchCareerDate);
		List<Hire> hirelist = service.hirelist(searchRegion, searchEdu, searchCarr, searchCareer, searchCareerDate, pageNum, limit);
		int maxpage = (int)((double)suphirelistcount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = suphirelistcount - (pageNum -1) * limit;
		
		
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("suphirelistcount",suphirelistcount);
		mav.addObject("pageNum",pageNum);
		mav.addObject("hirelist",hirelist);
		mav.addObject("boardcnt", boardcnt);
		return mav;
	}
	
	@RequestMapping(value="admin/recognizeHire") // 채용공고 승인
	@ResponseBody
	public HashMap<String,Object> recognizeHire(@RequestParam HashMap<String,Object> params, HttpServletRequest request) {
		HashMap <String,Object> map = new HashMap<String,Object>();
		
		int hireno = Integer.parseInt(request.getParameter("hireno"));
		try {
			service.updateHide(hireno);
			map.put("success", "success");
		} catch(Exception e){
			e.printStackTrace();
		}
		return map;
	}
	
	@RequestMapping(value="admin/deleteHire") // 채용공고 삭제
	@ResponseBody
	public HashMap<String,Object> deleteHire(@RequestParam HashMap<String,Object> params, HttpServletRequest request) {
		HashMap <String,Object> map = new HashMap<String,Object>();
		
		int hireno = Integer.parseInt(request.getParameter("hireno"));
		
		try {
			service.deleteHire(hireno);
			map.put("success", "success");
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return map;
	}
	

}
