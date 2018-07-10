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
		<div id="confirmhirelist" class="mypage">
			<h2>채용게시판 관리</h2>
			<table>
				<tr>
					<td>
						<a href="confirmHire.jsy">전체</a>&nbsp;&nbsp;
						<a href="confirmHire.jsy?hide=0">미승인처리</a>
					</td>
				</tr>
			</table>
			<div id="hirediv">
			<input type="hidden" name="pageNum" value="${pageNum}"> 
			
				<table>
					<tr>
						<th>글번호</th><th>아이디</th><th>기업명</th><th>채용글</th><th>등록일</th><th>마감일</th><th></th>						
					</tr>
					<c:if test="${empty hirelist }">
						<tr><td colspan="7">목록이 존재하지 않습니다.</td></tr>
					</c:if>
					<c:forEach items="${hirelist }" var="hire" varStatus="status">
						<tr><td>${hire.hireno }</td><td>${hire.memberid }</td><td>${hire.company }</td><td>${hire.subject }</td><td>${hire.regdate }</td><td>${hire.deadline }</td>
							<c:if test="${hire.hide == 0}">
								<td><input type="button" onclick="location.href=''" value="승인"/></td>
							</c:if>
							<c:if test="${hire.hide != 0 }">
								<td>승인처리완료</td>
							</c:if>
						</tr>
					</c:forEach>
				</table>
				<div class="w3-bar w3-center">
					<c:if test="${pageNum > 1 }">
						<a href="javascript:managemem(${membergrade},${pageNum - 1})">[이전]</a>
					</c:if>
					&nbsp;
					<c:if test="${pageNum <=1 }">
							[이전]
					</c:if>
					&nbsp;
					<c:forEach var="a" begin="${startpage }" end="${endpage }">
						<c:if test="${a == pageNum }">[${a}]</c:if>
						<c:if test="${a != pageNum }">
							<a href="javascript:managemem(${membergrade},${a})">[${a}]</a>
						</c:if>
					</c:forEach>
					<c:if test="${pageNum < maxpage}">
						<a href="javascript:managemem(${membergrade},${pageNum + 1 })">[다음]</a>
					</c:if>
					&nbsp;
					<c:if test="${pageNum >= maxpage }">[다음]</c:if>
					&nbsp;
					<br>
					
				</div>
			</div>
			<div class="wA3-bar w3-center">
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
			</div>
			<br>
		</div>
	</div>
</body>
</html>