<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">


</script>
</head>
<body>
<h2>채용 스크랩</h2>


<table border="1" width="90%">
	<c:if test="${scraphirecount >0 }">
		<tr>
			<th>공고번호</th>
			<th>회사명</th>
			<th>제목</th>
			<th>지원조건</th>
			<th>고용상태</th>
			<th>마감일</th>
			<th>마감상태</th>
		</tr>
		
		<c:forEach var="scraphire"  items="${scraphirelist}" varStatus ="status">	
		<tr>
			<td align="center">
				${scraphire.hireno}
			</td>
			<td>
				${scraphire.company}
			</td>
			<td>
			<a href="hiredetail.jsy?hireno=${scraphire.hireno}&pageNum=${pageNum}">${scraphire.subject}</a>
			</td>
			<td>
				${scraphire.qualification}
			</td>
			<td>
				${scraphire.hirestatus}
			</td>
			<td>
			<fmt:formatDate value="${scraphire.deadline}" pattern="yyyy-MM-dd" /> 
			</td>
			<td align="center">
				${ datelist[status.index]}일 전
			</td>
		</tr>			
		</c:forEach>
					<tr align="center" height="26">
			<td colspan="8">
				<c:if test="${pageNum >1}">
					<a href="javascript:hirelist(${pageNum -1})">PREV</a>
				</c:if> &nbsp;
				<c:if test="${pageNum <= 1}">PREV</c:if>&nbsp;
				<c:forEach var="a" begin="${startpage}" end = "${endpage}">
					<c:if test="${a == pageNum}">${a}</c:if>
					<c:if test="${a != pageNum}">
					<a href="javascript:hirelist(${a})">${a}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:hirelist(${pageNum + 1})">NEXT</a>
				</c:if> &nbsp;
				<c:if test="${pageNum >= maxpage}">NEXT
				</c:if> &nbsp;
			</td>
		</tr>
		</c:if>
			<c:if test="${scraphirecount ==0 }">
				<tr>
					<td>
						<h2>해당 목록이 비어있습니다.</h2>
					</td>
				</tr>
			</c:if>
</table>
</body>
</html>