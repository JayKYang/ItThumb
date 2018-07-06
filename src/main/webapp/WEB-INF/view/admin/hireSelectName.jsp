<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<fmt:requestEncoding value="utf-8"/>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver" 
					url="jdbc:mariadb://localhost:3306/itthumb"
					user="jsy" password="1234" />
<sql:query var="rs" dataSource="${conn }">
	select name from user where memberid like ?
	<sql:param>${param.memberid}%</sql:param>
</sql:query>
<ul>
	<c:forEach var="data" items="${rs.rows}">
		${data.memberid}
	</c:forEach>
</ul>