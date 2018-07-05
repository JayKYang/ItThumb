package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
	
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat,false));
	}
	
	@RequestMapping("hire/hirelist")
	public ModelAndView hirelist (Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request) {
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		if(searchRegion != null) {
			if(searchRegion.equals("")) {
				searchRegion = null;
			}
		}
		if(searchEdu != null) {
			if(searchEdu.equals("")) {
				searchEdu = null;
			}
		}
		if(searchCarr != null) {
			if(searchCarr.equals("")) {
				searchCarr = null;
			}
		}
		if(searchCareer != null) {
			if(searchCareer.equals("")) {
				searchCareer = null;
			}
		}
		if(searchCareerDate != null) {
			if(searchCareerDate.equals("")) {
				searchCareerDate = null;
			}
		}
		
		try {

			int popListcount = service.popBoardcount();
			int popLimit = 10;
			List<Hire> popBoardlist = service.popHirelist(popLimit);

			
			
			
			int listcount = service.boardcount(searchRegion, searchEdu,  searchCarr,searchCareer,searchCareerDate);
			int limit = 10;
			List<Hire> boardlist = service.hirelist(searchRegion, searchEdu,searchCarr,searchCareer,searchCareerDate,pageNum, limit);
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
			mav.addObject("popBoardlist",popBoardlist);
			mav.addObject("popListcount",popListcount);
		
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
		
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
		String company = user.getName();
		hire.setMemberid(id);
		hire.setCompany(company);
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user",user);
			mav.addObject("hire",hire);
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
	
	@RequestMapping(value="hire/scrap", method=RequestMethod.POST)
	public ModelAndView scrap(HttpServletRequest request, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		int pageNum = Integer.parseInt(request.getParameter("pageNum"));
		Integer hireno = Integer.parseInt(request.getParameter("hireno"));
		
		
		User user = (User)session.getAttribute("login");
		String memberid = user.getMemberid();
		try {
			Scrap scrap = new Scrap();
			String selectScrapno = service.selectScrap(hireno,memberid);
			
			if(selectScrapno != null) {
				service.deleteScrap(hireno,memberid);
				mav.addObject("msg","스크랩이 해제되었습니다.");
			} else {
			scrap.setHireno(hireno);
			scrap.setMemberid(memberid);
			service.boardScrap(scrap,hireno);
			mav.addObject("msg","스크랩이 등록되었습니다.");
			}
			mav.addObject("url","/itthumb/hire/hiredetail.jsy?hireno=" + hireno+"&pageNum=" +pageNum);
			mav.setViewName("alert");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
}
