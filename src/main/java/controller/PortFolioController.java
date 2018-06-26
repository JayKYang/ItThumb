package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.JsyService;

@Controller
public class PortFolioController {
	@Autowired
	JsyService service;
	
	@RequestMapping("portfolio/myportfolio")
	public ModelAndView myportfolio() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}


