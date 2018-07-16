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
<style>
	.button{
		width:60px;
		height:30px;
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
<div id="main" class="w3-content">
	<div class="w3-container w3-half" style="width:70%">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-pink w3-xxlarge">확정 스터디원</span>
			</p>
		</div>
		<table class="w3-table w3-bordered" style="width: 100%;">
			<tr>
				<th style="text-align:center;">이름[아이디]</th>
				<th style="text-align:center;">전화번호</th>
				<th style="text-align:center;">생일</th>
				<th style="text-align:center;">등급</th>
				<th style="text-align:center;">강제탈퇴<th>
			</tr>
			<c:forEach items="${userList}" var="user">
			<tr>
				<td style="text-align:center;">${user.name} [${user.memberid}]</td>
				<td style="text-align:center;">${user.tel}</td>
				<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="birth" />
				<td style="text-align:center;">${birth}</td>
				<td style="text-align:center;">
					<c:if test="${user.memberid != study.memberid}">
						<div class="w3-tag w3-round w3-blue w3-border w3-border-white" style="width:70px;">
							<font style="color: white;">스터디원</font>
						</div>
					</c:if>
					<c:if test="${user.memberid == study.memberid}">
						<div class="w3-tag w3-round w3-deep-orange w3-border w3-border-white" style="width:60px;">
							<font style="color: white;">리  더</font>
						</div>
					</c:if>
				</td>
				<td style="text-align:center;">
					<c:if test="${user.memberid != study.memberid}">
						<button class="w3-button w3-round w3-red" style="width:60px;height:30px;padding: 5px;" onclick="location.href='myStudyKick.jsy?regmember=${user.memberid}&studyno=${study.studyno}&pageNum=${pageNum}&smkind=${smkind}'">강퇴</button>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<br><br>
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-pink w3-xxlarge">신청 대기 인원</span>
			</p>
		</div>
		<table class="w3-table w3-bordered" style="width: 100%;">
			<tr>
				<th style="text-align:center;">이름[아이디]</th>
				<th style="text-align:center;">전화번호</th>
				<th style="text-align:center;">생일</th>
				<th style="text-align:center;">상태</th>
				<th style="text-align:center;">선택</th>
			</tr>
			<c:forEach items="${waitUserList}" var="user">
			<tr>
				<td style="text-align:center;">${user.name} [${user.memberid}]</td>
				<td style="text-align:center;">${user.tel}</td>
				<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" var="birth" />
				<td style="text-align:center;">${birth}</td>
				<td style="text-align:center;">
					<c:if test="${user.state == 0}">
						대기
					</c:if>
					<c:if test="${user.state == 1}">
						거절
					</c:if>
				</td>
				<td style="text-align:center;">
					<c:if test="${user.state == 0}">
						<button class="w3-button w3-round w3-green" style="width:60px;height:30px;padding: 5px;" onclick="location.href='myStudyaceept.jsy?regmember=${user.memberid}&studyno=${study.studyno}&pageNum=${pageNum}&smkind=${smkind}&state=2'">수락</button>
						<button class="w3-button w3-round w3-red" style="width:60px;height:30px;padding: 5px;" onclick="location.href='myStudyaceept.jsy?regmember=${user.memberid}&studyno=${study.studyno}&pageNum=${pageNum}&smkind=${smkind}&state=1'">거절</button>
					</c:if>
					<c:if test="${user.state == 1}">
						<button class="w3-button w3-round w3-green" style="width:60px;height:30px;padding: 5px;" onclick="location.href='myStudyaceept.jsy?regmember=${user.memberid}&studyno=${study.studyno}&pageNum=${pageNum}&smkind=${smkind}&state=2'">수락</button>
					</c:if>
				</td>
			</tr>
			</c:forEach>
		</table>
		<br>
		<input type="button" class="button w3-right" style="height: 50px;" onclick="location.href='managestudy.jsy?pageNum=${pageNum}&smkind=${smkind}'" value="목록">
	</div>
	
	<div class="w3-container w3-half" style="width:30%">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-pink w3-xxlarge">스터디 정보</span>
			</p>
		</div>
		<table class="w3-table w3-bordered" style="width: 100%;">
			<tr>
				<th style="text-align:left;">지 역</th>
				<td style="text-align:center;">${study.region}</td>
			</tr>
			<tr>
				<th style="text-align:left;">가능인원</th>
				<td style="text-align:center;">
					${study.nowmember}/<c:if test="${study.limitmember==100}">∞</c:if><c:if test="${study.limitmember!=100}">${study.limitmember}</c:if>
				</td>
			</tr>
			<tr>
				<th style="text-align:left;">요 일</th>
				<td style="text-align:center;">${study.weekday}</td>
			</tr>
			<tr>
				<th style="text-align:left;">시 간</th>
				<td style="text-align:center;">${study.starttime}~${study.endtime}</td>
			</tr>
			<tr>
				<th style="text-align:left;">리 더</th>
				<td style="text-align:center;">${study.membername}</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>