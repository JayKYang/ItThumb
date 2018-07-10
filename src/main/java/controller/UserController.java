package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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
	@RequestMapping("close")
	public ModelAndView close() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping("user/selectJoin")
	public ModelAndView selectJoin() {
		System.out.println("[UserController] => user/selectJoin");
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	
	@RequestMapping(value="user/joinForm", method=RequestMethod.GET)
	public ModelAndView JoinForm(HttpServletRequest request) {
		System.out.println("[UserController] => user/joinForm[GET]");
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
		System.out.println("[UserController] => user/joinForm[POST]");
		String kind = request.getParameter("kind");
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			mav.addObject("kind", kind);
			if(kind.equals("1")) {
				mav.setViewName("user/userJoinForm.jsy?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsy?kind="+kind);
			}
			return mav;
		}
		if(!user.getPassword().equals(request.getParameter("passconfirm"))) {
			bindingResult.reject("error.join.password");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			mav.addObject("kind", kind);
			if(kind.equals("1")) {
				mav.setViewName("user/userJoinForm.jsy?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsy?kind="+kind);
			}
			return mav;
		}
		try {
			user.setPassword(hp.password(user.getPassword()));
			if(kind.equals("1")) {
				user.setMembergrade(1);
				user.setRecognizecode((int)(Math.random()*10000)+1000);
				user.setLocking(0);
				user.setCreatepf(0);
				service.createNormalUser(user, request);
				//메일 셋팅
				sm.senmail(user.getMemberid(), user.getRecognizecode(), "[ITThumb] 가입 인증 메일입니다.", "링크를 누르시면 인증이 완료됩니다.<br>"
						+ "<a href='http://localhost:8080/itthumb/confirm.jsy?id="+user.getMemberid()+"&code="+user.getRecognizecode()+"'>인증완료</a>");
				
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
				mav.setViewName("user/userJoinForm.jsy?kind="+kind);
			}else {
				mav.setViewName("user/companyJoinForm.jsy?kind="+kind);
			}
			return mav;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
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
		System.out.println("[UserController] => user/confirm");
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
			mav.addObject("msg","인증실패 메일 재전송 만들기");
			mav.addObject("url","user/login.jsy");
			// 메일 재전송
		}
		mav.setViewName("alert");
		return mav;
	}
	@RequestMapping(value="user/login", method=RequestMethod.GET)
	public ModelAndView login() {
		System.out.println("[UserController] => user/login[GET]");
		ModelAndView mav = new ModelAndView();
		User user = new User();
		mav.addObject("user", user);
		return mav;
	}
	
	@RequestMapping(value="user/login", method=RequestMethod.POST)
	public ModelAndView login(@Valid User user, BindingResult bindingResult, HttpSession session) {
		System.out.println("[UserController] => user/login[POST]");
		ModelAndView mav = new ModelAndView("user/login");
		String password = null;
		try {
			password = hp.password(user.getPassword());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user",user);
			return mav;
		}
		User dbUser = service.getUser(user.getMemberid());

		if(dbUser == null) {
			bindingResult.reject("error.login.user");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user",user);
			return mav;
		}
		dbUser.setHistoryList(service.getHistory(user.getMemberid()));
	
		if(dbUser.getLocking() == 0 && dbUser.getMembergrade() == 1) {
			throw new JsyException("인증하고 로그인 해주세요.", "login.jsy");
		}else if(dbUser.getLocking() == 0 && dbUser.getMembergrade() == 2) {
			throw new JsyException("인증이 되지 않았습니다. 관리자에게 문의해주세요", "login.jsy");
		}
		
		if (dbUser.getPassword().equals(password)) {
			//mav.setViewName("redirect:../main.jsy");
			mav.addObject("msg","로그인 되었습니다.");
			mav.addObject("url","../main.jsy");
			mav.setViewName("alert");
			System.out.println(dbUser);
			session.setAttribute("login", dbUser);
		} else {
			bindingResult.reject("error.loginpassword.user");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user",user);
			return mav;
		}

		return mav;
	}
	
	@RequestMapping("user/logout")
	public ModelAndView logout(HttpSession session) {
		System.out.println("[UserController] => user/logout");
		ModelAndView mav = new ModelAndView("redirect:/user/login.jsy");

		session.removeAttribute("login");
		session.invalidate();

		return mav;
	}
	
	@RequestMapping(value = "user/delete", method = RequestMethod.GET)
	public ModelAndView delete(String id, HttpSession session) {
		System.out.println("[UserController] => user/delete[GET]");
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		mav.addObject("user", user);
		return mav; // 뷰이름만 리턴
	}
	
	@RequestMapping(value = "user/delete", method = RequestMethod.POST)
	public ModelAndView delete(String id, HttpSession session, String password) {
		System.out.println("[UserController] => user/delete[POST]");
		ModelAndView mav = new ModelAndView();
		User loginUser = (User) session.getAttribute("login");
		User user = service.getUser(id);
		String pw = null;
		try {
			pw = hp.password(password);
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		if (user == null) {
			throw new JsyException("삭제 대상 사용자가 존재하지 않습니다.", "delete.jsy?id=" + id);
		}
		if (loginUser.getMembergrade()==0) { // 관리자인 경우
			if (!loginUser.getPassword().equals(pw)) {
				throw new JsyException("관리자 비밀번호가 틀립니다.", "mypage.jsy?id=" + id); // id = 탈퇴시킬 아이디 
			}
		} else { // 일반사용자의 경우
			if (!user.getPassword().equals(pw)) {
				throw new JsyException("비밀번호가 틀립니다.", "delete.jsy?id=" + id);
			}
		}
		try {
			service.deleteUser(id);
			if (loginUser.getMembergrade()==0) { // 관리자인경우
				mav.addObject("msg",id+"회원 탈퇴가 완료되었습니다.");
				mav.addObject("url","mypage.jsy?id="+id);
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
			throw new JsyException("삭제시 오류 발생", "mypage.jsy?id=" + id);
		}
	}


	@RequestMapping(value = "user/mypage", method = RequestMethod.GET)
	public ModelAndView updateForm(String id, HttpServletRequest request) {
		System.out.println("[UserController] => user/mypage[GET]");
		ModelAndView mav = new ModelAndView();
		User user = service.getUser(id);
		user.setHistoryList(service.getHistory(user.getMemberid()));
		request.getSession().setAttribute("login", user);
		System.out.println(user);
		mav.addObject("user", user);
		return mav; // 뷰이름만 리턴
	}
	
	@RequestMapping(value = "user/mypage", method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, HttpServletRequest request) {
		System.out.println("[UserController] => user/mypage[POST]");
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)request.getSession().getAttribute("login");
		User dbUser = service.getUser(user.getMemberid());
		
		try {
			user.setPassword(hp.password(user.getPassword()));
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		if (loginUser.getMembergrade()==0) { // 관리자인 경우
			if (!user.getPassword().equals(loginUser.getPassword())) {
				throw new JsyException("관리자 비밀번호가 틀립니다.", "mypage.jsy?id=" + user.getMemberid());
			}
		} else {
			if (!user.getPassword().equals(dbUser.getPassword())) {
				throw new JsyException("비밀번호가 틀립니다.", "mypage.jsy?id=" + user.getMemberid());
			}
		}
		try {
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
	@RequestMapping(value = "user/findpassword", method = RequestMethod.GET)
	public ModelAndView findpassword() {
		System.out.println("[UserController] => user/findpassword[GET]");
		ModelAndView mav = new ModelAndView();
		User user = new User();
		mav.addObject("user",user);
		return mav; // 뷰이름만 리턴
	}
	
	@RequestMapping(value = "user/findpassword", method = RequestMethod.POST)
	public ModelAndView findpassword(@Valid User user, BindingResult bindingResult) {
		System.out.println("[UserController] => user/findpassword[POST]");
		ModelAndView mav = new ModelAndView();

		User dbUser = service.getUser(user.getMemberid());
		
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			System.out.println(mav);
			return mav;
		}
		
		
		if(dbUser == null) {
//			user.setMemberid(null);
			bindingResult.reject("error.login.user");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);
			return mav;
		}
		
		//메일 셋팅
		dbUser.setRecognizecode((int)(Math.random()*10000)+1000);
		System.out.println(dbUser);
		service.updateRecognize(dbUser); // 인증번호 재발급
		sm.senmail(dbUser.getMemberid(), dbUser.getRecognizecode(), "[ITThumb] 비밀번호 분실확인 메일", "링크를 누르시면 비밀번호 변경화면으로 이동됩니다.<br>"
				+ "<a href='http://localhost:8080/itthumb/passconfirm.jsy?id="+dbUser.getMemberid()+"&code="+dbUser.getRecognizecode()+"'>비밀번호 변경하로 가기</a>");
		
		mav.addObject("msg","메일 전송이 완료되었습니다. 이메일을 확인해주세요.");
		mav.addObject("url","../close.jsy");
		mav.setViewName("alert");
		
		return mav; // 뷰이름만 리턴
	}
	@RequestMapping(value="passconfirm", method=RequestMethod.GET)
	public ModelAndView passconfirm(HttpServletRequest request) {
		System.out.println("[UserController] => user/passconfirm");
		ModelAndView mav = new ModelAndView();
		String memberid = request.getParameter("id");
		String code = request.getParameter("code");
		User user = new User();
		User dbUser = service.getUser(memberid);
		user.setRecognizecode(Integer.parseInt(code));
		user.setMemberid(memberid);
		if(Integer.parseInt(code)==dbUser.getRecognizecode()) {
			service.confirmCode(user);
			mav.addObject("msg","인증성공, 비밀번호 변경 창으로 이동합니다.");
			mav.addObject("url","user/repasswordform.jsy?id="+memberid);
		}else {
			mav.addObject("msg","인증실패 메일 재전송 만들기");
			mav.addObject("url","user/login.jsy");
			// 메일 재전송
		}
		mav.setViewName("alert");
		return mav;
	}
	@RequestMapping(value="user/repasswordform", method=RequestMethod.GET)
	public ModelAndView repasswordform(HttpServletRequest request) {
		System.out.println("[UserController] => user/repasswordform[GET]");
		ModelAndView mav = new ModelAndView();
		User dbUser = service.getUser(request.getParameter("id"));
		mav.addObject("user",dbUser);
		return mav;
	}
	@RequestMapping(value="user/repasswordform", method=RequestMethod.POST)
	public ModelAndView repassword(@Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("[UserController] => user/repasswordform[POST]");
		ModelAndView mav = new ModelAndView();

		User dbUser = service.getUser(user.getMemberid());
		
		if(!user.getPassword().equals(request.getParameter("passconfirm"))) {
			bindingResult.reject("error.join.password");
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("user", user);			
			return mav;
		}
		
		try {
			user.setPassword(hp.password(user.getPassword()));
			service.repassword(user);
			mav.addObject("msg","비밀번호 변경 성공. 로그인 해주세요.");
			mav.addObject("url","login.jsy");
			mav.setViewName("alert");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return mav;
	}
}
