<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContact.request.contextPath }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>인증확인</title>
</head>
<body>
<h2>인증확인</h2>
<form:form modelAttribute="user" method="post" action="login.shop">
	<table>
		<tr>
			<td>인증번호</td>
			<td><input type="text" name="recognizecode"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="로그인">
				<input type="button" value="회원가입" onclick="location.href='userForm.shop'">		
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>