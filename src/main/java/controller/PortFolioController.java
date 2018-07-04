package controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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
	public ModelAndView myportfolio(String id, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.getUser(id);
		User loginUser = (User) request.getSession().getAttribute("login");
		dbUser.setHistoryList(service.getHistory(id));
		request.getSession().setAttribute("user", dbUser);
		
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
	public ModelAndView portfolioform(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		User loginUser = (User) request.getSession().getAttribute("login");
		User dbUser = service.getUser(id);
		if(id.equals(loginUser.getMemberid())) {
			mav.addObject("user", dbUser);
		}else {
			mav.addObject("msg","해당 경로로 접근이 불가합니다.");
			mav.addObject("url","../../main.jsy?id="+id);
			mav.setViewName("alert");
		}
		return mav;
	}
	@RequestMapping("user/portfolio/deleteportfolio")
	public ModelAndView deleteportfolio(HttpServletRequest request) {
		System.out.println("[PortFolioController] => user/portfolio/deleteportfolio");
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		User loginUser = (User) request.getSession().getAttribute("login");
		User dbUser = service.getUser(id);
		
		if (loginUser.getMembergrade()==0) {  // 관리자인경우
			service.deleteportfolio(id);
			mav.addObject("msg",id+"님의 포트폴리오를 삭제하였습니다.");
			mav.addObject("url","../mypage.jsy?id=" + loginUser.getMemberid());
		}else {
			if(id.equals(loginUser.getMemberid())) {
				service.deleteportfolio(id);
				dbUser.setHistoryList(service.getHistory(dbUser.getMemberid()));
				request.getSession().setAttribute("login", dbUser);
				mav.addObject("msg","포트폴리오 삭제를 완료했습니다.");
				mav.addObject("url","../mypage.jsy?id="+id);
			}else {
				mav.addObject("msg","해당 경로로 접근이 불가합니다.");
				mav.addObject("url","../../main.jsy?id="+id);
			}
		}
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping(value="user/portfolio/updateAboutMe", method=RequestMethod.POST)
	public ModelAndView updateAboutMe(@Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("[PortFolioController] => user/portfolio/updateAboutMe[POST]");
		System.out.println(user);
		User loginUser = (User)request.getSession().getAttribute("login");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:portfolioform.jsy?id=test@test.test");
//		if(bindingResult.hasErrors()) {
//			System.out.println("[PortFolioController] => user/portfolio/updateAboutMe[POST] => bindingResult Err");
//			mav.getModel().putAll(bindingResult.getModel());
//			return mav;
//		}
		if(user.getMemberid().equals(loginUser.getMemberid())) {
			user.setCreatepf(1);
			service.updateUserAboutMe(user, request);
			User dbUser = service.getUser(user.getMemberid());
			dbUser.setHistoryList(service.getHistory(dbUser.getMemberid()));
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
	public HashMap<String,String> insertExperience(@RequestParam HashMap<String, String> params, HttpServletRequest request) {
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
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid()));
		request.getSession().setAttribute("login", loginUser);
		
		map.put("historyno", historyno+"");
		
		return map;
	}
	
	@RequestMapping("user/portfolio/updateExperience")
	@ResponseBody
	public HashMap<String,String> updateExperience(@RequestParam HashMap<String, String> params, HttpServletRequest request) {
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
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid()));
		request.getSession().setAttribute("login", loginUser);
		
		return map;
	}
	
	@RequestMapping("user/portfolio/deleteExperience")
	@ResponseBody
	public HashMap<String,String> deleteExperience(@RequestParam HashMap<String, String> params, HttpServletRequest request) {
		HashMap<String, String> map = new HashMap<String, String>();
		
		System.out.println("[PortFolioController] => user/portfolio/deleteExperience");
		
		int historyno = Integer.parseInt(request.getParameter("historyno"));
		
		User loginUser = (User)request.getSession().getAttribute("login");
		
		service.deleteHistory(historyno);
		
		loginUser.setHistoryList(service.getHistory(loginUser.getMemberid()));
		map.put("success", "success");
		request.getSession().setAttribute("login", loginUser);
		
		return map;
	}
}


