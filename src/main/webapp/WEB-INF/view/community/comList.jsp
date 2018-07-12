<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>communityBoard</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
</head>
<style>
body, h1,h2,h3,h4,h5,h6 {font-family: "Montserrat", sans-serif}
.w3-row-padding img {margin-bottom: 12px}
@media only screen and (max-width: 600px) {#main {margin-left: 0}}
</style>

<body class="w3-black">

	<script type="text/javascript">
		function list(pageNum, communitykind) {
			var searchType = document.searchform.searchType.value;
			if (searchType == null || searchType.length == 0) {
				document.searchform.searchContent.value = "";
				document.searchform.pageNum.value = "1";
				location.href = "comList.jsy?pageNum=" + pageNum
						+ "&communitykind=" + communitykind;
			} else {
				document.searchform.pageNum.value = pageNum;
				document.searchform.submit();
				return true;
			}
			return false;
		}
	</script>

	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center w3-black">
		<a href="comList.jsy?communitykind=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
		<i class="fa fa-clipboard w3-xxlarge"></i>
			<p>자유 게시판</p>
		</a> 
		<a href="comList.jsy?communitykind=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
		<i class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>Q & A</p>
		</a>
		<c:if test="${!empty sessionScope.login}"> 
			<a href="comList.jsy?communitykind=3" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
			<i class=" fa fa-edit w3-xxlarge"></i>
				<p>내가 쓴 글</p>
			</a>
		</c:if>
	</nav>
<div id="main">
	<c:if test="${communitykind==1}">
		<h2>자유 게시판</h2>
	</c:if>
	<c:if test="${communitykind==2}">
		<h2>Q & A</h2>
	</c:if>
	<c:if test="${communitykind==3}">
		<h2>내가 쓴 글</h2>
	</c:if>
	<form action="communityWrite.jsy" method="post">
		<input type="hidden" name="pageNum" value="${pageNum}"> 
		<input type="hidden" name="communitykind" value="${communitykind}">
		<table class="w3-table w3-bordered">
			
			<tr>
				<c:if test="${communitykind==1 || communitykind==2}">
					<th>순서</th>
				</c:if>
				<c:if test="${communitykind==3}">
					<th>종류</th>
				</c:if>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			<tr>
				<td colspan="5">
					<c:if test="${empty communityList}">
						게시글이 없습니다.
					</c:if>
				</td>
			</tr>
			<c:forEach var="com" items="${communityList}">
				<tr>
					<c:if test="${communitykind==1 || communitykind==2}">
						<td align="center">${num}</td>
					</c:if>
					<c:if test="${communitykind==3}">
						<c:if test="${com.communitykind==1}">
							<td align="center">자유게시판</td>
						</c:if>
						<c:if test="${com.communitykind==2}">
							<td align="center">Q&A</td>
						</c:if>
					</c:if>
					<c:set var="num" value="${num - 1 }"></c:set>
					<c:set var="subjectText" value="${com.subject}" />
					<td align="center">
					<a href="comInfo.jsy?communitykind=${communitykind}&communityno=${com.communityno}&pageNum=${pageNum}">${fn:substring(subjectText, 0, 10)}
						<c:if
								test="${fn:length(subjectText)>10}">...
						</c:if>
					</a>
					</td>
					<td align="center">${com.memberid }</td>
					<fmt:formatDate value="${com.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td align="center">${regnow}</td>
					<td align="center">${com.readcnt}</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<br>
	<div class="w3-bar w3-center">
		<c:if test="${pageNum > 1 }">
			<a href="javascript:list(${pageNum - 1},${communitykind})">[이전]</a>
		</c:if>
		&nbsp;
		<c:if test="${pageNum <=1 }">
			[이전]
		</c:if>
		&nbsp;
		<c:forEach var="a" begin="${startpage }" end="${endpage }">
			<c:if test="${a == pageNum }">[${a}]</c:if>
			<c:if test="${a != pageNum }">
				<a href="javascript:list(${a},${communitykind})">[${a}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:list(${pageNum + 1 },${communitykind})">[다음]</a>
		</c:if>
		&nbsp;
		<c:if test="${pageNum >= maxpage }">[다음]</c:if>
		&nbsp;
	</div>
	<br>
	<form action="comList.jsy" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1"> 
		<input type="hidden" name="communitykind" value="${communitykind}"> 
		<span style="float: right"> 
			<select name="searchType" id="searchType">
					<option value="" disabled selected>선택하세요</option>
					<option value="subject">제목</option>
					<option value="content">내용</option>
					<c:if test="${communitykind==1 || communitykind==2}">
						<option value="memberid">작성자</option>
					</c:if>
					
			</select>>&nbsp; 
			<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}'
				}
			</script> 
			<input type="text" name="searchContent" value="${param.searchContent }"> 
			<input type="submit" value="검색">
			<c:if test="${communitykind==1 || communitykind==2}">
				<input type="button" onclick="location.href='comWrite.jsy?communitykind=${communitykind}&pageNum=${pageNum}'" value="게시물 작성 ">
			</c:if>
		</span>
	</form>
</div>
</body>
</html>