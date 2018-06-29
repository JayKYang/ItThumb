package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
}


