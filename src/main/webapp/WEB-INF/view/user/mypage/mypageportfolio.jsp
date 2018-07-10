<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
</head>
<body>
	<div class="w3-container w3-padding-32" style="width:70%; margin-left:15%;">
		<div id="portfolio" class="mypage">
			<c:if test="${sessionScope.login.createpf == 0 }">
				등록된 포트폴리오가 없습니다.<br>
				<button onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'">포트폴리오 작성</button>
			</c:if>
			<c:if test="${sessionScope.login.createpf == 1 }">
				<h3>포트폴리오 목록</h3>
				<fmt:formatDate value="${sessionScope.login.modifydate }" type="both" pattern="yyyy-MM-dd HH:MM:SS" var="modifydate"/>
				<div class="w3-content w3-center" style="width:100%">
					<table class="w3-table">
						<tr><th style="width:30%" align="center">수정날짜</th><th style="width:40%">포트폴리오 이름</th><th style="width:5%"></th><th style="width:5%"></th><th style="width:5%"></th></tr>           	
						<tr>
							<td>${modifydate }</td><td>${sessionScope.login.slogun}</td>
							<td><a href="portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}"><i class="fa fa-eye w3-button"></i></a></td>
							<td><i class="fa fa-edit w3-button" onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'"></i></td>
							<td><a href="javascript:location.href='../portfolio/deleteportfolio.jsy?id=${sessionScope.login.memberid}'"><i class="fa fa-trash-o w3-button"></i></a></td>
						</tr>
					</table>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>