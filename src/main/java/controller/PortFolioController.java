package controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

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

import logic.History;
import logic.JsyService;
import logic.Project;
import logic.Scrap;
import logic.User;

@Controller
public class PortFolioController {
	@Autowired
	JsyService service;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}
	
	@RequestMapping("user/portfolio/myportfolio")
	public ModelAndView PfConmyportfolio(HttpSession session ,String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.getUser(id);
		User loginUser = (User) request.getSession().getAttribute("login");
		Scrap scrap = service.portfolioScrapConfirm(loginUser.getMemberid(), id);
		if(scrap == null) {
			mav.addObject("scrapConfirm",0);
		}else {
			mav.addObject("scrapConfirm",1);
		}
		dbUser.setHistoryList(service.getHistory(id,null,null));
		request.getSession().setAttribute("user", dbUser);
		List<Project> project = service.getProject(id);
		mav.addObject("projectList",project);
		if(dbUser.getCreatepf()==0) {
			if(id.equals(loginUser.getMemberid())) {
				mav.addObject("msg","포트폴리오가 없습니다. 작성페이지로 이동합니다.");
				mav.addObject("url","portfolioform.jsy?id="+id);
			}else {
				mav.addObject("msg","해당 유저의 포트폴리오는 없습니다.");
				mav.addObject("url","../../main.jsy?id="+id);
			}
			mav.setViewName("alert");
		}
		return mav;
	}
	
	@RequestMapping("user/portfolio/portfolioform")
	public ModelAndView myPfConportfolioform(HttpSession session ,String id, HttpServletRequest request) {
		System.out.println("[PortFolioController] => user/portfolio/portfolioform");
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) request.getSession().getAttribute("login");
		User dbUser = service.getUser(id);
		dbUser.setHistoryList(service.getHistory(dbUser.getMemberid(),null,null));
		request.getSession().setAttribute("login", dbUser);
		List<Project> project = service.getProject(id);
		
		if(id.equals(loginUser.getMemberid())) {
			mav.addObject("user", dbUser);
			mav.addObject("projectList",project);
		}else {
			mav.addObject("msg","해당 경로로 접근이 불가합니다.");
			mav.addObject("url","../../main.jsy?id="+id);
			mav.setViewName("alert");
		}
		
		
		return mav;
	}
	@RequestMapping("user/portfolio/deleteportfolio")
	public ModelAndView myPfCondeleteportfolio(HttpSession session ,String id, HttpServletRequest request) {
		System.out.println("[PortFolioController] => user/portfolio/deleteportfolio");
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) request.getSession().getAttribute("login");
		User dbUser = service.getUser(id);
		
		if (loginUser.getMembergrade()==0) {  // 관리자인경우
			service.deleteportfolio(id);
			mav.addObject("msg",id+"님의 포트폴리오를 삭제하였습니다.");
			mav.addObject("url","../mypage.jsy?id=" + loginUser.getMemberid());
		}else {
			if(id.equals(loginUser.getMemberid())) {
				service.deleteportfolio(id);
				dbUser.setHistoryList(service.getHistory(dbUser.getMemberid(),null,null));
				request.getSession().setAttribute("login", dbUser);
				mav.addObject("msg","포트폴리오 삭제를 완료했습니다.");
				mav.addObject("url","../mypage/mypageportfolio.jsy?id="+id);
			}else {
				mav.addObject("msg","해당 경로로 접근이 불가합니다.");
				mav.addObject("url","../../main.jsy?id="+id);
			}
		}
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping(value="user/portfolio/updateAboutMe", method=RequestMethod.POST)
	public ModelAndView myPfConupdateAboutMe(HttpSession session ,String id, @Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("[PortFolioController] => user/portfolio/updateAboutMe[POST]");
		System.out.println(user);
		User loginUser = (User)request.getSession().getAttribute("login");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:portfolioform.jsy?id="+user.getMemberid());
//		if(bindingResult.hasErrors()) {
//			System.out.println("[PortFolioController] => user/portfolio/updateAboutMe[POST] => bindingResult Err");
//			mav.getModel().putAll(bindingResult.getModel());
//			return mav;
//		}
		if(user.getMemberid().equals(loginUser.getMemberid())) {
			user.setCreatepf(1);
			service.updateUserAboutMe(user, request);
			User dbUser = service.getUser(user.getMemberid());
			dbUser.setHistoryList(service.getHistory(dbUser.getMemberid(),null,null));
			request.getSession().setAttribute("login", dbUser);
			mav.addObject("user", dbUser);
		}else {
			mav.addObject("msg","해당 경로로 접근이 불가합니다.");
			mav.addObject("url","../../main.jsy?id="+loginUser.getMemberid());
		}
		
		
		return mav; 
	}
	
	@RequestMapping("user/portfolio/insertExperience")
	@ResponseBody
	public HashMap<String,String> logconinsertExperience(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("success", "success");
		
		System.out.println("[PortFolioController] => user/portfolio/insertExperience");
		Date getdate = null;
		Date enddate = null;
		String content = null;
		String skillful = null;

		User loginUser = (User)request.getSession().getAttribute("login");
		
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-mm-dd");
		
		History history = new History();
		
		
		
		int historyno = service.maxHistoryno();
		history.setHistoryno(++historyno);
		history.setMemberid(loginUser.getMemberid());
		if(request.getParameter("kindno")!=null && request.getParameter("kindno")!="") {
			history.setKindno(Integer.parseInt(request.getParameter("kindno")));
		}
		if(request.getParameter("getdate")!=null && request.getParameter("getdate")!="") {
			try {
				getdate = dt.parse(request.getParameter("getdate"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			history.setGetdate(getdate);
		}
		if(request.getParameter("enddate")!=null && request.getParameter("enddate")!="") {
				try {
					enddate = dt.parse(request.getParameter("enddate"));
				} catch (ParseException e) {
					e.printStackTrace();
				}
			history.setEnddate(enddate);
		}
		if(request.getParameter("content")!=null && request.getParameter("content")!="") {
			content = request.getParameter("content");
			history.setContent(content);
		}
		if(request.getParameter("skillful")!=null && request.getParameter("skillful")!="") {
			skillful = request.getParameter("skillful");
			history.setSkillful(Integer.parseInt(skillful));
		}
		service.insertHistory(history);
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid(),null,null));
		request.getSession().setAttribute("login", loginUser);
		
		map.put("historyno", historyno+"");
		
		return map;
	}
	
	@RequestMapping("user/portfolio/updateExperience")
	@ResponseBody
	public HashMap<String,String> logconupdateExperience(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("success", "success");
		
		System.out.println("[PortFolioController] => user/portfolio/updateExperience");
		Date getdate = null;
		Date enddate = null;
		String content = null;
		String skillful = null;
		
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-mm-dd");
		History history = new History();
		
		User loginUser = (User)request.getSession().getAttribute("login");
		
		history.setMemberid(loginUser.getMemberid());
		if(request.getParameter("historyno")!=null && request.getParameter("historyno")!="") {
			history.setHistoryno(Integer.parseInt(request.getParameter("historyno")));
		}
		if(request.getParameter("kindno")!=null && request.getParameter("kindno")!="") {
			history.setKindno(Integer.parseInt(request.getParameter("kindno")));
		}
		if(request.getParameter("getdate")!=null && request.getParameter("getdate")!="") {
			
			try {
				getdate = dt.parse(request.getParameter("getdate"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			history.setGetdate(getdate);
		}
		if(request.getParameter("enddate")!=null && request.getParameter("enddate")!="") {
			try {
				enddate = dt.parse(request.getParameter("enddate"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			history.setEnddate(enddate);
		}
		if(request.getParameter("content")!=null && request.getParameter("content")!="") {
			content = request.getParameter("content");
			history.setContent(content);
		}
		if(request.getParameter("skillful")!=null && request.getParameter("skillful")!="") {
			skillful = request.getParameter("skillful");
			history.setSkillful(Integer.parseInt(skillful));
		}
		System.out.println(history);
		service.updateHistory(history);
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid(),null,null));
		request.getSession().setAttribute("login", loginUser);
		
		return map;
	}
	
	@RequestMapping("user/portfolio/deleteExperience")
	@ResponseBody
	public HashMap<String,String> logcondeleteExperience(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		System.out.println("[PortFolioController] => user/portfolio/deleteExperience");
		
		int historyno = Integer.parseInt(request.getParameter("historyno"));
		
		User loginUser = (User)request.getSession().getAttribute("login");
		
		service.deleteHistory(historyno);
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid(),null,null));
		map.put("success", "success");
		request.getSession().setAttribute("login", loginUser);
		
		return map;
	}
	
	@RequestMapping(value = "user/portfolio/projectform", method = RequestMethod.GET)
	public ModelAndView myPfConprojectform(HttpSession session, String id, String projectno, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[PortFolioController] => user/portfolio/projectform[GET]");
		User dbUser = service.getUser(id);
		dbUser.setHistoryList(service.getHistory(dbUser.getMemberid(),null,null));
		request.getSession().setAttribute("login", dbUser);
		Project project = new Project();
		System.out.println(projectno);
		if(projectno != null) {
			project = service.getProject(id,projectno);
			mav.addObject("pno",projectno);
		}
		mav.addObject("project",project);
		System.out.println(project);
		mav.addObject("user", dbUser);
		return mav;
	}
	@RequestMapping(value = "user/portfolio/projectform", method = RequestMethod.POST)
	public ModelAndView logconinsertproject(HttpSession session, Project project, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[PortFolioController] => user/portfolio/projectform[POST]");
		User loginUser = (User) request.getSession().getAttribute("login"); 

		System.out.println(project);
		if(project.getProjectno()==0) { // insert
			int pno = service.maxProjectno();
			project.setProjectno(++pno);
			service.insertproject(project,request);
			mav.addObject("msg","등록 완료.");
		}else {
			service.updateproject(project,request);
			mav.addObject("msg","수정 완료.");
		}
		
		mav.addObject("url","portfolioform.jsy?id="+loginUser.getMemberid()+"#project");
		mav.setViewName("alert");
		
		return mav;
	}
	
	@RequestMapping("user/portfolio/deleteproject")
	public ModelAndView myPfCondeleteproject(HttpSession session, String id, String projectno, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[PortFolioController] => user/portfolio/deleteproject");
		User dbUser = service.getUser(id);
		request.getSession().setAttribute("login", dbUser);
		service.deleteProject(projectno);
//		mav.addObject("user", dbUser);
		mav.addObject("msg","삭제 완료.");
		mav.addObject("url","portfolioform.jsy?id="+id+"#project");
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("user/portfolio/portfoliolist")
	public ModelAndView companyConsearchportfolio(HttpSession session,Integer pageNum, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[PortFolioController] => user/portfolio/portfoliolist");
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		
		int portfoliocount = service.portfoliocount(searchType, searchContent, 1);
		List<User> userlist = service.portfoliolist(searchType, searchContent,null, pageNum, limit);
		List<User> portfoliolist = new ArrayList<User>();
		
		for(User user : userlist) {
			user.setHistoryList(service.getHistory(user.getMemberid(),null,null));
			portfoliolist.add(user);
			
		}
		
		
		int maxpage = (int)((double)portfoliocount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int portfolionum = portfoliocount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("portfoliocount", portfoliocount);
		mav.addObject("portfoliolist", portfoliolist);
		mav.addObject("portfolionum", portfolionum);
		
		mav.setViewName("user/portfolio/portfoliolist");
		return mav;
	}
	
	@RequestMapping("user/portfolio/portfolioScrap")
	@ResponseBody
	public HashMap<String, String> logconportfolioScrap(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request){
		 HashMap<String, String> map = new HashMap<String, String>();
		 System.out.println("[PortFolioController] => user/portfolio/portfolioScrap");
		 String loginid = request.getParameter("memberid");
		 String scrapid = request.getParameter("memberid2");
		 
		 System.out.println(loginid + "," + scrapid);
		 Scrap scrap = service.portfolioScrapConfirm(loginid, scrapid);
		 if(scrap == null) {
			 int scrapMaxnum = service.ScrapMaxnum()+1;
			 Scrap insertScrap = new Scrap();
			 insertScrap.setScrap(scrapMaxnum);
			 insertScrap.setMemberid(loginid);
			 insertScrap.setScrapmember(scrapid);
			 try {
				 service.studyScrapInsert(insertScrap);
			 }catch (Exception e) {
				e.printStackTrace();
			 }
			 map.put("success", "success");
		 }else {
			 try {
				 service.studyScrapDelete(scrap.getScrap());
			 }catch (Exception e) {
				e.printStackTrace();
			 }
			 map.put("success", "delete");
		 }
		 return map;
	}
	
}


