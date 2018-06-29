<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>삭제 확인 화면</title>
</head>
<body>
	<%-- <table border="1" width="100%">
		<tr><td>아이디</td><td>${user.userId }</td></tr>
		<tr><td>이름</td><td>${user.userName }</td></tr>
		<tr><td>우편번호</td><td>${user.postcode }</td></tr>
		<tr><td>전화번호</td><td>${user.phoneNo }</td></tr>
		<tr><td>주소</td><td>${user.address }</td></tr>
		<tr><td>이메일</td><td>${user.email }</td></tr>
		<tr><td>생년월일</td><td><fmt:formatDate value="${user.birthDay }" pattern="yyyy-MM-dd"/></td></tr>
	</table><br> --%>
	<form action="delete.jsy" method="post" name="deleteform">
		<input type="hidden" name="id" value="${param.id }">
		비밀번호 <input type="password" name="password" size="12">
		<a href="javascript:document.deleteform.submit()">[회원탈퇴]</a>&nbsp;
	</form>
</body>
</html>