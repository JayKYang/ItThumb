package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		User user = (User) session.getAttribute("login");
		String id = user.getMemberid();
		user = service.getUser(id);
		mav.addObject("user", user);
		mav.addObject("hire", new Hire());
		return mav;
	}
	
	@RequestMapping(value="hire/hirewrite", method=RequestMethod.POST)
	public ModelAndView hirewrite(@Valid Hire hire, BindingResult bindingResult,HttpServletRequest request, HttpSession session) {
		System.out.println(hire);
		ModelAndView mav = new ModelAndView();
		String salary = request.getParameter("salary");
		hire.setSalary(salary);
		
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
		User user2 = (User)request.getSession().getAttribute("login");
		String memberid = user2.getMemberid();
		
		Scrap scrap = service.hireScrapSelect(hireno, memberid);
	       if(scrap == null) {
	          mav.addObject("scrapComfirm",0);
	       }else {
	          mav.addObject("scrapComfirm",1);
	       }
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
	
	@RequestMapping("hire/hireScrap")
	   @ResponseBody
	   public HashMap<String, String> hireScrap(@RequestParam HashMap<String, String> params, HttpServletRequest request){
	       HashMap<String, String> map = new HashMap<String, String>();
	       int hireno = Integer.parseInt(request.getParameter("hireno"));
	       String memberid = request.getParameter("memberid");
	       Scrap scrap = service.hireScrapSelect(hireno, memberid);
	       if(scrap == null) {
	          int scrapMaxnum = service.ScrapMaxnum()+1;
	          Scrap insertScrap = new Scrap();
	          insertScrap.setScrap(scrapMaxnum);
	          insertScrap.setMemberid(memberid);
	          insertScrap.setHireno(hireno);
	          try {
	        	  service.hireInsertScrap(insertScrap);
	          }catch (Exception e) {
	            e.printStackTrace();
	          }
	          map.put("success", "success");
	       }else {
	          try {
	        	  service.hireDeleteScrap(scrap.getScrap());
	          }catch (Exception e) {
	            e.printStackTrace();
	          }
	          
	          map.put("success", "delete");
	       }
	       return map;
	   }

}
