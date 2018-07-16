<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<title>잇썸 > 스터디 모집 > ${study.studyname} </title>
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
					}else if(data.success == 'excess'){
						alert("인원이 초과되어 신청 할 수 없습니다.");
					}else if(data.success == 'delete'){
						$("#apply").html("<i id='apply2' class='fa fa-sign-in'></i>참가신청"); 
						alert("신청이 취소되었습니다.");
					}else if(data.success == 'reject'){
						alert("거절된 스터디 입니다. 리더한테 문의하세요");
					}else if(data.success == 'accept'){
						alert("이미 스터디에 가입되어있습니다. 탈퇴는 마이페이지에서해주세요.");
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
<style>
.button {
	width: 60px;
	height: 30px;
}

.button {
	border-radius: 4px;
	background-color: #DC143C;
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
	<div id="main" class="w3-content w3-container">
			<div class="w3-container w3-half" style="width:70%">
				<div class="w3-center">
					<p>
						<span class="w3-content w3-text-pink w3-xxlarge">스터디 내용</span>
					</p>
				</div>
				<table class="board_view" style="width: 100%;">
					<tr>
						<th style="text-align:left; font-size:30px">제 목</th>
					</tr>
					<tr>
						<td style="border-bottom: 1px solid pink;">${study.studyname}</td>
					</tr>
					<tr>
						<th style="text-align:left; font-size:30px">내 용</th>
					</tr>
					<tr>
						<td style="border-bottom: 1px solid pink;">${study.content}</td>
					</tr>
				</table>
				<br><br>
				<div class="w3-right">
				<input type="button" class="button" onclick="javascript:message_open('../message/messageWrite.jsy?memberid=${study.memberid}')" style="width:170px" value="작성자에게 쪽지보내기">&nbsp;&nbsp;
				<c:if test="${smkind==0}">
				<input type="button" class="button" onclick="location.href='studySearchList.jsy?pageNum=${pageNum}'" value="목록">&nbsp;&nbsp;
				</c:if>
				<c:if test="${smkind!=0}">
				<input type="button" class="button" onclick="location.href='../user/mypage/managestudy.jsy?pageNum=${pageNum}&smkind=${smkind }'" value="목록">&nbsp;&nbsp;
				</c:if>
				<c:if test="${sessionScope.login.memberid == study.memberid }">
					<input type="button" class="button" onclick="javascript:updateConfirm('${pageNum}','${study.studyno}','${study.memberid}')" value="수정">&nbsp;&nbsp;
					<input type="button" class="button" onclick="javascript:deleteConfirm('${pageNum}','${study.studyno}','${study.memberid}')" value="삭제">
				</c:if>
				</div>
			</div>
			<div class="w3-container w3-half" style="width:30%">
				<div class="w3-center">
				<p>
					<span class="w3-content w3-text-pink w3-xxlarge">스터디 정보</span>
				</p>
				</div>
				<table class="w3-table w3-bordered">
					<tr>
						<th style="text-align:left;">지 역</th>
						<td style="text-align:center;">${study.region}</td>
					</tr>
					<tr>
						<th style="text-align:left;">가능인원</th>
						<td style="text-align:center;">${study.nowmember}/<c:if test="${study.limitmember==100}">∞</c:if>
							<c:if test="${study.limitmember!=100}">${study.limitmember}</c:if>
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
				<div class="w3-center" style="margin-top:10px">
				<c:if test="${study.memberid != memberid}">
						<c:if test="${scrapComfirm==0}">
							<a id="scrap" class="button w3-center w3-xlarge"><i id="scrap2" class="fa fa-heart-o"></i> 스크랩</a>
						</c:if>
						<c:if test="${scrapComfirm==1}">
							<a id="scrap" class="button w3-center w3-xlarge"><i id="scrap2" class="fa fa-heart"></i> 스크랩</a>
						</c:if>
						<c:if test="${studyGroupComfirm==0}">
							<a id="apply" class="button w3-center w3-xlarge"><i id="apply2" class="fa fa-sign-in"></i>참가신청</a>
						</c:if>
						<c:if test="${studyGroupComfirm==1}">
							<a id="apply" class="button w3-center w3-xlarge"><i id="apply2" class="fa fa-sign-out"></i>참가취소</a>
						</c:if>	
				</c:if>
				</div>
			</div>
	</div>
</body>
</html>