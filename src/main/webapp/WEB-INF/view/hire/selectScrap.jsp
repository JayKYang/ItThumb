<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<fmt:requestEncoding value="utf-8"/>
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
               url="jdbc:mariadb://localhost:3306/bigdb"
               user="scott" password="tiger" />
<sql:query var="rs" dataSource="${conn }">
   select * from scrap where hireno = ?
   and memberid = ?
   <sql:param>${param.hireno }</sql:param>
   <sql:param>${param.memberid}</sql:param>
</sql:query>
<ul>
	<c:forEach var="data" items="${rs.rows}">
		<li>${data.hireno}</li>
	</c:forEach>
</ul>