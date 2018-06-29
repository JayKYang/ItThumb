package controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

import exception.JsyException;
import logic.JsyService;
import logic.User;
import util.HashPass;
import util.SendMail;


@Controller
public class UserController {
	//
	HashPass hp = new HashPass();
	SendMail sm = new SendMail();
	
	@Autowired
	JsyService service;
	
	@RequestMapping("main")
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
				//메일 셋팅
				sm.senmail(user.getMemberid(), user.getRecognizecode());
				
				mav.addObject("msg","회원가입이 완료되었습니다. 메일에서 인증해주세요.");
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
	
	@RequestMapping(value="confirm", method=RequestMethod.GET)
	public ModelAndView confirmCode(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String memberid = request.getParameter("id");
		String code = request.getParameter("code");
		User user = new User();
		User dbUser = service.getUser(memberid);
		user.setRecognizecode(Integer.parseInt(code));
		user.setMemberid(memberid);
		if(Integer.parseInt(code)==dbUser.getRecognizecode()) {
			service.confirmCode(user);
			mav.addObject("msg","인증성공 로그인해주세요");
			mav.addObject("url","user/login.jsy");
		}else {
			mav.addObject("msg","인증실패");
			mav.addObject("url","user/login.jsy");
			// 메일 재전송
		}
//		User user = new User();
//		mav.addObject("user", user);
		mav.setViewName("alert");
		return mav;
	}
	@RequestMapping(value="user/login", method=RequestMethod.GET)
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		User user = new User();
		mav.addObject("user", user);
		return mav;
	}
	
	@RequestMapping(value="user/login", method=RequestMethod.POST)
	public ModelAndView login(@Valid User user, BindingResult bindingResult, HttpSession session) {
		ModelAndView mav = new ModelAndView("user/login");
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			return mav;
		}

		User dbUser = service.getUser(user.getMemberid());
		if(dbUser == null) {
			bindingResult.reject("error.login.user");
			mav.getModel().putAll(bindingResult.getModel());
			return mav;
		}
		
		if(dbUser.getLocking() == 0 && dbUser.getMembergrade() == 1) {
			throw new JsyException("인증하고 로그인 해주세요.", "login.jsy");
		}else if(dbUser.getLocking() == 0 && dbUser.getMembergrade() == 2) {
			throw new JsyException("인증이 되지 않았습니다. 관리자에게 문의해주세요", "login.jsy");
		}
		
		if (dbUser.getPassword().equals(user.getPassword())) {
			//mav.setViewName("redirect:../main.jsy");
			mav.addObject("msg","로그인 되었습니다.");
			mav.addObject("url","../main.jsy");
			mav.setViewName("alert");
			session.setAttribute("login", dbUser);
		} else {
			bindingResult.reject("error.loginpassword.user");
			mav.getModel().putAll(bindingResult.getModel());
			return mav;
		}

		return mav;
	}
	
	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mav = new ModelAndView("redirect:/user/login.jsy");

		session.removeAttribute("login");
		session.invalidate();

		return mav;
	}
	
	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView delete(String id, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		mav.addObject("user", user);
		return mav; // 뷰이름만 리턴
	}
	
	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("login");
		User user = service.getUser(id);
		if (user == null) {
			throw new JsyException("삭제 대상 사용자가 존재하지 않습니다.", "delete.jsy?id=" + id);
		}
		if (loginUser.getMemberid().equals("admin")) { // 관리자인 경우
			if (!loginUser.getPassword().equals(password)) {
				throw new JsyException("관리자 비밀번호가 틀립니다.", "delete.jsy?id=" + id);
			}
		} else { // 일반사용자의 경우
			if (!user.getPassword().equals(password)) {
				throw new JsyException("비밀번호가 틀립니다.", "delete.jsy?id=" + id);
			}
		}
		try {
			service.deleteUser(id);
			if (loginUser.getMemberid().equals("admin")) {
				mav.addObject("msg",id+"회원 탈퇴가 완료되었습니다.");
				mav.addObject("url","../admin/admin.jsy");
				mav.setViewName("alert");
				return mav;
			} else { // 일반사용자로 로그인시 삭제 성공
				session.invalidate(); // 로그아웃
				mav.addObject("msg","탈퇴가 완료되었습니다.");
				mav.addObject("url","login.jsy");
				mav.setViewName("alert");
				return mav;
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new JsyException("삭제시 오류 발생", "../user/mypage.shop?id=" + id);
		}
	}


	@RequestMapping(value = "user/mypage", method = RequestMethod.GET)
	public ModelAndView updateForm(String id) {
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		mav.addObject("user", user);
		return mav; // 뷰이름만 리턴
	}
	
	@RequestMapping(value = "user/mypage", method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)request.getSession().getAttribute("login");
		User dbUser = service.getUser(user.getMemberid());
		if (loginUser.getMemberid().equals("admin")) {
			if (!user.getPassword().equals(loginUser.getPassword())) {
				throw new JsyException("관리자 비밀번호가 틀립니다.", "mypage.jsy?id=" + user.getMemberid());
			}
		} else {
			if (!user.getPassword().equals(dbUser.getPassword())) {
				throw new JsyException("비밀번호가 틀립니다.", "mypage.jsy?id=" + user.getMemberid());
			}
		}
		try {
			System.out.println(user);
			service.updateUser(user,request);
			request.getSession().setAttribute("login", user);
			mav.addObject("msg","수정이 완료되었습니다.");
			mav.addObject("url","mypage.jsy?id=" + user.getMemberid());
			mav.setViewName("alert");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	
}
