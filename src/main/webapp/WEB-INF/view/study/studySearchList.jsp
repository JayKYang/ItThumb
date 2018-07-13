<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>studySearchList</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>
<style>
.button {
	width: 60px;
	height: 30px;
}

.button {
	border-radius: 4px;
	background-color: skyblue;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 5px;
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
<script type="text/javascript">
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "studySearchList.jsy?pageNum=" + pageNum;
		} else {
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>

	<div id="main" class="w3-content">
		<div class="w3-center" style="width:100%">
			<p>
				<span class="w3-content w3-text-pink w3-xxlarge">스터디 검색</span>
			</p>
		</div>
		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="w3-table w3-bordered">
			<tr>
				<th style="text-align:center;">순서</th>
				<th style="text-align:center;">스터디 이름</th>
				<th style="text-align:center;">요일</th>
				<th style="text-align:center;">시간</th>
				<th style="text-align:center;">가능인원</th>
				<th style="text-align:center;">지 역</th>
				<th style="text-align:center;">작성자</th>
				<th style="text-align:center;">작성일</th>
			</tr>
			<c:forEach var="study" items="${studylist }">
				<tr>
					<td style="text-align:center;">${studynum}</td>
					<c:set var="studynum" value="${studynum - 1 }"></c:set>
					<c:set var="subjectText" value="${study.studyname}"/>
					<td style="text-align:center;">
						<a href="studyInfo.jsy?pageNum=${pageNum}&studyno=${study.studyno}">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a>
					</td>
					<td style="text-align:center;">${study.weekday }</td>
					<td style="text-align:center;">${study.starttime} ~ ${study.endtime}</td>
					<td style="text-align:center;">
						${study.nowmember} / <c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if> 
					</td>
					<td style="text-align:center;">${study.region}</td>
					<td style="text-align:center;">${study.memberid }(${study.membername})</td>
					<fmt:formatDate value="${study.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td style="text-align:center;">${regnow}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="w3-right" style="margin-top:10px">
				<input type="button" class="button" onclick="location.href='studyWrite.jsy'" style="width: 100px;" value="스터디 모집">
		</div>

		<br>
		<div class="w3-bar w3-center">
			<c:if test="${pageNum > 1 }">
				<a href="javascript:list(${pageNum - 1})">[이전]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum <=1 }">
					[이전]
			</c:if>
			&nbsp;
			<c:forEach var="a" begin="${startpage }" end="${endpage }">
				<c:if test="${a == pageNum }">[${a}]</c:if>
				<c:if test="${a != pageNum }">
					<a href="javascript:list(${a})">[${a}]</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:list(${pageNum + 1 })">[다음]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum >= maxpage }">[다음]</c:if>
			&nbsp;
		</div>
		<br>
		<form action="studySearchList.jsy" method="post" name="searchform" onsubmit="return list(1)">
			<input type="hidden" name="pageNum" value="1">  
			<span style="float: right"> 
			<select name="searchType" id="searchType">
					<option value="" disabled selected>선택하세요</option>
					<option value="studyname">제목</option>
					<option value="content">내용</option>
					<option value="region">지역</option>
					<option value="memberid">작성자아이디</option>
					<option value="membername">작성자이름</option>
			</select>>&nbsp; 
			<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}'
				}
			</script> 
			<input type="text" name="searchContent" value="${param.searchContent }">&nbsp;
			<input type="submit" class="button w3-right" value="검색">
			</span>
		</form>
	</div>
</body>
</html>