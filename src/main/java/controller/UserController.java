package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
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
import logic.Mail;
import logic.User;


@Controller
public class UserController {
	
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
	
	//mail 내부클래스
	private final class MyAuthenticator extends Authenticator{
	      private String id;
	      private String pw;
	      public MyAuthenticator(String id, String pw) {
	         this.id = id;
	         this.pw = pw;
	      }
	      @Override
	      protected PasswordAuthentication getPasswordAuthentication() {
	         return new PasswordAuthentication(id,pw);
	      }
	}

	@RequestMapping(value="user/joinForm", method=RequestMethod.POST)
	public ModelAndView Join(@Valid User user, BindingResult bindingResult, HttpServletRequest request, Mail mail) {
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
				mail.setNaverid("raytion07@naver.com");
				mail.setNaverpass("tmdgysl07");
				mail.setRecipient(user.getName()+"<"+user.getMemberid()+">");
				mail.setMtype("text/html;charset=utf-8");
				mail.setTitle("Itthumb 인증 메일 입니다.");
				mail.setContents("sucess");
				adminMailSend(mail);
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
	
	 private void adminMailSend(Mail mail) {
		  //입력된 네이버 이메일 주소, 또는 아이디
	      String naverid = mail.getNaverid();
	      System.out.println(mail.getNaverid()+"@@@@"+mail.getNaverpass()+"@@@@"+mail.getRecipient()+"@@@@"+mail.getMtype()+"@@@@"+mail.getTitle()+"@@@@"+mail.getContents());
	      //입력된 네이버 비밀번호
	      String naverpass= mail.getNaverpass();
	      MyAuthenticator auth = new MyAuthenticator(naverid, naverpass);
	      Properties prop = new Properties(); //맵으로 되어있음
	      FileInputStream fis = null;
	      try {
	    	 //자기 url로 바꿀것
	         File f= new File("C:\\Users\\Winhyoni\\git\\ItThumb\\mail.properties");
	         fis = new FileInputStream(f);
	         prop.load(fis);
	      }catch(IOException e) {
	         e.printStackTrace();
	      }
	      System.out.println(prop);
	      Session session = Session.getInstance(prop, auth);
	      //메일 전송 객체
	      MimeMessage msg = new MimeMessage(session);
	      try {
	    	 //보내는 사람 설정
	         msg.setFrom(new InternetAddress(naverid));
	         //받는 사람 설정
	         try {
				InternetAddress inadd = new InternetAddress(new String(mail.getRecipient().getBytes("utf-8"),"8859_1"));
				msg.setRecipient(Message.RecipientType.TO, inadd);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
	        
	         //보낸 날짜
	         msg.setSentDate(new Date());
	         msg.setSubject(mail.getTitle());
	         MimeBodyPart message = new MimeBodyPart();
	         message.setContent(mail.getContents(),mail.getMtype());
	         Transport.send(msg);
	      }catch(MessagingException me) {
	         me.printStackTrace();
	      }
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
			mav.addObject("dbUser", dbUser);
			mav.setViewName("main");
			session.setAttribute("login", dbUser.getMemberid());
		} else {
			bindingResult.reject("error.loginpassword.user");
			mav.getModel().putAll(bindingResult.getModel());
			return mav;
		}

		return mav;
	}
	
	@RequestMapping("user/mypage")
	public ModelAndView mypage(@Valid User user, BindingResult bindingResult) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
