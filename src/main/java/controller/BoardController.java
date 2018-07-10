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

import exception.JsyException;
import logic.Hire;
import logic.JsyService;
import logic.Scrap;
import logic.User;

@Controller
public class BoardController {
	@Autowired
	JsyService service;
	
	@RequestMapping("hire/hirelist")
	public ModelAndView hirelist (Integer pageNum, String searchRegion, String searchEdu, String searchCarr ,HttpServletRequest request) {
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		
		int listcount = service.boardcount(searchRegion, searchEdu,  searchCarr);
		
		int limit = 10;
		List<Hire> boardlist = service.hirelist(searchRegion, searchEdu,searchCarr,pageNum, limit);
		
				
		
		int maxpage = (int)((double)listcount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
		int endpage = maxpage + 9;
		
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = listcount - (pageNum -1) * limit;
		
		
		
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardlist", boardlist);
		mav.addObject("boardcnt", boardcnt);
		
		
		return mav;
	}
	
	@RequestMapping(value="hire/hirewrite", method=RequestMethod.GET)
	public ModelAndView hirewrite(HttpSession session) {
	ModelAndView mav = new ModelAndView();
	User user = (User)session.getAttribute("login");
	String id = user.getMemberid();
	user = service.getUser(id);
	Hire hire = new Hire();
	mav.addObject("user", user);
	mav.addObject("hire", hire);
		return mav;
	}
	
	@RequestMapping(value="hire/hirewrite", method=RequestMethod.POST)
	public ModelAndView hirewrite(@Valid Hire hire, BindingResult bindingResult,HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String salary = (String)request.getParameter("salary");
		hire.setSalary(Integer.parseInt(salary));
		
		User user = (User)session.getAttribute("login");
		String id = user.getMemberid();
		hire.setMemberid(id);
		if(bindingResult.hasErrors()) {
			System.out.println(bindingResult);
			mav.getModel().putAll(bindingResult.getModel());
			return mav;
		}
		try {
			
			service.hireWrite(hire,request);
			mav.setViewName("redirect:/hire/hirelist.jsy");
		} catch(Exception e) {
			e.printStackTrace();
			throw new JsyException("채용공고 등록 실패","hirewrite.jsy");
		}
		return mav;
		
	}
	
	@RequestMapping(value="hire/hiredetail", method=RequestMethod.GET)
	public ModelAndView hiredetail(Integer hireno, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Hire hire = new Hire();
		if(hireno != null) {
			hire = service.getHire(hireno);
			service.readCntplus(hireno);
		}
		User user = service.getUser(hire.getMemberid());
		mav.addObject("user",user);
		mav.addObject("hire", hire);
		
		return mav;
	}
	
}
