<%@page import="java.io.*,java.util.*"%>
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
<table>
		<forEach var="scraphirelist" items="${scraphirelist}">
		<tr>
			<td>
				${scraphirelist.hireno}
			</td>
			<td>
				${scraphirelist.company}
			</td>
			<td>
				${scraphirelist.subject}
			</td>
			<td>
				${scraphirelist.qualification}
			</td>
			<td>
				${scraphirelist.hirestatus}
			</td>
			<td>
				${scraphirelist.deadline}
			</td>
		</tr>
		</forEach>
</table>
</body>
</html>