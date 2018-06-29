<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
				<td colspan="2"><h5>기업정보</h5></td>
				<td colspan="2"><h5>근무조건</h5></td>
			</tr>
			<tr>
				<td><h6>설립일</h6></td>
				<td>
					<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>근무지역</h6></td>
				<td>
				
					${hire.region}
					<br>
					<label style="font-size:8pt;">세부주소를 같이 입력해주세요.</label>
				</td>
			</tr>
			<tr>
				<td><h6>사업</h6></td>
				<td>
					${user.industy}
				</td>
				<td><h6>고용형태</h6></td>
				<td>
					${hire.hirestatus}
				</td>
			</tr>
			<tr>
				<td><h6>지역</h6></td>
				<td>
					${user.address}
				</td>
				<td><h6>연봉</h6></td>
				<td>
				${hire.salary}
				</td>
			</tr>
			<tr>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
				<td><h6>근무일</h6></td>
				<td>
					${hire.workday}
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
					<a href="javascript:document.f.submit()">SCRAB</a>
					<a href="hirelist.jsy?pageNum=${param.pageNum}">LIST</a>					
					</form>
				</td>
			</tr>
		</table>
</body>
</html>