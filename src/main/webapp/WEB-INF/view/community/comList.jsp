<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>잇썸 > 커뮤니티</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
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
<style>
.button {
	width: 60px;
	height: 30px;
}

.button {
	border-radius: 4px;
	background-color: orange;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 5px;
	transition: all 0.5s;
	cursor: pointer;
}

.button:hover {
	background-color: #FFE4B5;
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
	<div class="w3-bar w3-small w3-left w3-amber" style="width: 100%;">
		<a href="comList.jsy?communitykind=1" style="width:10%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-yellow"> <i
			class="fa fa-clipboard w3-xxlarge"></i>
			<p>자유 게시판</p>
		</a> <a href="comList.jsy?communitykind=2" style="width:10%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-yellow"> <i
			class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>Q & A</p>
		</a>
		<c:if test="${!empty sessionScope.login}">
			<a href="comList.jsy?communitykind=3" style="width:10%;"
				class="w3-bar-item w3-button w3-padding-large w3-hover-yellow">
				<i class=" fa fa-edit w3-xxlarge"></i>
				<p>내가 쓴 글</p>
			</a>
		</c:if>
	</div>
	<div id="main" class="w3-content w3-container">
		<c:if test="${communitykind==1}">
			<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-text-amber w3-xxlarge">자유게시판</span>
				</p>
			</div>
		</c:if>
		<c:if test="${communitykind==2}">
			<div class="w3-center" style="width: 100%">
				<p>
					<span class="w3-content w3-text-amber w3-xxlarge">Q & A</span>
				</p>
			</div>
		</c:if>
		<c:if test="${communitykind==3}">
			<div class="w3-center" style="width: 100%">
				<p>
					<span class="w3-content w3-text-amber w3-xxlarge">내가 쓴글</span>
				</p>
			</div>
		</c:if>
		<form action="communityWrite.jsy" method="post">
			<input type="hidden" name="pageNum" value="${pageNum}"> <input
				type="hidden" name="communitykind" value="${communitykind}">
			<table class="w3-table w3-bordered">

				<tr>
					<c:if test="${communitykind==1 || communitykind==2}">
						<th style="text-align: center;">순서</th>
					</c:if>
					<c:if test="${communitykind==3}">
						<th style="text-align: center;">종류</th>
					</c:if>
					<th style="text-align: center;">제목</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">날짜</th>
					<th style="text-align: center;">조회수</th>
				</tr>
				<c:if test="${empty communityList}">
					<tr>
						<td colspan="5" style="text-align: center;">게시글이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="com" items="${communityList}">
					<tr>
						<c:if test="${communitykind==1 || communitykind==2}">
							<td style="text-align: center;">${num}</td>
						</c:if>
						<c:if test="${communitykind==3}">
							<c:if test="${com.communitykind==1}">
								<td style="text-align: center;">자유게시판</td>
							</c:if>
							<c:if test="${com.communitykind==2}">
								<td style="text-align: center;">Q&A</td>
							</c:if>
						</c:if>
						<c:set var="num" value="${num - 1 }"></c:set>
						<c:set var="subjectText" value="${com.subject}" />
						<td style="text-align: center;"><a
							href="comInfo.jsy?communitykind=${communitykind}&communityno=${com.communityno}&pageNum=${pageNum}">${fn:substring(subjectText, 0, 20)}
								<c:if test="${fn:length(subjectText)>20}">...
						</c:if>
						</a></td>
						<td style="text-align: center;">${com.memberid }</td>
						<fmt:formatDate value="${com.regdate}" pattern="yyyy-MM-dd"
							var="regnow" />
						<td style="text-align: center;">${regnow}</td>
						<td style="text-align: center;">${com.readcnt}</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		<div class="w3-right" style="margin-top: 10px">
			<c:if test="${communitykind==1 || communitykind==2}">
				<input type="button" class="button" style="width: 85px; height: 50px;"
					onclick="location.href='comWrite.jsy?communitykind=${communitykind}&pageNum=${pageNum}'"
					value="게시물 작성 ">
			</c:if>
		</div>
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
		<form action="comList.jsy" method="post" name="searchform" onsubmit="return list(1,${communitykind})">
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
			</select>>&nbsp; <script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}'
				}
			</script> 
			<input type="text" name="searchContent" value="${param.searchContent }"> 
			<input type="submit" class="button" value="검색">
			</span>
		</form>
	</div>
</body>
</html>