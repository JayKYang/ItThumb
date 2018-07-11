<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div class="w3-container w3-padding-32"
		style="width: 70%; margin-left: 15%;">
		<h2>내가 스크랩한 포트폴리오</h2>
		<div id="scrapportfoliodiv">
			<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="w3-table">
				<tr>
					<th width="15%">사진</th>
					<th width="15%">아이디</th>
					<th width="15%">이름</th>
					<th width="15%">프로젝트명</th>
					<th width="5%">지역</th>
					<th width="10%">최종수정일</th>
					<th width="15%"></th>
				</tr>
				<c:if test="${empty scrapmemberlist }">
					<tr>
						<td colspan="7">스크랩 목록이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${scrapmemberlist}" var="scrap">
					<tr>
						<td><c:if test="${!empty scrap.imageUrl }">
								<img src="../../photo/${scrap.imageUrl }" style="width: 100%;">
							</c:if> <c:if test="${empty scrap.imageUrl }">
								<img src="../../photo/defaultphoto.png" style="width: 100%;">
							</c:if></td>
						<td>${scrap.memberid }</td>
						<td>${scrap.name }</td>
						<td>${scrap.slogun }</td>
						<td>${scrap.address }</td>
						<td><fmt:formatDate value="${scrap.modifydate}" type="both"
								pattern="yyyy-MM-dd" /></td>
						<td><a
							href="../portfolio/myportfolio.jsy?id=${scrap.memberid}"><i
								class="fa fa-eye w3-button w3-xlarge"></i></a> <a
							onclick="javascript:message_open('../../message/messageWrite.jsy?memberid=${scrap.memberid}')">
								<i class="fa fa-commenting w3-button w3-xlarge"></i>
						</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
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
			&nbsp; <br>

		</div>
		<div class="w3-bar w3-center">
			<form action="portfolioscraplist.jsy" method="post" name="searchform">
				<input type="hidden" name="pageNum" value="1"> <span
					style="float: right"> <select name="searchType"
					id="searchType">
						<option value="" disabled selected>선택하세요</option>
						<option value="a.memberid">아이디</option>
						<option value="name">이름</option>
						<option value="address">지역</option>
						<option value="slogun">프로젝트명</option>
				</select>>&nbsp; <script type="text/javascript">
					if ('${param.searchType}' != '') {
						document.getElementById("searchType").value = '${param.searchType}';
					}
				</script> <input type="text" name="searchContent"
					value="${param.searchContent }"> <input type="submit"
					value="검색">
				</span>
			</form>
		</div>
		<br>
	</div>
</body>
</html>