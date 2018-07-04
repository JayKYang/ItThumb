package controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("user/portfolio/myportfolio")
	public ModelAndView myportfolio() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("user/portfolio/portfolioform")
	public ModelAndView portfolioform(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String id = request.getParameter("id");
		User dbUser = service.getUser(id);
		mav.addObject("user", dbUser);
		return mav; // 뷰이름만 리턴
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
		
		SimpleDateFormat dt = new SimpleDateFormat("yyyy-mm-dd");
		
		History history = new History();
		
		int historyno = service.maxHistoryno();
		
		User loginUser = (User)request.getSession().getAttribute("login");
		
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


