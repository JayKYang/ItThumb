package controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import logic.Hire;
import logic.JsyService;

@Controller
public class BoardController {
	@Autowired
	JsyService service;
	
	@RequestMapping("hire/hirelist")
	public ModelAndView hirelist (Integer pageNum, String searchType, String searchContent,HttpServletRequest request) {
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		ModelAndView mav = new ModelAndView();
		
		int limit = 10;
		return null;
	}
}
