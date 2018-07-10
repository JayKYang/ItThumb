<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<input type="hidden" name="membergrade" value="${membergrade }">
<input type="hidden" name="pageNum" value="${pageNum }">
<table>
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>강제탈퇴</th>
	</tr>
	<c:forEach items="${userlist }" var="user" varStatus="status">
		<tr>
			<td>${status.count }</td>
			<td>${user.memberid }</td>
			<td>${user.name }</td>
			<td><input type="button"
				onclick="location.href='delete.jsy?id=${user.memberid}'"
				value="강제탈퇴" /></td>
		</tr>
	</c:forEach>
</table>
