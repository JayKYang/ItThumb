package controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import exception.JsyException;
import logic.Community;
import logic.Filerep;
import logic.JsyService;
import logic.Reply;
import logic.User;

@Controller
public class CommunityController {
	@Autowired
	JsyService service;
	
	@RequestMapping("community/comList")
	public ModelAndView comList(HttpSession session,HttpServletRequest request,Integer pageNum, String searchType, String searchContent, Integer communitykind) {
		ModelAndView mav = new ModelAndView();
		
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		
		User user = (User) session.getAttribute("login");
		
		String memberid = null;
		if(user == null) {
			memberid = null;
		}else {
			memberid = user.getMemberid();
		}
		
		int communitycount = service.Communitycount(searchType, searchContent, communitykind, memberid);
		List<Community> communityList = service.communityLlist(searchType, searchContent, pageNum, limit, communitykind, memberid);
		
		int maxpage = (int)((double)communitycount/limit + 0.95);
		int startpage = ((int)((pageNum/10.0 + 0.9) -1)) * 10 + 1 ;
		int endpage = maxpage + 9;
		if(endpage > maxpage) endpage = maxpage;
		int num = communitycount - (pageNum - 1) * limit;
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("communitycount", communitycount);
		mav.addObject("communityList", communityList);
		mav.addObject("num", num);
		mav.addObject("communitykind", communitykind);
		mav.setViewName("community/comList");
		return mav;
	}
	
	@RequestMapping(value="community/comWrite", method=RequestMethod.GET)
	public ModelAndView logconcomWrite(HttpSession session, Integer communitykind, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("community", new Community());
		mav.addObject("pageNum", pageNum);
		mav.addObject("communitykind", communitykind);
		return mav;
	}
	
	@RequestMapping(value="community/comWrite", method=RequestMethod.POST)
	public ModelAndView logconcomWriteReg(HttpSession session, @Valid Community community, BindingResult bindingResult, HttpServletRequest request, Integer communitykind, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("community", community);
			mav.addObject("communitykind", communitykind);
			mav.setViewName("community/comWrite");
			return mav;
		}
		
		int comMaxNum = service.comMaxNum()+1;
		User login = (User) request.getSession().getAttribute("login");
		String memberid = login.getMemberid();
		
		//community set
		community.setCommunityno(comMaxNum);
		community.setMemberid(memberid);
		community.setCommunitykind(communitykind);
		community.setReadcnt(0);
		
		try {
			service.comCreate(community, request);
			mav.addObject("msg","게시물이 등록되었습니다.");
			mav.addObject("url","comList.jsy?communitykind="+communitykind);
			mav.setViewName("alert");
		}catch (Exception e) {
			throw new JsyException("등록 오류", "comWrite.jsy?communitykind="+communitykind+"&pageNum="+pageNum);
		}
		return mav;
	}
	
	@RequestMapping("community/comInfo")
	public ModelAndView comInfo(Integer communityno, Integer pageNum, Integer communitykind) {
		ModelAndView mav = new ModelAndView();
		try {
			Community community = service.comSelect(communityno);
			List<Filerep> fileList = service.fileList(communityno);
			service.comReadCount(communityno);
			List<Reply> replyList = service.replyList(communityno);
			mav.addObject("replyList", replyList);
			mav.addObject("fileList", fileList);
			mav.addObject("community", community);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("reply", new Reply());
		mav.addObject("replyUpdate", new Reply());
		mav.addObject("replyRe", new Reply());
		mav.addObject("communitykind", communitykind);
		mav.addObject("pageNum",pageNum);
		mav.addObject("communityno", communityno);
		return mav;
	}
	
	@RequestMapping("community/replyCreate")
	public ModelAndView logconreplyCreate(HttpSession session, @Valid Reply reply, BindingResult bindingResult, Integer communityno, Integer communitykind, Integer pageNum) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			try {
				Community community = service.comSelect(communityno);
				List<Filerep> fileList = service.fileList(communityno);
				service.comReadCount(communityno);
				List<Reply> replyList = service.replyList(communityno);
				mav.addObject("replyList", replyList);
				mav.addObject("fileList", fileList);
				mav.addObject("community", community);
			}catch (Exception e) {
				e.printStackTrace();
			}
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("communityno", communityno);
			mav.addObject("communitykind", communitykind);
			mav.addObject("pageNum", pageNum);
			mav.addObject("reply", reply);
			mav.addObject("replyUpdate", new Reply());
			mav.addObject("replyRe", new Reply());
			mav.setViewName("community/comInfo");
			return mav;
		}
		try {
			//reply
			int ReplyMaxNum = service.replyMaxNum()+1;
			reply.setReplyno(ReplyMaxNum);
			User user = (User) session.getAttribute("login");
			String memberid = user.getMemberid();
			reply.setMemberid(memberid);
			reply.setName(user.getName());
			reply.setRef(ReplyMaxNum);
			reply.setCommunityno(communityno);
			service.replyCreate(reply);
			//info
			Community community = service.comSelect(communityno);
			List<Filerep> fileList = service.fileList(communityno);
			service.comReadCount(communityno);
			List<Reply> replyList = service.replyList(communityno);
			mav.addObject("replyList", replyList);
			mav.addObject("fileList", fileList);
			mav.addObject("community", community);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("reply", new Reply());
		mav.addObject("replyUpdate", new Reply());
		mav.addObject("replyRe", new Reply());
		mav.addObject("msg","댓글이 등록되었습니다.");
		mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("community/replyRe")
	public ModelAndView logconreplyRe(HttpSession session, @Valid Reply replyRe, BindingResult bindingResult, Integer communityno, Integer communitykind, Integer pageNum, Integer replyno) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			try {
				Community community = service.comSelect(communityno);
				List<Filerep> fileList = service.fileList(communityno);
				service.comReadCount(communityno);
				List<Reply> replyList = service.replyList(communityno);
				mav.addObject("replyList", replyList);
				mav.addObject("fileList", fileList);
				mav.addObject("community", community);
			}catch (Exception e) {
				e.printStackTrace();
			}
			mav.addObject("reply", new Reply());
			mav.addObject("replyUpdate", new Reply());
			mav.addObject("replyRe", replyRe);
			mav.addObject("msg","내용을 입력해주세요");
			mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
			mav.setViewName("alert");
			return mav;
		}
		try {
			Reply reply = service.setlectReply(replyno);
			reply.setContent(replyRe.getContent());
			User user = (User) session.getAttribute("login");
			String memberid = user.getMemberid();
			reply.setMemberid(memberid);
			reply.setName(user.getName());
			reply.setCommunityno(communityno);
			service.insertReReply(reply);
			//info
			Community community = service.comSelect(communityno);
			List<Filerep> fileList = service.fileList(communityno);
			service.comReadCount(communityno);
			List<Reply> replyList = service.replyList(communityno);
			mav.addObject("replyList", replyList);
			mav.addObject("fileList", fileList);
			mav.addObject("community", community);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("reply", new Reply());
		mav.addObject("replyUpdate", new Reply());
		mav.addObject("replyRe", new Reply());
		mav.addObject("msg","답댓글이 등록되었습니다.");
		mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("community/updateRe")
	public ModelAndView comreplyConupdateRe(HttpSession session, String memberid, Integer communitykind, Integer communityno, Integer pageNum, @Valid Reply replyUpdate, BindingResult bindingResult, Integer replyno) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			try {
				Community community = service.comSelect(communityno);
				List<Filerep> fileList = service.fileList(communityno);
				service.comReadCount(communityno);
				List<Reply> replyList = service.replyList(communityno);
				mav.addObject("replyList", replyList);
				mav.addObject("fileList", fileList);
				mav.addObject("community", community);
			}catch (Exception e) {
				e.printStackTrace();
			}
			mav.addObject("reply", new Reply());
			mav.addObject("replyUpdate", replyUpdate);
			mav.addObject("replyRe", new Reply());
			mav.addObject("msg","내용을 입력해주세요");
			mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
			mav.setViewName("alert");
			return mav;
		}
		try {
			replyUpdate.setReplyno(replyno);
			service.updateRe(replyUpdate);
			//info
			Community community = service.comSelect(communityno);
			List<Filerep> fileList = service.fileList(communityno);
			service.comReadCount(communityno);
			List<Reply> replyList = service.replyList(communityno);
			mav.addObject("replyList", replyList);
			mav.addObject("fileList", fileList);
			mav.addObject("community", community);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("reply", new Reply());
		mav.addObject("replyUpdate", new Reply());
		mav.addObject("replyRe", new Reply());
		mav.addObject("msg","댓글 수정이 완료되었습니다.");
		mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	@RequestMapping("community/replyDelete")
	public ModelAndView comreplyConreplyDelete(HttpSession session, String memberid, Integer communitykind, Integer communityno, Integer pageNum, Integer replyno) {
		ModelAndView mav = new ModelAndView();
		try {
			service.replyDelete(replyno);
			//info
			Community community = service.comSelect(communityno);
			List<Filerep> fileList = service.fileList(communityno);
			service.comReadCount(communityno);
			List<Reply> replyList = service.replyList(communityno);
			mav.addObject("replyList", replyList);
			mav.addObject("fileList", fileList);
			mav.addObject("community", community);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("reply", new Reply());
		mav.addObject("replyUpdate", new Reply());
		mav.addObject("replyRe", new Reply());
		mav.addObject("msg","댓글이 삭제 되었습니다.");
		mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping("community/communityDelete")
	public ModelAndView comreplyConcommunityDelete(HttpSession session, String memberid, Integer communitykind, Integer communityno, Integer pageNum ) {
		ModelAndView mav = new ModelAndView();
		try {
			service.comReplyDelete(communityno);
			service.communityDelete(communityno);
			service.comFileDelete(communityno);
		}catch (Exception e) {
			e.printStackTrace();
		}
		mav.addObject("msg","게시글이 삭제 되었습니다.");
		mav.addObject("url","comList.jsy?communitykind="+communitykind+"&pageNum="+pageNum);
		mav.setViewName("alert");
		return mav;
	}
	
	@RequestMapping(value="community/communityUpdate", method=RequestMethod.GET)
	public ModelAndView comreplyConcommunityUpdate(HttpSession session, String memberid, Integer communitykind, Integer communityno, Integer pageNum ) {
		ModelAndView mav = new ModelAndView();
		try {
			Community community = service.comSelect(communityno);
			mav.addObject("community", community);
			List<Filerep> fileList = service.fileList(communityno);
			mav.addObject("fileList", fileList);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		mav.addObject("pageNum", pageNum);
		mav.addObject("memberid", memberid);
		mav.addObject("communityno",communityno);
		mav.addObject("communitykind", communitykind);
		return mav;
	}
	@RequestMapping(value="community/communityUpdate", method=RequestMethod.POST)
	public ModelAndView communityUpdate(HttpSession session, String memberid, Integer communitykind, Integer communityno, Integer pageNum, @Valid Community community, BindingResult bindingResult, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		if(bindingResult.hasErrors()) {
			try {
				List<Filerep> fileList = service.fileList(communityno);
				mav.addObject("fileList", fileList);
			}catch (Exception e) {
				e.printStackTrace();
			}
			mav.getModel().putAll(bindingResult.getModel());
			mav.addObject("community", community);
			mav.addObject("memberid", memberid);
			mav.addObject("communityno", communityno);
			mav.addObject("communitykind", communitykind);
			return mav;
		}
		
		String files[] = null;
			if(community.getFiles() != null && !community.getFiles().equals("")) {
				files = community.getFiles().split(",");
			}
		community.setCommunityno(communityno);
		
		try {
			if(files != null) {
				service.comFileDelete(communityno);
				for(String fname : files) {
					Filerep filerep = new Filerep();
					filerep.setFileno(service.fileMaxNum()+1);
					filerep.setCommunityno(communityno);
					filerep.setFname(fname);
					service.fileupdate(filerep);
				}
			}
			service.comUpdate(community, request);
			mav.addObject("msg","게시물이 수정되었습니다.");
			mav.addObject("url","comInfo.jsy?communityno="+communityno+"&communitykind="+communitykind+"&pageNum="+pageNum);
			mav.setViewName("alert");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mav;
	}
}
