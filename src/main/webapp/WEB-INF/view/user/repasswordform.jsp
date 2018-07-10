<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 비밀번호 변경</title>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
</head>
<body>
	<form:form modelAttribute="user" method="post" action="repasswordform.jsy">
		<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
		</spring:hasBindErrors>
		<table>
			<tr>
				<td align="right">아이디</td><td>${user.memberid }<form:hidden path="memberid" /></td>
			</tr>
			<tr>
			<td align="right">새 비밀번호</td>
				<td>
					<form:password path="password" />
					<font color="red"><form:errors path="password"/></font>
				</td>
			</tr>
			<tr>
				<td align="right">비밀번호 확인</td>
				<td>
					<input type="password" name="passconfirm">
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="메일전송하기"></td>
			</tr>
		</table>
	</form:form>
</body>
</html>