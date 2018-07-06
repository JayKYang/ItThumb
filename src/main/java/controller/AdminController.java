package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Hire;
import logic.JsyService;
import logic.User;

@Controller
public class AdminController {
	@Autowired
	JsyService service;
	
	@RequestMapping("admin/admin")
	public ModelAndView admin(Integer membergrade,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> userList = service.userList(membergrade);
		mav.addObject("userlist", userList);
		return mav;
	}
	
	@RequestMapping("admin/superviseHire")
	public ModelAndView superviseHire(Integer pageNum ,String searchRegion, String searchEdu, String searchCarr ,String searchCareer, String searchCareerDate, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		Hire hire = new Hire();
		int limit = 10;
		pageNum = 1;
		List<Hire> hirelist = service.hirelist(searchRegion, searchEdu, searchCarr, searchCareer, searchCareerDate, pageNum, limit);
		List companylist = new ArrayList();
		for(int i=0; i<hirelist.size(); i++) {
			User name = service.getUser(hirelist.get(i).getMemberid());
			String company = name.getName();
			companylist.add(company);
		}
		System.out.println(companylist);
		mav.addObject("companylist",companylist);
		mav.addObject("pageNum",pageNum);
		mav.addObject("hirelist",hirelist);
		
		return mav;
	}
	
	@RequestMapping(value="admin/recognizeHire")
	@ResponseBody
	public HashMap<String, Object> recognizeHire(@RequestParam HashMap<String,Object> params, HttpServletRequest request) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		try {
	
		map.put("success", "success");
		} catch(Exception e) {
			e.printStackTrace();
			map.put("success","fail");
		}
		
		return map;
	}
	

}
