<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>studySearchList</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>
<script type="text/javascript">
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0){
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "studySearchList.jsy?pageNum="+pageNum;
		}else{
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>

	<div class="w3-container">
		
		<h2>스터디 검색</h2>


		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="w3-table w3-bordered">
			<tr>
				<th align="center">순서</th>
				<th align="center">스터디 이름</th>
				<th align="center">요일</th>
				<th align="center">시간</th>
				<th align="center">현재인원/최대인원</th>
				<th align="center">지 역</th>
				<th align="center">작성자</th>
				<th align="center">작성일</th>
			</tr>
			<c:forEach var="study" items="${studylist }">
				<tr>
					<td align="center">${studynum}</td>
					<c:set var="studynum" value="${studynum - 1 }"></c:set>
					<c:set var="subjectText" value="${study.studyname}"/>
					<td align="center">
						<a href="studyInfo.jsy?pageNum=${pageNum}&studyno=${study.studyno}">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a>
					</td>
					<td align="center">${study.weekday }</td>
					<td align="center">${study.starttime} ~ ${study.endtime}</td>
					<td align="center">
						${study.nowmember} / <c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if> 
					</td>
					<td align="center">${study.region}</td>
					<td align="center">${study.memberid }(${study.membername})</td>
					<fmt:formatDate value="${study.regdate}" pattern="yyyy-MM-dd" var="regnow" />
					<td align="center">${regnow}</td>
				</tr>
			</c:forEach>
		</table>

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
					<option value="memberid">작성자</option>
			</select>>&nbsp; 
			<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}'
				}
			</script> 
			<input type="text" name="searchContent" value="${param.searchContent }"> 
			<input type="submit" value="검색">
			<input type="button" onclick="location.href='studyWrite.jsy'" value="스터디 모집">
			</span>
		</form>
	</div>
</body>
</html>