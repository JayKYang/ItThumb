<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 비밀번호 찾기</title>
</head>
<body>
	<form:form modelAttribute="user" method="post" action="findpassword.jsy">
		<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
		</spring:hasBindErrors>
		<table>
			<tr>
				<td>email</td><td><form:input path="memberid" /><font color="red"><form:errors path="memberid"/></font></td>
			</tr>
			<tr>
				<td><input type="submit" value="메일전송하기"></td>
			</tr>
		</table>
	</form:form>
</body>
</html>