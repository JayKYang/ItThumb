package aop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import exception.JsyException;
import exception.MessageException;
import logic.Hire;
import logic.JsyService;
import logic.Message;
import logic.StudyGroup;
import logic.User;

@Component
@Aspect
public class AopAspect {
	@Autowired
	JsyService service;

	///////////////////////////////////// 전체
	///////////////////////////////////// 로그인////////////////////////////////////////
	// 로그인확인
	@Around("execution(* controller.*.logcon*(..))")
	public Object userLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = null;
		session = (HttpSession) joinPoint.getArgs()[0]; // session
		String path = session.getServletContext().getContextPath()+"/";
		User login = (User) session.getAttribute("login");
		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	

	////////////////////////////////// user///////////////////////////////////////////////
	@Around("execution(* controller.User*.adCk*(..))")
	public Object userAdminCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	//////////////////////////////// message//////////////////////////////////////////////
	// 메세지 로그인 확인
	@Around("execution(* controller.*.mesLogCon*(..))")
	public Object MessageLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = null;
		session = (HttpSession) joinPoint.getArgs()[0];
		String path = session.getServletContext().getContextPath()+"/";
		User login = (User) session.getAttribute("login");
		if (login == null) {
			throw new MessageException("로그인을 해야합니다.");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	// 선생님한테 물어보기
	@Around("execution(* controller.Message*.mesIfCk*(..))")
	public Object MessageInfoCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = "아이디 없음";

		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new MessageException("로그인을 해야합니다.");
		}

		if (joinPoint.getArgs()[1] instanceof Integer) {
			int messageno = (int) joinPoint.getArgs()[1];
			Message ms = service.messageSelect(messageno);
			if (ms.getSender().equals(login.getMemberid())) {
				id = ms.getSender();
			}
			if (ms.getReceiver().equals(login.getMemberid())) {
				id = ms.getReceiver();
			}
		} else {
			id = (String) joinPoint.getArgs()[1];
		}

		if (!login.getMemberid().equals(id) && login.getMembergrade() != 0) {
			throw new MessageException("볼 수 있는 권한이 없습니다.");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	///////////////////////////////////// study/////////////////////////////////////////////
	// study게시물 작성자 & 세션 id 비교 검사
	@Around("execution(* controller.Study*.studyCon*(..))") // study컨트롤러에 delCon으로 시작되는 메서드
	public Object studyDeleteCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String memberid = (String) joinPoint.getArgs()[1]; // 작성자
		Integer studyno = (Integer) joinPoint.getArgs()[2]; // 게시물번호
		Integer pageNum = (Integer) joinPoint.getArgs()[3]; // 페이지 넘버

		User login = (User) session.getAttribute("login");// 로그인 아이디
		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (!memberid.equals(login.getMemberid()) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", "../study/studyInfo.jsy?pageNum=" + pageNum + "&studyno=" + studyno);
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	/////////////////////////////////// reply,
	/////////////////////////////////// community////////////////////////////////////////////
	// reply, community 게시물 작성자 & 세션 id 비교 검사
	@Around("execution(* controller.Community*.comreplyCon*(..))") // study컨트롤러에 delCon으로 시작되는 메서드
	public Object replyCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String memberid = (String) joinPoint.getArgs()[1]; // 작성자
		Integer communitykind = (Integer) joinPoint.getArgs()[2]; // 게시물종류
		Integer communityno = (Integer) joinPoint.getArgs()[3];// 게시물번호
		Integer pageNum = (Integer) joinPoint.getArgs()[4]; // 페이지 넘버

		User login = (User) session.getAttribute("login");// 로그인 아이디
		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (!memberid.equals(login.getMemberid()) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", "../community/comInfo.jsy?communitykind=" + communitykind
					+ "&communityno=" + communityno + "&pageNum=" + pageNum);
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	////////////////////////////////////// portfolio////////////////////////////////////////////
	// myportFolio 자기자신, 기업, admin만 들어갈수 있음
	@Around("execution(* controller.PortFolio*.PfCon*(..))")
	public Object PortFolioConfirm(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = (String) joinPoint.getArgs()[1]; // 작성자
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (!login.getMemberid().equals(id) && login.getMembergrade() != 2 && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	// potofolio 자신이거나 어드민만 들어갈 수 있음
	@Around("execution(* controller.PortFolio*.myPfCon*(..))")
	public Object MyPortFolioCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = (String) joinPoint.getArgs()[1]; // 작성자
		User login = (User) session.getAttribute("login");// 로그인 아이디
		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (!login.getMemberid().equals(id) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	// potofolio 기업아이디나 어드민만 들어갈 수 있음
	@Around("execution(* controller.PortFolio*.companyCon*(..))")
	public Object companyCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		User login = (User) session.getAttribute("login");// 로그인 아이디
		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (login.getMembergrade() != 2 && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	//////////////////////////////////// mypage////////////////////////////////////////////
	// mypage 자신이거나 어드민만 들어갈 수 있음
	@Around("execution(* controller.Mypage*.MPCon*(..))")
	public Object mypageCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = "아이디 없음";
		List<StudyGroup> sg = null;
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}

		if (joinPoint.getArgs()[1] instanceof String) {
			id = (String) joinPoint.getArgs()[1]; // 작성자
		} else if (joinPoint.getArgs()[1] instanceof User) {
			User user = (User) joinPoint.getArgs()[1];
			id = user.getMemberid();
		} else if (joinPoint.getArgs()[1] instanceof Integer) {
			int studyno = (int) joinPoint.getArgs()[1];
			sg = service.studygroupAOP(studyno);
			for (StudyGroup a : sg) {
				if (a.getRegmember().equals(login.getMemberid())) {
					id = a.getRegmember();
				}
				if (a.getLeadermember().equals(login.getMemberid())) {
					id = a.getLeadermember();
				}
			}
		}

		if (!login.getMemberid().equals(id) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}

		Object ret = joinPoint.proceed();
		return ret;
	}

	// mypage 어드민만 들어갈 수 있음
	@Around("execution(* controller.Mypage*.MpAdCon*(..))")
	public Object mypageAdminCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";

		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}

	// studygroup leadermember인지 확인
	@Around("execution(* controller.Mypage*.leaderCon*(..))")
	public Object leaderCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = "아이디 없음";
		List<StudyGroup> sg = null;
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}

		int studyno = (int) joinPoint.getArgs()[1];
		sg = service.studygroupAOP(studyno);
		for (StudyGroup a : sg) {
			if (a.getLeadermember().equals(login.getMemberid())) {
				id = a.getLeadermember();
			}
		}

		if (!login.getMemberid().equals(id) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}

		Object ret = joinPoint.proceed();
		return ret;
	}
	///////////////////////////////////HireBoard/////////////////////////////////////////////
	
	//기업회원인지 아닌지 확인
	@Around("execution(* controller.Board*.companyCk*(..))")
	public Object CompanyCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		if (login.getMembergrade() != 0 && login.getMembergrade() != 2) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
	
	//기업자기자신인지 확인
	@Around("execution(* controller.Board*.myComCk*(..))")
	public Object myCompanyCheck(ProceedingJoinPoint joinPoint) throws Throwable {
		HttpSession session = (HttpSession) joinPoint.getArgs()[0];// session
		String path = session.getServletContext().getContextPath()+"/";
		String id = "아이디 없음";
		User login = (User) session.getAttribute("login");// 로그인 아이디

		if (login == null) {
			throw new JsyException("로그인을 해야합니다.", path+"user/login.jsy");
		}
		
		if (joinPoint.getArgs()[1] instanceof Integer) {
			int hireno = (int) joinPoint.getArgs()[1]; // hireno
			Hire hire = service.selectHire(hireno);
			id = hire.getMemberid();
		}
		
		if (!login.getMemberid().equals(id) && login.getMembergrade() != 0) {
			throw new JsyException("권한이 없습니다.", path+"main.jsy");
		}
		Object ret = joinPoint.proceed();
		return ret;
	}
}
