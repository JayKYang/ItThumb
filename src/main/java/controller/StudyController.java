package controller;



import java.util.HashMap;
import java.util.List;

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

import logic.JsyService;
import logic.Scrap;
import logic.Study;
import logic.StudyGroup;
import logic.User;

@Controller
public class StudyController {
	@Autowired
	JsyService service;
	
	@RequestMapping("study/studySearchList")
	public ModelAndView logconstudySearchList(HttpSession session,Integer pageNum, String searchType, String searchContent) {
		ModelAndView mav = new ModelAndView();
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		
		int studycount = service.studycount(searchType, searchContent);
		List<Study> studylist = service.studylist(searchType, searchContent, pageNum, limit);
		
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
		mav.setViewName("study/studySearchList");
		return mav;
	}
	
	
	@RequestMapping(value="study/studyWrite", method=RequestMethod.GET)
	public ModelAndView logconstudyWrite(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("study", new Study());
		return mav;
	}
	
	@RequestMapping(value="study/studyWrite", method=RequestMethod.POST)
	public ModelAndView logconstudyWriteReg(HttpSession session, @Valid Study study, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("study", study);
			return mav;
		}
		User user = (User) request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		String membername = user.getName();
		
		study.setMemberid(memberid);
		study.setMembername(membername);
		study.setNowmember("1");
		
		//스터디번호
		try {
			int max = service.studyMaxNum()+1;
			study.setStudyno(max);
			service.studyWrite(study);
			
			//studygroup leader 등록
			StudyGroup sg = new StudyGroup();
			sg.setGroupno(service.studyGroupMaxNum()+1);
			sg.setStudyno(max);
			sg.setLeadermember(memberid);
			sg.setState(4); // state : 4 리더
			service.studyGroupLeaderSet(sg);
			
			mav.addObject("msg","등록 성공");
			mav.addObject("url","studySearchList.jsy");
			mav.setViewName("alert");
		}catch (Exception e) {
			mav.addObject("study", study);
			mav.addObject("msg","등록 실패");
			mav.addObject("url","studyWrite.jsy");
			mav.setViewName("alert");
			return mav;
		}
		return mav;
	}
	
	@RequestMapping("study/studyInfo")
	public ModelAndView logconstudyInfo(HttpSession session, Integer studyno, Integer pageNum, HttpServletRequest request, Integer smkind) {
		ModelAndView mav = new ModelAndView();
		User user = (User) request.getSession().getAttribute("login");
		String memberid = user.getMemberid();
		Study study = service.studySelect(studyno);
		
		Scrap scrap = service.scrapComfirm(studyno, memberid);
		 if(scrap == null) {
			 mav.addObject("scrapComfirm",0);
		 }else {
			 mav.addObject("scrapComfirm",1);
		 }
		 
		StudyGroup studygroup = service.studyGroupComfirm(studyno, memberid);
		 if(studygroup == null) {
			 mav.addObject("studyGroupComfirm",0);
		 }else {
			 mav.addObject("studyGroupComfirm",1);
		 }
		
		 if(smkind == null) {
			 smkind = 0;
		 }
		mav.addObject("smkind", smkind); 
		 
		mav.addObject("study", study);
		mav.addObject("studyno",studyno);
		mav.addObject("memberid", memberid);
		mav.addObject("writememberid", study.getMemberid());
		mav.addObject("pageNum", pageNum);
		return mav;
	}
	
	@RequestMapping(value="study/studyUpdate", method=RequestMethod.GET)
	public ModelAndView studyConstudyUpdate(HttpSession session, String memberid, Integer studyno, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		try {
			Study study = service.studySelect(studyno);
			mav.addObject("study", study);
			mav.addObject("pageNum", pageNum);
		}catch (Exception e) {
			mav.addObject("msg","수정 실패");
			mav.addObject("url","studyInfo.jsy?pageNum="+pageNum+"&studyno="+studyno);
			mav.setViewName("alert");
			return mav;
		}
		return mav;
	}
	@RequestMapping(value="study/studyUpdate", method=RequestMethod.POST)
	public ModelAndView logconstudyUpdateReg(HttpSession session, @Valid Study study, BindingResult bindingResult, HttpServletRequest request, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("memberid", study.getMemberid());
			mav.addObject("studyno", study.getStudyno());
			mav.addObject("pageNum", pageNum);
			mav.addObject("study", study);
			return mav;
		}
		
		//스터디번호
		try {
			service.studyUpdate(study);
			mav.addObject("msg","수정 성공");
			mav.addObject("url","studyInfo.jsy?pageNum="+pageNum+"&studyno="+study.getStudyno());
			mav.setViewName("alert");
		}catch (Exception e) {
			mav.addObject("study", study);
			mav.addObject("msg","수정 실패");
			mav.addObject("url","studyUpdate.jsy?pageNum="+pageNum+"&studyno="+study.getStudyno()+"&memberid="+study.getMemberid());
			mav.setViewName("alert");
			return mav;
		}
		return mav;
	}
	
	@RequestMapping("study/studyScrap")
	@ResponseBody
	public HashMap<String, String> logconstudyScrap(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request){
		 HashMap<String, String> map = new HashMap<String, String>();
		 int studyno = Integer.parseInt(request.getParameter("studyno"));
		 String memberid = request.getParameter("memberid");
		 Scrap scrap = service.scrapComfirm(studyno, memberid);
		 if(scrap == null) {
			 int scrapMaxnum = service.ScrapMaxnum()+1;
			 Scrap insertScrap = new Scrap();
			 insertScrap.setScrap(scrapMaxnum);
			 insertScrap.setMemberid(memberid);
			 insertScrap.setStudyno(studyno);
			 try {
				 service.studyScrapInsert(insertScrap);
			 }catch (Exception e) {
				e.printStackTrace();
			 }
			 map.put("success", "success");
		 }else {
			 try {
				 service.studyScrapDelete(scrap.getScrap());
			 }catch (Exception e) {
				e.printStackTrace();
			 }
			 
			 map.put("success", "delete");
		 }
		 return map;
	}
	
	@RequestMapping("study/studyApply")
	@ResponseBody
	public HashMap<String, String> logconstudyApply(HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request){
		 HashMap<String, String> map = new HashMap<String, String>();
		 int studyno = Integer.parseInt(request.getParameter("studyno"));
		 String regmember = request.getParameter("regmember");
		 
		 //작성자 값 불러오기 위해서
		 Study study = service.studySelect(studyno);
		 int nowmember = Integer.parseInt(study.getNowmember());
		 int limitmember = Integer.parseInt(study.getLimitmember());
		 
		 //세션아이디가 신청했는지 확인
		 StudyGroup studyGroup = service.studyGroupComfirm(studyno, regmember);
		 
		 System.out.println("studyGroup:"+studyGroup);
		 
		 if(studyGroup == null) {
			 if(nowmember < limitmember) {
				 int studyGroupMaxNum = service.studyGroupMaxNum()+1;
				 StudyGroup studyGroupInsert = new StudyGroup();
				 studyGroupInsert.setGroupno(studyGroupMaxNum);
				 studyGroupInsert.setStudyno(studyno);
				 studyGroupInsert.setLeadermember(study.getMemberid());
				 studyGroupInsert.setRegmember(regmember);
				 studyGroupInsert.setState(0);
				 
				 try {
					 service.studyGroupInsert(studyGroupInsert);
				 }catch (Exception e) {
					e.printStackTrace();
				 }
				 map.put("success", "success");
			 }else {
				map.put("success", "excess"); 
			 }
		 }else {
			 if(studyGroup.getState()==0) {
				 try {
					 service.studyGroupDelete(studyGroup.getGroupno());
				 }catch (Exception e) {
					e.printStackTrace();
				 }
				 map.put("success", "delete");
			 }else if(studyGroup.getState()==1) {
				 map.put("success", "reject");
			 }else if(studyGroup.getState()==2) {
				map.put("success", "accept"); 
			 }
		 }
		 return map;
	}
	
	@RequestMapping("study/studyDelete")
	public ModelAndView studyConstudyDelete(HttpSession session, String memberid, Integer studyno, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		System.out.println(studyno);
		try {
			service.studyGroupAllDelete(studyno);
			service.scrapAllDelete(studyno);
			service.studyDelete(studyno);
			mav.addObject("msg","삭제 성공");
			mav.addObject("url","studySearchList.jsy?pageNum="+pageNum);
			mav.setViewName("alert");
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg","삭제 실패");
			mav.addObject("url","studyInfo.jsy?pageNum="+pageNum+"&studyno="+studyno);
			mav.setViewName("alert");
			return mav;
		}
		return mav;
	}
}
