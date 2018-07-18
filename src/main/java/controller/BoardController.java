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

import com.sun.mail.iap.Response;

import exception.JsyException;
import logic.CompanyInfo;
import logic.Companyhistory;
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
	
	//로그인확인
	@RequestMapping("hire/hirelist")
	public ModelAndView logconhirelist (HttpSession session,Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request){
		
	
		
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
			
			List<Hire> popBoardlist2 = service.popHirelist(4);
			List<Hire> popBoardlist = new ArrayList<Hire>();
			for(Hire h : popBoardlist2) {
				User user = service.getUser(h.getMemberid());
				h.setUser(user);
				popBoardlist.add(h);
			}
			for(int i=0; i<popBoardlist2.size(); i++) {
				strDate = formatter.format(date);
				strEndDate = formatter.format(popBoardlist2.get(i).getDeadline());
				beginDate = formatter.parse(strDate);
				endDate = formatter.parse(strEndDate);
			    diff = endDate.getTime() - beginDate.getTime();
				 diffDays = diff / (24 * 60 * 60 * 1000);
				 popDatelist.add(diffDays);
			}
			
			int listcount = service.boardcount(searchRegion, searchEdu, searchCarr,searchCareer,searchCareerDate);
			int limit = 10;
			
			List<Hire> boardlist = service.hirelist(searchRegion, searchEdu,searchCarr,searchCareer,searchCareerDate,pageNum,limit);
			
			
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
	
	//기업회원인지확인
	@RequestMapping(value="hire/hirewrite", method=RequestMethod.GET)
	public ModelAndView companyCkhirewrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("login");
		String id = user.getMemberid();
		CompanyInfo companyinfo = new CompanyInfo();
		try {
		
			int infomax = service.companyInfocount(id);
			int maxNum = service.getCompanyHistorylistMaxNum(id);
			
			
			
			if(infomax == 0) {
				mav.addObject("msg","기업세부정보를 입력해주세요.");
				mav.addObject("url","companyDetailwrite.jsy");
				mav.setViewName("alert");
			} else if(maxNum==0){
				mav.addObject("msg","연혁 및 실적 정보를 입력해주세요.");
				mav.addObject("url","companyWrite.jsy");
				mav.setViewName("alert");
			}else {
				user = service.getUser(id);
				mav.addObject("user", user);
				mav.addObject("hire", new Hire());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	//로그인확인
	@RequestMapping(value="hire/hirewrite", method=RequestMethod.POST)
	public ModelAndView logconhirewrite(HttpSession session, @Valid Hire hire, BindingResult bindingResult,HttpServletRequest request) {
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

	
	
	//로그인 확인
	@RequestMapping(value="hire/hiredetail", method=RequestMethod.GET)
	public ModelAndView logconhiredetail(HttpSession session,Integer hireno, HttpServletRequest request) throws java.text.ParseException {
		ModelAndView mav = new ModelAndView();
		User user2 = (User)request.getSession().getAttribute("login");
		String memberid = user2.getMemberid();
		
		String strDate = null;
		String strEndDate = null;
		Date beginDate = null;
		Date endDate = null;
		Date date = new Date(); // 현재 날짜
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		long diff = 0;
		long diffDays = 0;
		
		
		
		
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
		
		strDate = formatter.format(date);
		strEndDate = formatter.format(hire.getDeadline());
		beginDate = formatter.parse(strDate);
		endDate = formatter.parse(strEndDate);
	    diff = endDate.getTime() - beginDate.getTime();
		 diffDays = diff / (24 * 60 * 60 * 1000);
		
		User user = service.getUser(hire.getMemberid());
		
		mav.addObject("diffDays", diffDays);
		mav.addObject("user",user);
		mav.addObject("hire", hire);
		
		return mav;
	}
	
	//로그인 확인
	@RequestMapping("hire/hireScrap")
	   @ResponseBody
	   public HashMap<String, String> logconhireScrap(HttpSession session,@RequestParam HashMap<String, String> params, HttpServletRequest request){
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

	//로그인 확인
	@RequestMapping("hire/hireCheckScrapDelete")
	@ResponseBody
	public HashMap<String, String> logconhireCheckScrapDelete(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request){
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
	
	
	
	//기업회원 자기자신인지 확인
	@RequestMapping(value="hire/supUpdateHireForm", method=RequestMethod.GET)
	public ModelAndView myComCksupUpdateHireForm(HttpSession session ,int hireno, HttpServletRequest request,Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		String searchType = null;
		String searchContent = null;
		Hire hire = new Hire();
		
		try {
			hire = service.getHire(hireno,searchType,searchContent);
			user = service.getUser(memberid);
			System.out.println(hire);
			mav.addObject("hire",hire);
			mav.addObject("user",user);
			mav.addObject("pageNum",pageNum);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	//로그인 확인
	@RequestMapping("hire/hireUpdate")
	public ModelAndView logconhireUpdate(HttpSession session,@Valid Hire hire, BindingResult bindingResult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String file2 = request.getParameter("file2");
		Integer pageNum = Integer.parseInt(request.getParameter("pageNum"));
		int hireno = Integer.parseInt(request.getParameter("hireno"));
		User user1 = (User)request.getSession().getAttribute("login");
		String memberid = user1.getMemberid();
		String searchType = null;
		String searchContent = null;
		
		Hire hire1 = service.getHire(hireno, searchType, searchContent);
		User user = service.getUser(memberid);
		
		if(bindingResult.hasErrors()) {
				mav.getModel().putAll(bindingResult.getModel());
				mav.addObject("user",user);
				mav.addObject("hire",hire);
				return mav;
			}
		
		if(hire.getImage() == null || hire.getImage().isEmpty()) {
			if(file2.equals("")||file2 == null) {
				hire.setImageUrl(null);
			} else {
				
				hire.setImageUrl(file2); 
			}	
		}
		try {
			
			service.hireUpdate(hire,request);
			mav.setViewName("redirect:../user/mypage/myhirelist.jsy");
			
		} catch(Exception e) {
			e.printStackTrace();
			throw new JsyException("회원수정에 실패하였습니다.","supUpdateHireForm.jsy?hireno="+hireno+"&pageNum="+pageNum);
		}
		
		
		return mav;
	}
	
	//로그인 확인
	@RequestMapping("hire/deleteAction")
	@ResponseBody
	public HashMap<String, String> logcondeleteAction(HttpSession session,@RequestParam HashMap<String, String> params, HttpServletRequest request){
		HashMap<String,String> map = new HashMap<String,String>();
		User loginUser = (User)request.getSession().getAttribute("login");
		String memberid = loginUser.getMemberid();
		int hireno = Integer.parseInt(request.getParameter("hireno"));
		
		try {
			service.deleteHire(hireno);
			map.put("success", "success");
		} catch(Exception e) {
			e.printStackTrace();
			map.put("success","fail");
		}
		return map;
	}
	
	
	@RequestMapping("hire/calender")
	public ModelAndView logconcalender(HttpSession session,Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(pageNum==null||pageNum.toString().equals("")) {
			pageNum=1;
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
		List datelist = new ArrayList();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		List deadlinelist = new ArrayList();
		SimpleDateFormat deaddf = new SimpleDateFormat("MM/dd");
		try {
		int hirelistcount = service.hireboardcount(searchRegion,searchEdu,searchCarr,searchCareer,searchCareerDate);
		
		List<Hire> hirelist = service.calhirelist(searchRegion,searchEdu,searchCarr,searchCareer,searchCareerDate);
		
		for(int i=0; i<hirelist.size(); i++) {
			
			datelist.add(df.format(hirelist.get(i).getRegdate()));
			deadlinelist.add(deaddf.format(hirelist.get(i).getDeadline()));
		}
		
		
		mav.addObject("deadlinelist",deadlinelist);
		mav.addObject("pageNum",pageNum);
		mav.addObject("datelist",datelist);
		mav.addObject("hirelistcount",hirelistcount);
		mav.addObject("hirelist",hirelist);
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsyException("달력불러오기를 실패하였습니다.", "hirelist.jsy");
		}
		return mav;
	}
	
	
	@RequestMapping(value="hire/companyDetail",method=RequestMethod.GET)
	public ModelAndView logconcompanyDetail(HttpSession session,int hireno, HttpServletRequest request,Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		Hire hire = new Hire();
		String searchType= null;
		String searchContent = null;
		int limit = 3;
		CompanyInfo companyinfo = new CompanyInfo();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		
		
		User user = new User();
		try {
		hire= service.getHire(hireno, searchType, searchContent);
		
		String region = hire.getRegion();
		String regiongu = hire.getRegiongu();
		String regionetc = hire.getRegionetc();
		
		String address = region + regiongu;
		
		user= service.getUser(hire.getMemberid());
		companyinfo = service.getCompanyInfo(hire.getMemberid());
		List<Companyhistory> comHistorylist= service.getCompanyHistorylist(hire.getMemberid());
		List<Hire> hirelist = service.getMyHireList(searchType, searchContent, pageNum, limit, hire.getMemberid());
		
		int hirelistcount = service.getMyhirecount(hire.getMemberid(), searchType, searchContent);
		
		
		int maxpage = (int)((double)hirelistcount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 +1;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int boardcnt = hirelistcount - (pageNum -1) * limit;
		
		
		
		
		
		mav.addObject("address",address);
		mav.addObject("companyinfo",companyinfo);
		mav.addObject("comHistorylist",comHistorylist);
		mav.addObject("hireno",hireno);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("pageNum",pageNum);
		mav.addObject("hirelistcount",hirelistcount);
		mav.addObject("hirelist",hirelist);
		mav.addObject("hire",hire);
		mav.addObject("user",user);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="hire/companyDetailwrite",method=RequestMethod.GET)
	public ModelAndView companyCkcompanyDetailwrite(HttpSession session,HttpServletRequest request, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		if(pageNum==null|| pageNum.toString().equals("")) {
			pageNum =1;
		}
		
		User loginuser = (User)request.getSession().getAttribute("login");
		String memberid = loginuser.getMemberid();
		CompanyInfo companyinfo = new CompanyInfo();
		try {
			
		if(loginuser.getMembergrade()==2 || loginuser.getMembergrade()==0) {
			
			
			int infomax = service.companyInfocount(memberid);
			
			if(infomax==0) {
				User user = service.getUser(memberid);
				
				mav.addObject("user",user);
				mav.addObject("companyInfo",companyinfo);	
				
			} else {
				mav.addObject("msg","기업회원정보가 조회되어 연혁 및 실적 쓰기 페이지로이동합니다.");
				mav.addObject("url","companyWrite.jsy");
				mav.setViewName("alert");
			}
			
		} 
		}catch(Exception e) {
			e.printStackTrace();
			throw new JsyException("회사정보 쓰기에 실패했습니다.","hirelist.jsy");
		}
		return mav;
	}
	
	
	@RequestMapping(value="hire/companyDetailwrite",method=RequestMethod.POST)
	   public ModelAndView companyCkcompanyDetailwrite(HttpSession session,@Valid CompanyInfo companyInfo, BindingResult bindingResult,HttpServletRequest request) {
	      ModelAndView mav = new ModelAndView();
	      User loginUser = (User)request.getSession().getAttribute("login");
	      String memberid = loginUser.getMemberid();
	      companyInfo.setMemberid(memberid);
	      User user = service.getUser(memberid);
	     
	      if(bindingResult.hasErrors()) {
	         mav.getModel().putAll(bindingResult.getModel());
	         System.out.println(bindingResult.getModel());
	         //mav.addObject("user",user);
	         //mav.addObject("companyinfo",companyinfo);
	         return mav;
	      }
	      
	      
	      try {
	         service.companyDetailwrite(companyInfo);
	         mav.setViewName("redirect:/hire/companyWrite.jsy");
	         
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	      return mav;   
	   }
	
	@RequestMapping(value="hire/companyWrite",method=RequestMethod.GET)
	public ModelAndView companyCkcompanyWrite(HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Companyhistory companyhistory = new Companyhistory();
		SimpleDateFormat df = new SimpleDateFormat("yyyy");
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		CompanyInfo companyinfo = new CompanyInfo();
		
		try {
			
			int infomax = service.companyInfocount(memberid);
			
			if(infomax == 0) {
				mav.addObject("msg","기업정보를 입력해주세요");
				mav.addObject("url","companyDetailwrite.jsy");
				mav.setViewName("alert");
				
			} else {
				
				Date date = new Date();// 현재날짜
				int nowdate = Integer.parseInt(df.format(date)); // 2018
				int birth = Integer.parseInt(df.format(user.getBirth())); // 설립일 년도
				mav.addObject("birth",birth);
				mav.addObject("companyhistory",companyhistory);
			}

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;	
	}
	
	
	@RequestMapping(value="hire/companyWrite",method=RequestMethod.POST)
	public ModelAndView companyCkcompanyWrite(HttpSession session,Companyhistory companyhistory, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		String[] hisContent = companyhistory.getContent().split(",");
		String[] hisDate  = companyhistory.getHistorydate().split(",");
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		
		Companyhistory ch = new Companyhistory();
		
		try {
			
		List<Companyhistory> comhistory = service.getCompanyHistorylist(memberid);
		
		if(comhistory != null) {
			for(int i=0; i<comhistory.size(); i++) {
				int historyno = comhistory.get(i).getHistoryno();
				service.deleteCompanyhistory(historyno);
			}
		}
			
			
		for(int i=0; i<hisContent.length; i++) {
			ch.setContent(hisContent[i]);
			ch.setHistorydate(hisDate[i]);
			ch.setMemberid(memberid);
			service.insertCompanyHistory(ch);
		}
		
		mav.setViewName("redirect:../user/mypage/myPageCompanyDetail.jsy");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="hire/companyInfoUpdate",method=RequestMethod.GET)
	public ModelAndView companyCkcompanyInfoUpdate(HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)request.getSession().getAttribute("login");
		String memberid = loginUser.getMemberid();
		try {
		User user = service.getUser(memberid);
		CompanyInfo companyinfo = service.getCompanyInfo(memberid);
		
	
		mav.addObject("user",user);
		mav.addObject("companyInfo",companyinfo);
		
		System.out.println(companyinfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping(value="hire/companyInfoUpdate",method=RequestMethod.POST)
	public ModelAndView companyCkcompanyInfoUpdate(HttpSession session,@Valid CompanyInfo companyInfo, BindingResult bindingResult,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();

		User loginUser = (User)request.getSession().getAttribute("login");
	      String memberid = loginUser.getMemberid();
	      
	      if(bindingResult.hasErrors()) {
	         mav.getModel().putAll(bindingResult.getModel());
	         return mav;
	      }
	      companyInfo.setMemberid(memberid); 

	      
	      try {
	    	  service.companyInfoUpdate(companyInfo);
	    	  
	    	  mav.addObject("msg","기업정보 수정을 성공하였습니다.");
	    	  mav.addObject("url","../user/mypage/myPageCompanyDetail.jsy");
	    	  mav.setViewName("alert");
	      } catch(Exception e) {
	    	  e.printStackTrace();
	      }
	      
		
		return mav;
	}
	
	@RequestMapping("hire/comInfoDelete")
	public ModelAndView companyCkcomInfoDelete(HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		
		
		try {
			service.comInfoDelete(memberid);
			mav.setViewName("redirect:hire/hirelist.jsy");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}
	
	
	@RequestMapping(value="hire/companyHistoryUpdate",method=RequestMethod.GET)
	public ModelAndView companyCkcompanyHistoryUpdate(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("login");
		String memberid = loginUser.getMemberid();
		SimpleDateFormat df = new SimpleDateFormat("yyyy");
		Companyhistory companyhistory = new Companyhistory();
		try {
			Date date = new Date();// 현재날짜
			int nowdate = Integer.parseInt(df.format(date)); // 2018
			int birth = Integer.parseInt(df.format(loginUser.getBirth())); // 설립일 년도
			
			List<Companyhistory> comHislist = service.getCompanyHistorylist(memberid);
			int comhislistcount = service.getCompanyHistorylistCount(memberid);

			int maxNum = service.getCompanyHistorylistMaxNum(memberid);
			
			
			mav.addObject("maxNum",maxNum);
			mav.addObject("comhislistcount",comhislistcount);
			mav.addObject("companyhistory",companyhistory);
			mav.addObject("birth",birth);
			mav.addObject("comHislist",comHislist);
			
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return mav;
		
	}
	
	
	@RequestMapping(value="hire/companyHistoryreWrite",method=RequestMethod.GET)
	public ModelAndView companyCkcompanyHistoryreWrite(HttpSession session,HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Companyhistory companyhistory = new Companyhistory();
		SimpleDateFormat df = new SimpleDateFormat("yyyy");
		User user = (User)request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		CompanyInfo companyinfo = new CompanyInfo();
		try {
		
				Date date = new Date();// 현재날짜
				int nowdate = Integer.parseInt(df.format(date)); // 2018
				int birth = Integer.parseInt(df.format(user.getBirth())); // 설립일 년도
				mav.addObject("birth",birth);
				mav.addObject("companyhistory",companyhistory);
		

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return mav;	
	}
	
}
