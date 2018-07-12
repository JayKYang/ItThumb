package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.jws.soap.SOAPBinding.Use;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import exception.JsyException;
import logic.Hire;
import logic.JsyService;
import logic.Scrap;
import logic.Study;
import logic.StudyGroup;
import logic.User;
import util.HashPass;
import util.SendMail;


@Controller
public class MypageController {
	HashPass hp = new HashPass();
	SendMail sm = new SendMail();
	
	@Autowired
	JsyService service;
	
	@RequestMapping(value="user/mypage/myInfo", method = RequestMethod.GET)
	public ModelAndView main(String id) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/myInfo");
		User user = service.getUser(id);
		mav.addObject("user", user);
		return mav;
	}
	
	@RequestMapping(value = "user/mypage/myInfo", method = RequestMethod.POST)
	public ModelAndView update(@Valid User user, BindingResult bindingResult, HttpServletRequest request) {
		System.out.println("[MypageControllerController] => user/mypage/myInfo[POST]");
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)request.getSession().getAttribute("login");
		User dbUser = service.getUser(user.getMemberid());
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.setViewName("user/mypage/myInfo.jsp?id="+loginUser.getMemberid());
			return mav;
		}
		try {
			user.setPassword(hp.password(user.getPassword()));
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		
		if (loginUser.getMembergrade()==0) { // 관리자인 경우
			if (!user.getPassword().equals(loginUser.getPassword())) {
				throw new JsyException("비밀번호가 틀립니다.", "myInfo.jsy?id=" + user.getMemberid());
			}
		} else {
			if (!user.getPassword().equals(dbUser.getPassword())) {
				throw new JsyException("비밀번호가 틀립니다.", "myInfo.jsy?id=" + user.getMemberid());
			}
		}
		try {
			service.updateUser(user,request);
			user = service.getUser(user.getMemberid());
			request.getSession().setAttribute("login", user);
			mav.addObject("msg","수정이 완료되었습니다.");
			mav.addObject("url","myInfo.jsy?id=" + user.getMemberid());
			mav.setViewName("alert");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}

	@RequestMapping("user/mypage/manageuser")
	public ModelAndView manageuser(HttpSession session,Integer pageNum, String searchType, String searchContent, Integer membergrade) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/manageuser");
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		
		int usercount = service.usercount(searchType, searchContent);
		
		List<User> userlist = service.memberlist(searchType, searchContent, membergrade, pageNum, limit);
		
		int maxpage = (int)((double)usercount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int usernum = usercount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("usercount", usercount);
		mav.addObject("userlist", userlist);
		mav.addObject("usernum", usernum);
		mav.setViewName("user/mypage/manageuser");
		return mav; 
	}
	@RequestMapping("user/mypage/manageuser_ajax")
	public ModelAndView mypage_info(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/manageuser_ajax[Ajax]");
		Integer membergrade = Integer.parseInt(request.getParameter("membergrade"));
		String id = request.getParameter("id");
		Integer pageNum = Integer.parseInt(request.getParameter("pageNum"));
		String searchType = request.getParameter("searchType");
		String searchContent = request.getParameter("searchContent");
		
		User user = service.getUser(id);
		if(membergrade == 0) {
			membergrade=null;
		}
		List<User> userlist = service.portfoliolist(null, null, membergrade, pageNum, 10);
		user.setHistoryList(service.getHistory(user.getMemberid(),null,null));
		request.getSession().setAttribute("login", user);
		
		////////////////////
		int limit = 10;
		int usercount = service.usercount(searchType, searchContent);
		int maxpage = (int)((double)usercount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int usernum = usercount - (pageNum - 1) * limit;
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("usercount", usercount);
		mav.addObject("usernum", usernum);
		//////////////////////////
		
		mav.addObject("user", user);
		mav.addObject("userlist",userlist);
		mav.addObject("pageNum",pageNum);
		mav.addObject("membergrade",membergrade);
//		System.out.println(userlist);
		return mav; 
	}
	
	@RequestMapping("user/mypage/mypageportfolio")
	public ModelAndView mypageportfolio() {
		ModelAndView mav = new ModelAndView();
		
		return mav;
	}
	@RequestMapping("user/mypage/confirmHire")
	public ModelAndView confirmHire(HttpSession session,Integer pageNum, Integer hide, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/confirmHire");
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; 
		
		int hirecount = service.hirecount(searchType, searchContent, hide); //1:보임 0: 숨김
		List<Hire> hirelist = service.getMypageHireList(searchType,searchContent,pageNum,hide,limit);
		
		int maxpage = (int)((double)hirecount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int hirenum = hirecount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("hirecount", hirecount);
		mav.addObject("hirelist", hirelist);
		mav.addObject("hirenum", hirenum);
		mav.setViewName("user/mypage/confirmHire");
		return mav; 
	}
	@RequestMapping("user/mypage/managestudy")
	public ModelAndView managestudy(HttpSession session, Integer smkind, Integer pageNum, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		User user = (User) session.getAttribute("login");
		String memberid = user.getMemberid();
		int studycount = 0;
		List<Study> studylist = null;
		int limit = 10;
		
		if(smkind == 1) {
			try {
				studycount = service.myApplyStudyCount(searchType, searchContent, memberid);
				studylist = service.myApplyStudyList(searchType, searchContent, pageNum, limit, memberid);
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		if(smkind == 2) {
			try {
				studycount = service.myScrapStudyCount(searchType, searchContent, memberid);
				studylist = service.myScrapStudyList(searchType, searchContent, pageNum, limit, memberid);	
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(smkind == 3) {
			try {
				studycount = service.myStudyCount(searchType, searchContent, memberid);
				studylist = service.myStudyList(searchType, searchContent, pageNum, limit, memberid);
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		int maxpage = (int)((double)studycount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int studynum = studycount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("studycount", studycount);
		mav.addObject("studylist", studylist);
		mav.addObject("studynum", studynum);
		mav.addObject("smkind", smkind);
		return mav;
	}
	@RequestMapping("user/mypage/portfolioscraplist")
	public ModelAndView portfolioscraplist(HttpSession session,Integer pageNum, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/portfolioscraplist");
		User loginUser = (User) session.getAttribute("login");
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; 
//		List<User> scrapmemberlist = new ArrayList<User>();
		
		int scrapmembercount = service.getScrapmembercount(searchType,searchContent,loginUser.getMemberid());
		List<User> scrapmemberlist = service.scrapmemberlist(searchType,searchContent,pageNum,limit,loginUser.getMemberid());

		
		int maxpage = (int)((double)scrapmembercount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int scrapmembernum = scrapmembercount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("scrapmembercount", scrapmembercount);
		mav.addObject("scrapmemberlist", scrapmemberlist);
		mav.addObject("scrapmembernum", scrapmembernum);
		mav.setViewName("user/mypage/portfolioscraplist");
		
		return mav;
	}
	
	@RequestMapping(value="user/mypage/recognizeHire") // 채용공고 승인
	public ModelAndView recognizeHire(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		System.out.println("[MypageController] => user/mypage/recognizeHire");
		
		int hireno = Integer.parseInt(request.getParameter("hireno"));
		try {
			service.updateHide(hireno);
		} catch(Exception e){
			e.printStackTrace();
		}
		mav.addObject("msg","승인이 완료되었습니다.");
		mav.addObject("url","confirmHire.jsy");
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("user/mypage/myStudyInfo")
	public ModelAndView myStudyInfo(Integer smkind, Integer studyno, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		try {
			Study study = service.studySelect(studyno);
			mav.addObject("study", study);
			List<User> userList = service.myStudyInfoList(studyno);
			mav.addObject("userList", userList);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("smkind", smkind);
		mav.addObject("pageNum", pageNum);
		return mav;
	}
	
	@RequestMapping("user/mypage/leaveStudy")
	public ModelAndView leaveStudy(HttpSession session,Integer smkind, Integer studyno, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("login");
		String memberid = user.getMemberid();
		try {
			service.leaveStudy(studyno, memberid);
			service.minusNowmember(studyno);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("msg","스터디 탈퇴가 완료되었습니다.");
		mav.addObject("url","managestudy.jsy?smkind="+smkind);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("user/mypage/myMkStudy")
	public ModelAndView myMkStudy(Integer smkind, Integer studyno, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		try {
			Study study = service.studySelect(studyno);
			mav.addObject("study", study);
			List<User> userList = service.myStudyInfoList(studyno);
			List<User> waitUserList = service.waitUserList(studyno);
			mav.addObject("userList", userList);
			mav.addObject("waitUserList", waitUserList);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("smkind", smkind);
		mav.addObject("pageNum", pageNum);
		return mav;
	}
	
	@RequestMapping("user/mypage/myStudyaceept")
	public ModelAndView myStudyaceept(String regmember, Integer studyno, Integer pageNum, Integer smkind,Integer state) {
		ModelAndView mav = new ModelAndView();
		Study study = service.studySelect(studyno);
		int nowmember = Integer.parseInt(study.getNowmember());
		int limitmember = Integer.parseInt(study.getLimitmember());
		try {
			if(nowmember < limitmember) {
				service.myStudyaceept(regmember, studyno, state);
				if(state==2) {
					service.plusNowmember(studyno);
				}
			}else {
				mav.addObject("msg","최대인원이 초과되었습니다.");
				mav.addObject("url","myMkStudy.jsy?smkind="+smkind+"&studyno="+studyno+"&pageNum="+pageNum);
				mav.setViewName("alert");
				return mav;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		if(state == 1) {
			mav.addObject("msg","거절되었습니다.");
		}else {
			mav.addObject("msg","수락되었습니다.");
		}
		mav.addObject("url","myMkStudy.jsy?smkind="+smkind+"&studyno="+studyno+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("user/mypage/myStudyKick")
	public ModelAndView myStudyKick(String regmember, Integer studyno, Integer pageNum, Integer smkind) {
		ModelAndView mav = new ModelAndView();
		try {
			service.myStudyKick(regmember, studyno);
			service.minusNowmember(studyno);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("msg", regmember+"님을 강퇴시켰습니다.");
		mav.addObject("url","myMkStudy.jsy?smkind="+smkind+"&studyno="+studyno+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
}
