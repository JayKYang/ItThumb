<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<fmt:requestEncoding value="utf-8" />
<sql:setDataSource var="conn" driver="org.mariadb.jdbc.Driver"
               url="jdbc:mariadb://localhost:3306/itthumb"
               user="jsy" password="1234" />
<sql:query var="rs" dataSource="${conn }">
   select * from user where memberid like ?
   <sql:param>${param.memberid }%</sql:param>
</sql:query>
<ul>
   <c:forEach var="data" items="${rs.rows }">
      <li>${data.memberid }</li>
   </c:forEach>
</ul>