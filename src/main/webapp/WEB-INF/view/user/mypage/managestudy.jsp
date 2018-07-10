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
		<div id="managestudy" class="mypage">
			<h2>스터디 관리</h2>
			<div id="studydiv">
				<input type="hidden" name="pageNum" value="${pageNum}"> 
				<div class="w3-container w3-third">
					<h3>내가 참여한 스터디</h3>
					<table>
						<tr><th></th></tr>
						<c:if test="${empty studygrouplist }">
							<tr><td>참여한 스터디가 없습니다.</td></tr>
						</c:if>
						<c:forEach items="${studygrouplist }" var="studygroup">
							<tr><td>${studygroup }</td></tr>
						</c:forEach>
					</table>
				</div>
				<div class="w3-container w3-third">
					<h3>내가 스크랩한 스터디</h3>
					<table>
					
					</table>
				</div>
				<div class="w3-container w3-third">
					<h3>내가 만든 스터디</h3>
					<table>
					
					</table>
				</div>
			</div>
			<%-- <div class="wA3-bar w3-center">
				<form action="confirmHire.jsy" method="post" name="searchform">
					<input type="hidden" name="pageNum" value="1">  
					<span style="float: right"> 
					<select name="searchType" id="searchType">
							<option value="" disabled selected>선택하세요</option>
							<option value="company">기업명</option>
							<option value="memberid">아이디</option>
					</select>>&nbsp; 
					<script type="text/javascript">
						if ('${param.searchType}' != '') {
							document.getElementById("searchType").value = '${param.searchType}'
						}
					</script> 
					<input type="text" name="searchContent" value="${param.searchContent }"> 
					<input type="submit" value="검색">
					</span>
				</form>
			</div> --%>
			<br>
		</div>
	</div>
</body>
</html>