package controller;

import java.util.List;

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
	public ModelAndView hirelist (Integer pageNum, String searchRegion, String searchEdu, String searchCarr ,HttpServletRequest request) {
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		ModelAndView mav = new ModelAndView();
		
		int listcount = service.boardcount(searchRegion, searchEdu,  searchCarr);
		
		int limit = 10;
		List<Hire> boardlist = service.hirelist(searchRegion, searchEdu,searchCarr,pageNum, limit);
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
		
		
		return mav;
	}
}
