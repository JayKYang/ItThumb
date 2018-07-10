<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>Study Info</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#scrap').click(function() {
			$.ajax({
				url : "studyScrap.jsy",
				type : "POST",
				data : {"studyno":'${studyno}',"memberid":'${memberid}'},
				success : function(data) {
					if(data.success == 'success'){
						$("#scrap2").attr("class","fa fa-heart");
						alert("스크랩 되었습니다.");
					}else{
						$("#scrap2").attr("class","fa fa-heart-o");
						alert("스크랩이 해제 되었습니다.");
					}
				}
			});
		})
		
		$('#apply').click(function() {
			$.ajax({
				url : "studyApply.jsy",
				type : "POST",
				data : {"studyno":'${studyno}',"regmember":'${memberid}'},
				success : function(data) {
					if(data.success == 'success'){
						$("#apply").html("<i id='apply2' class='fa fa-sign-out'></i>참가취소"); 
						alert("신청이 완료되었습니다.");
					}else{
						$("#apply").html("<i id='apply2' class='fa fa-sign-in'></i>참가신청"); 
						alert("신청이 취소되었습니다.");
					}
				}
			});
		})
	})
</script>
<script type="text/javascript">
	function message_open(url) {
		var h = screen.height * (3 / 4);
		var w = screen.width * (1.3 / 3);
		window.open(url, "message", "width=" + w + ", height=" + h
				+ ", left=100, top=100");
	}
	
	function deleteConfirm(pageNum, studyno, memberid) {
		if(confirm("정말 삭제할까요?") == true){
			location.href="studyDelete.jsy?pageNum="+pageNum+"&studyno="+studyno+"&memberid="+memberid;
		}else{
			return;
		}
	}
	function updateConfirm(pageNum, studyno, memberid) {
		if(confirm("수정 할까요?") == true){
			location.href="studyUpdate.jsy?pageNum="+pageNum+"&studyno="+studyno+"&memberid="+memberid;
		}else{
			return;
		}
	}
</script>
</head>
<body>
<form:form modelAttribute="study" name="f">
<div class="w3-container w3-cell">
	<table class="w3-table w3-bordered" style="width: 1000px;">
		<tr>
			<th>제 목</th>
		</tr>
		<tr>
			<td>${study.studyname}</td>
		</tr>
		<tr>
			<th>내 용</th>
		</tr>
		<tr>
			<td>${study.content}</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="javascript:message_open('../message/messageWrite.jsy?memberid=${study.memberid}')" value="작성자에게 쪽지보내기">
				<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="location.href='studySearchList.jsy?pageNum=${pageNum}'" value="목록">
				<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="javascript:updateConfirm('${pageNum}','${study.studyno}','${study.memberid}')" value="수정">
				<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="javascript:deleteConfirm('${pageNum}','${study.studyno}','${study.memberid}')" value="삭제">
			</td>
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
		
			<c:if test="${scrapComfirm==0}">
				<td><a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart-o"></i> 스크랩</a></td>
			</c:if>
			<c:if test="${scrapComfirm==1}">
				<td><a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart"></i> 스크랩</a></td>
			</c:if>
			
			<c:if test="${studyGroupComfirm==0}">
				<td><a id="apply" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="apply2" class="fa fa-sign-in"></i>참가신청</a></td>
			</c:if>
			<c:if test="${studyGroupComfirm==1}">
				<td><a id="apply" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="apply2" class="fa fa-sign-out"></i>참가취소</a></td>
			</c:if>
		</tr>
	</table>
</div>
</form:form>
</body>
</html>