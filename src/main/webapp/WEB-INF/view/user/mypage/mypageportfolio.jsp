<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 마이페이지 > 포트폴리오 관리</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<style>
	.button{
		width:150px;
		height:60px;
	}
   	.button {
	  border-radius: 4px;
	  background-color: skyblue;
	  border: none;
	  color: #FFFFFF;
	  text-align: center;
	  font-size: 18px;
	  padding: 20px;
	  transition: all 0.5s;
	  cursor: pointer;
	}
	.button:hover {
	  background-color: pink;
	}
	
	.button span {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.button span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	}
	
	.button:hover span {
	  padding-right: 25px;
	}
	
	.button:hover span:after {
	  opacity: 1;
	  right: 0;
	}
</style>
</head>
<body>
	<div class="w3-content">
		<c:if test="${sessionScope.login.createpf == 0 }">
			<img src="../../mainimg/portfoliophoto.gif" style="width:100%;">
			<h2 class="w3-text-amber">등록된 포트폴리오가 없습니다.</h2><br>
			<p style="font-size:18px;">포트폴리오작성이 아직 어려우신가요? 어떻게 작성할지 고민중이신가요?<br>
			저희 ITThumb는 포트폴리오를 쉽고 깔끔하게 작성을 도와드립니다.<br>
			지금 바로 포트폴리오를 쉽고 간편하게 작성해보세요!</p>
			<button class="button w3-right" onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'">포트폴리오 작성</button>
		</c:if>
		<c:if test="${sessionScope.login.createpf == 1 }">
			<fmt:formatDate value="${sessionScope.login.modifydate }" type="both" pattern="yyyy-MM-dd HH:MM:SS" var="modifydate"/>
			<div class="w3-center">
				<p>
					<span class="w3-content w3-text-purple w3-xxlarge">내 포트폴리오</span>
				</p>
			</div>
			<div class="w3-content w3-center" style="width:100%;">
				<table class="w3-table w3-bordered">
					<tr><th style="width:30%" align="center">수정날짜</th><th style="width:40%">포트폴리오 이름</th><th style="width:5%"></th><th style="width:5%"></th><th style="width:5%"></th></tr>           	
					<tr>
						<td>${modifydate }</td><td>${sessionScope.login.slogun}</td>
						<td><a href="../portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}"><i class="fa fa-eye w3-button"></i></a></td>
						<td><i class="fa fa-edit w3-button" onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'"></i></td>
						<td><a href="javascript:location.href='../portfolio/deleteportfolio.jsy?id=${sessionScope.login.memberid}'"><i class="fa fa-trash-o w3-button"></i></a></td>
					</tr>
				</table>
			</div>
			<img src="../../mainimg/portfoliophoto.gif" style="width:100%;margin-top:10%;">
		</c:if>
	</div>
</body>
</html>
