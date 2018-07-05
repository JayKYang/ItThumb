<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
		<table border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td>
					<h5>제목</h5>
				</td>
				<td colspan="3">
					${hire.subject}
				</td>
			</tr>
			<tr>
				<td rowspan="2" colspan="2">
					<img src="../photo/${user.imageUrl}" width="210" height="130">
				</td>
				<td colspan="2"><h5>지원자격</h5></td>
			</tr>
			<tr>
				<td colspan="2">
					${hire.qualification}
				</td>
			</tr>
			<tr>			
				<td colspan="2"><h5>기업명</h5></td>
		
				<td colspan="2">
					${user.name}
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<h6>기업정보</h6>
				</td>
			</tr>
			<tr>
				<td><h6>설립일</h6></td>
				<td>
					<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>사업</h6></td>
				<td>
						${user.industy}
				</td>
			</tr>
			<tr>
				<td><h6>지역</h6></td>
				<td>
					${user.address}
				</td>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<h6>근무조건</h6>
				</td>
			</tr>
			<tr>
				<td><h6>근무지역</h6></td>
				<td>
					${hire.region} ${hire.regiongu} ${hire.regionetc }
				</td>
				<td><h6>고용형태</h6></td>
				<td>
					${hire.hirestatus}
				</td>
			</tr>
			<tr>
				<td><h6>연봉</h6></td>
				<td>
				   <c:choose>
     	  <c:when test="${hire.salary==0}">
      	    협상 후 연봉결정
      		 </c:when>
       		  <c:when test="${hire.salary==2200}">
           2200만원 이상
       </c:when>
        <c:when test="${hire.salary==2400}">
           2400만원 이상
       </c:when>
           <c:when test="${hire.salary==2600}">
            2600만원 이상
       </c:when>
           <c:when test="${hire.salary==2800}">
            2800만원 이상
       </c:when>
           <c:when test="${hire.salary==3000}">
            3000만원 이상
       </c:when>
       <c:otherwise>
           ${hire.salary}
       </c:otherwise>
   </c:choose>			
				
				</td>
				<td><h6>근무일</h6></td>
				<td>
					${hire.workday}
				</td>
			</tr>
			<tr>
				<td><h6>마감일</h6></td>
				<td>
					<fmt:formatDate value="${hire.deadline}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>경력</h6></td>
				<td>
					${hire.career} ${hire.careerdate}
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="../hireimg/${hire.imageUrl}" >
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<h6>내용</h6>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				${hire.content}
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<form method="post" action="scrap.jsy" name="f">
					<input type="hidden" name="pageNum" value="${param.pageNum}">
					<input type="hidden" name="hireno" value="${hire.hireno}">
					<a href="javascript:document.f.submit()" id="scrap">SCRAB</a>
					<a href="hirelist.jsy?pageNum=${param.pageNum}">LIST</a>					
					</form>
				</td>
			</tr>
		</table>
</body>
</html>