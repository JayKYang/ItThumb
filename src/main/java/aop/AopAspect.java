package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import exception.JsyException;
import exception.MessageException;
import logic.User;

@Component
@Aspect
public class AopAspect {
	 //로그인확인
	 @Around("execution(* controller.*.logcon*(..))")
	 public Object userLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		 HttpSession session = null;
		 session = (HttpSession)joinPoint.getArgs()[0];
		 User login = (User)session.getAttribute("login");
		 if(login == null) {
			 throw new JsyException("로그인을 해야합니다.", "../user/login.jsy");
		 }
		 Object ret = joinPoint.proceed();
	     return ret;
	 }
	 
	 //메세지 로그인 확인
	 @Around("execution(* controller.*.mesLogCon*(..))")
	 public Object MessageLoginCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		 HttpSession session = null;
		 session = (HttpSession)joinPoint.getArgs()[0];
		 User login = (User)session.getAttribute("login");
		 if(login == null) {
			 throw new MessageException("로그인을 해야합니다.");
		 }
		 Object ret = joinPoint.proceed();
	     return ret;
	 }
	 
	 //study게시물 작성자 & 세션 id 비교 검사
	 @Around("execution(* controller.Study*.delCon*(..))") //study컨트롤러에  delCon으로 시작되는 메서드
	 public Object deleteConfirmCheck(ProceedingJoinPoint joinPoint) throws Throwable{
		
		HttpSession session = (HttpSession)joinPoint.getArgs()[0];//session
		String memberid = (String) joinPoint.getArgs()[1]; //작성자
		Integer studyno = (Integer) joinPoint.getArgs()[2]; //게시물번호
		Integer pageNum = (Integer) joinPoint.getArgs()[3]; //페이지 넘버
		
		User login = (User)session.getAttribute("login");//로그인 아이디
		
		if(!memberid.equals(login.getMemberid()) && login.getMembergrade()!= 0) {
				throw new JsyException("삭제 권한이 없습니다.", "../study/studyInfo.jsy?pageNum="+pageNum+"&studyno="+studyno);
	    }
		Object ret = joinPoint.proceed();
		return ret;
	}
}
