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

<body class="w3-black">

	<script type="text/javascript">
		function list(pageNum, smkind) {
			var searchType = document.searchform.searchType.value;
			if (searchType == null || searchType.length == 0) {
				document.searchform.searchContent.value = "";
				document.searchform.pageNum.value = "1";
				location.href = "managestudy.jsy?pageNum=" + pageNum+ "&smkind=" + smkind;
			} else {
				document.searchform.pageNum.value = pageNum;
				document.searchform.submit();
				return true;
			}
			return false;
		}
	</script>

	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center w3-black">
		<a href="managestudy.jsy?smkind=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
		<i class="fa fa-clipboard w3-xxlarge"></i>
			<p>참여 신청한 스터디</p>
		</a> 
		<a href="managestudy.jsy?smkind=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
		<i class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>스크랩한 스터디</p>
		</a>
		<a href="managestudy.jsy?smkind=3" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
		<i class=" fa fa-edit w3-xxlarge"></i>
			<p>내가 만든 스터디</p>
		</a>
	</nav>
<div id="main">
	<c:if test="${smkind==1}">
		<h2>참여 신청한 스터디</h2>
	</c:if>
	<c:if test="${smkind==2}">
		<h2>스크랩한 스터디</h2>
	</c:if>
	<c:if test="${smkind==3}">
		<h2>내가 만든 스터디</h2>
	</c:if>
	<form>
		<c:if test="${smkind==1}">
			<table class="w3-table w3-bordered">
				<tr>
				<th align="center">순서</th>
				<th align="center">스터디 이름</th>
				<th align="center">현재인원/최대인원</th>
				<th align="center">작성일</th>
				<th align="center">수락 상태</th>
				</tr>
				<c:if test="${empty studylist}">
					<tr>
					<td colspan="5">참여 신청한 스터디가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="study" items="${studylist}">
				<tr>
					<td align="center">${studynum}</td>
					<c:set var="studynum" value="${studynum - 1 }"></c:set>
					<c:set var="subjectText" value="${study.studyname}"/>
					<td align="center">
						<a href="#">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a>
					</td>
					<td align="center">
						${study.nowmember} / <c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if> 
					</td>
					<fmt:formatDate value="${study.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td align="center">${regnow}</td>
					<td>
						<c:if test="${study.state==0}">
							대기
						</c:if>
						<c:if test="${study.state==1}">
							거절
						</c:if>
						<c:if test="${study.state==2}">
							수락
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${smkind==2}">
			<table class="w3-table w3-bordered">
				<tr>
				<th align="center">순서</th>
				<th align="center">스터디 이름</th>
				<th align="center">현재인원/최대인원</th>
				<th align="center">작성일</th>
				</tr>
				<c:if test="${empty studylist}">
					<tr>
					<td colspan="4">스크랩한 스터디가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="study" items="${studylist}">
				<tr>
					<td align="center">${studynum}</td>
					<c:set var="studynum" value="${studynum - 1 }"></c:set>
					<c:set var="subjectText" value="${study.studyname}"/>
					<td align="center">
						<a href="#">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a>
					</td>
					<td align="center">
						${study.nowmember} / <c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if> 
					</td>
					<fmt:formatDate value="${study.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td align="center">${regnow}</td>
				</tr>
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${smkind==3}">
			<table class="w3-table w3-bordered">
				<tr>
				<th align="center">순서</th>
				<th align="center">스터디 이름</th>
				<th align="center">현재인원/최대인원</th>
				<th align="center">작성일</th>
				</tr>
				<c:if test="${empty studylist}">
					<tr>
					<td colspan="4">만든 스터디가 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="study" items="${studylist}">
				<tr>
					<td align="center">${studynum}</td>
					<c:set var="studynum" value="${studynum - 1 }"></c:set>
					<c:set var="subjectText" value="${study.studyname}"/>
					<td align="center">
						<a href="#">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a>
					</td>
					<td align="center">
						${study.nowmember} / <c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if> 
					</td>
					<fmt:formatDate value="${study.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td align="center">${regnow}</td>
				</tr>
				</c:forEach>
			</table>
		</c:if>
	</form>
	<br>
	<div class="w3-bar w3-center">
		<c:if test="${pageNum > 1 }">
			<a href="javascript:list(${pageNum - 1},${smkind})">[이전]</a>
		</c:if>
		&nbsp;
		<c:if test="${pageNum <=1 }">
			[이전]
		</c:if>
		&nbsp;
		<c:forEach var="a" begin="${startpage }" end="${endpage }">
			<c:if test="${a == pageNum }">[${a}]</c:if>
			<c:if test="${a != pageNum }">
				<a href="javascript:list(${a},${smkind})">[${a}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:list(${pageNum + 1 },${smkind})">[다음]</a>
		</c:if>
		&nbsp;
		<c:if test="${pageNum >= maxpage }">[다음]</c:if>
		&nbsp;
	</div>
	<br>
	<form action="managestudy.jsy" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1"> 
		<input type="hidden" name="smkind" value="${smkind}"> 
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
			<input type="text" name="searchContent" value="${param.searchContent }"> 
			<input type="submit" value="검색">
		</span>
	</form>
</div>
</body>
</html>