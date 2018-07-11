package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.taglibs.standard.extra.spath.ParseException;
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
	public ModelAndView hirelist (Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request){
		
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
			String strDate = null;
			String strEndDate = null;
			Date beginDate = null;
			Date endDate = null;
			Date date = new Date(); // 현재 날짜
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			long diff = 0;
			long diffDays = 0;
			List datelist = new ArrayList();
			List popDatelist = new ArrayList();
			int popListcount = service.popBoardcount();
			int popLimit = 10;
			List<Hire> popBoardlist = service.popHirelist(popLimit); // 인기 공고 게시물 4건

			for(int i=0; i<popBoardlist.size(); i++) {
				strDate = formatter.format(date);
				strEndDate = formatter.format(popBoardlist.get(i).getDeadline());
				beginDate = formatter.parse(strDate);
				endDate = formatter.parse(strEndDate);
			    diff = endDate.getTime() - beginDate.getTime();
				 diffDays = diff / (24 * 60 * 60 * 1000);
				 popDatelist.add(diffDays);
			}
			
			
			
			int listcount = service.boardcount(searchRegion, searchEdu,  searchCarr,searchCareer,searchCareerDate);
			int limit = 10;
			List<Hire> boardlist = service.hirelist(searchRegion, searchEdu,searchCarr,searchCareer,searchCareerDate,pageNum, limit);
			
			for(int i=0; i<boardlist.size(); i++) {
			
				strDate = formatter.format(date); 
				strEndDate = formatter.format(boardlist.get(i).getDeadline());
				beginDate = formatter.parse(strDate);
				endDate = formatter.parse(strEndDate);
			    diff = endDate.getTime() - beginDate.getTime();
			    diffDays = diff / (24 * 60 * 60 * 1000);
			    datelist.add(diffDays);
			}
			
			
			
			
			int maxpage = (int)((double)listcount/limit + 0.95);
			int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
			int endpage = maxpage + 9;
			
			if(endpage > maxpage) endpage = maxpage;
			int boardcnt = listcount - (pageNum -1) * limit;
			
			mav.addObject("popDatelist", popDatelist);
			mav.addObject("datelist",datelist);
			mav.addObject("pageNum",pageNum);
			mav.addObject("maxpage", maxpage);
			mav.addObject("startpage", startpage);
			mav.addObject("endpage", endpage);
			mav.addObject("listcount", listcount);
			mav.addObject("boardlist", boardlist);
			mav.addObject("boardcnt", boardcnt);
			mav.addObject("popBoardlist",popBoardlist);
			mav.addObject("popListcount",popListcount);
			
		
			}
			catch (Exception e) {
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
			String searchType = null;
			String searchContent = null;
			hire = service.getHire(hireno,searchType, searchContent);
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
	       User user = (User)request.getSession().getAttribute("login");
	       String memberid = user.getMemberid();
	       Scrap scrap = service.hireScrapSelect(hireno, memberid);
	       if(scrap == null) {
	          int scrapMaxnum = service.ScrapMaxnum()+1;
	          Scrap insertScrap = new Scrap();
	          insertScrap.setScrap(scrapMaxnum);
	          insertScrap.setMemberid(memberid);
	          insertScrap.setHireno(hireno);
	          try {
	        	  service.hireInsertScrap(insertScrap);
	        	  service.hireUpdateScrapNum(hireno);
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

	//	마이페이지 채용공고 스크랩 관련 ---------여기부터 ㄱㄱㄱㄱ
	
	@RequestMapping("hire/hireScrapList.jsy")
	public ModelAndView hireScrapList(HttpServletRequest request, Integer pageNum,String searchType, String searchContent) throws ParseException {
		
		if(pageNum==null|| pageNum.toString().equals("")) {
			pageNum=1;
		}
		
		if(searchType==null||searchType.equals("")) {
			searchContent=null;
		}
		
		ModelAndView mav = new ModelAndView();
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		int limit = 15;
		try {
		/*List<Scrap> scraplist = service.scrapHirelist(memberid,pageNum, limit);
		int hireno = 0;
		List<Hire> scraphirelist = new ArrayList<Hire>();
		for(Scrap scrap : scraplist ) {
			hireno = scrap.getHireno();
			scraphirelist.add((Hire)service.getHire(hireno,searchType,searchContent));
		}*/
		
		List<Hire> scraphirelist = service.getScrapList(memberid,searchType,searchContent,pageNum,limit);
		int scraphirecount = service.scrapHireCount(memberid,searchType,searchContent);
		
		System.out.println(scraphirelist+"afasfgdgdg");
		System.out.println(scraphirecount+"asfasfasf");
		
		List datelist = new ArrayList();
		Date startDate = new Date();
		Date endDate = null;
		Calendar cal = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		long calDate = 0;
		long calDateDays = 0;
		for(int i =0; i<scraphirelist.size(); i++) {
		endDate = scraphirelist.get(i).getDeadline(); // 마감일
			calDate =endDate.getTime() - startDate.getTime();
			calDateDays = calDate / (24*60*60*1000);
			calDateDays = Math.abs(calDateDays);
			datelist.add(calDateDays);
		}
		int maxpage = (int)((double)scraphirecount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
		int endpage = maxpage + 9;
		
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = scraphirecount - (pageNum -1) * limit;
		
		mav.addObject("boardcnt",boardcnt);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage",startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("pageNum",pageNum);
		mav.addObject("scraphirecount",scraphirecount);
		mav.addObject("datelist",datelist);
		mav.addObject("scraphirelist",scraphirelist);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	
	@RequestMapping("hire/hireCheckScrapDelete")
	@ResponseBody
	public HashMap<String, String> hireCheckScrapDelete(@RequestParam HashMap<String, String> params, HttpServletRequest request){
		HashMap<String, String> map = new HashMap<String,String>();
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		int hireno = 0;
		String str = request.getParameter("checkhireno");
		String[] chkarr = str.split(",");
		System.out.println("검사 : " + chkarr);
		Scrap scrap = new Scrap();
		try {
		for(int i=0; i<chkarr.length; i++) {
			hireno = Integer.parseInt(chkarr[i]);
			scrap = service.hireScrapSelect(hireno, memberid);
			service.hireDeleteScrap(scrap.getScrap());
		}
		} catch(Exception e) {
			e.printStackTrace();
		}
		 map.put("success", "success");
		return map;
	}
	
	@RequestMapping("hire/myhirelist")
	public ModelAndView myhirelist(HttpServletRequest request,String searchType, String searchContent, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		if(pageNum==null||pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(searchType==null||searchType.equals("")) {
			searchContent = null;
		}
		
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid(); //세션에 등록한 내 아이디
		int limit = 10;
		
		try {
			List<Hire> myhirelist = service.getMyHireList(searchType,searchContent,pageNum,limit,memberid);
			int myhirecount = service.getMyhirecount(memberid, searchType, searchContent);
			
			List datelist = new ArrayList();
			Date startDate = new Date();
			Date endDate = null;
			Calendar cal = Calendar.getInstance();
			Calendar cal2 = Calendar.getInstance();
			long calDate = 0;
			long calDateDays = 0;
			for(int i =0; i<myhirelist.size(); i++) {
			endDate = myhirelist.get(i).getDeadline(); // 마감일
				calDate =endDate.getTime() - startDate.getTime();
				calDateDays = calDate / (24*60*60*1000);
				calDateDays = Math.abs(calDateDays);
				datelist.add(calDateDays);
			}
			
			
			int maxpage = (int)((double)myhirecount/limit + 0.95);
			int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
			int endpage = maxpage + 9;
			
			if(endpage > maxpage) endpage = maxpage;
			int boardcnt = myhirecount - (pageNum -1) * limit;
			
			mav.addObject("boardcnt",boardcnt);
			mav.addObject("maxpage",maxpage);
			mav.addObject("startpage",startpage);
			mav.addObject("endpage",endpage);
			mav.addObject("pageNum",pageNum);
			mav.addObject("datelist",datelist);
			mav.addObject("myhirecount",myhirecount);
			mav.addObject("myhirelist",myhirelist);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
		
}
