<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>일반유저가입</title>
</head>
<body>
<form:form modelAttribute="user" action="normalJoinForm.jsy" method="post">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">이메일</td>
			<td>
				<form:input path="memberid" />
				<font color="red"><form:errors path="memberid"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">비밀번호</td>
			<td>
				<form:password path="password" />
				<font color="red"><form:errors path="password"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">비밀번호확인</td>
			<td>
				<input type="password" name="passconfirm">
			</td>
		</tr>
		<tr>
			<td align="center">이름</td>
			<td>
				<form:input path="name"/>
				<font color="red"><form:errors path="name"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">연락처</td>
			<td>
				<form:input path="tel"/>
				<font color="red"><form:errors path="tel"/></font>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="JOIN">
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>