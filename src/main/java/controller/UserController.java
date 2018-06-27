package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import logic.JsyService;
import logic.User;


@Controller
public class UserController {
	
	@Autowired
	JsyService service;
	
	@RequestMapping("main.jsy")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	@RequestMapping("user/selectJoin")
	public ModelAndView selectJoin() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping(value="user/joinForm", method=RequestMethod.GET)
	public ModelAndView JoinForm(HttpServletRequest request) {
		String kind = request.getParameter("kind");
		ModelAndView mav = new ModelAndView();
		if(kind.equals("1")) {
			mav.setViewName("user/userJoinForm");
		}else {
			mav.setViewName("user/companyJoinForm");
		}
		User user = new User();
		mav.addObject("user", user);
		mav.addObject("kind", kind);
		return mav;
	}

	@RequestMapping(value="user/joinForm", method=RequestMethod.POST)
	public ModelAndView Join(@Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		String kind = request.getParameter("kind");
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			mav.addObject("kind", kind);
			if(kind.equals("1")) {
				mav.setViewName("user/userJoinForm.jsp?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsp?kind="+kind);
			}
			return mav;
		}
		if(!user.getPassword().equals(request.getParameter("passconfirm"))) {
			bindingResult.reject("error.join.password");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			mav.addObject("kind", kind);
			if(kind.equals("1")) {
				mav.setViewName("user/userJoinForm.jsp?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsp?kind="+kind);
			}
			return mav;
		}
		try {
			if(kind.equals("1")) {
				user.setMembergrade(1);
				user.setRecognizecode((int)(Math.random()*10000)+1000);
				user.setLocking(0);
				user.setCreatepf(0);
				service.createNormalUser(user, request);
				mav.addObject("msg","회원가입이 완료되었습니다.");
				mav.addObject("url","login.jsy");
				mav.setViewName("alert");
			}else {
				user.setMembergrade(2);
				user.setLocking(0);
				service.createCompanyUser(user,request);
				mav.addObject("msg","회원가입이 완료되었습니다.");
				mav.addObject("url","login.jsy");
				mav.setViewName("alert");
			}
		}catch (DataIntegrityViolationException e) {
			bindingResult.reject("error.duplicate.user");
			mav.addObject("user", user);
			mav.addObject("kind", kind);
			if(kind.equals("1")) {
				mav.setViewName("user/userJoinForm.jsp?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsp?kind="+kind);
			}
			return mav;
		}
		return mav;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}
	
	@RequestMapping(value="user/login", method=RequestMethod.GET)
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		User user = new User();
		mav.addObject("user", user);
		return mav;
	}
	
	@RequestMapping("user/mypage")
	public ModelAndView mypage() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
