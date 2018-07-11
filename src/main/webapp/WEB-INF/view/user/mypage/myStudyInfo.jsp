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
<script type="text/javascript">
	function leaveConfirm(pageNum, smkind) {
		if(confirm("정말 탈퇴할까요?") == true){
			location.href="leaveStudy.jsy?pageNum="+pageNum+"&smkind="+smkind;
		}else{
			return;
		}
	}
</script>
</head>

<body class="w3-black">
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
	<div class="w3-container w3-cell">
		<table class="w3-table w3-bordered" style="width: 1000px;">
			<tr>
				<th>이름[아이디]</th>
				<th>전화번호</th>
				<td>생일</td>
				<td>등급</td>
			</tr>
			<c:forEach items="${userList}" var="user">
			<tr>
				<td>${user.name} [${user.memberid}]</td>
				<td>${user.tel}</td>
				<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="birth" />
				<td>${birth}</td>
				<td>
					<c:if test="${user.memberid != study.memberid}">
						스터디원
					</c:if>
					<c:if test="${user.memberid == study.memberid}">
						리더
					</c:if>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="4">
					<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="location.href='managestudy.jsy?pageNum=${pageNum}&smkind=${smkind}'" value="목록">
				<td>
			</tr>
		</table>
	</div>
	
	<div class="w3-container w3-cell">
		<table class="w3-table w3-bordered" style="width: 400px;">
			<tr>
				<th>지 역</th>
				<td>${study.region}</td>
			</tr>
			<tr>
				<th>가능인원/최대인원</th>
				<td>
					${study.nowmember}/<c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if>
				</td>
			</tr>
			<tr>
				<th>요 일</th>
				<td>${study.weekday}</td>
			</tr>
			<tr>
				<th>시 간</th>
				<td>${study.starttime}~${study.endtime}</td>
			</tr>
			<tr>
				<th>리 더</th>
				<td>${study.membername}[${study.memberid}]</td>
			</tr>
			<tr>
				<td><a href="javascript:leaveConfirm('${pageNum}','${smkind}')" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i class="fa fa-sign-out"></i>스터디 탈퇴하기</a></td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>