<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>잇썸 > 커뮤니티 > ${community.subject }</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	function deleteConfirm(pageNum, communityno, memberid, communitykind) {
		if(confirm("정말 삭제할까요?") == true){
			location.href="communityDelete.jsy?pageNum="+pageNum+"&communityno="+communityno+"&memberid="+memberid+"&communitykind="+communitykind;
		}else{
			return;
		}
	}
	function updateConfirm(pageNum, communityno, memberid, communitykind) {
		if(confirm("수정 할까요?") == true){
			location.href="communityUpdate.jsy?pageNum="+pageNum+"&communityno="+communityno+"&memberid="+memberid+"&communitykind="+communitykind;
		}else{
			return;
		}
	}
	function deleteReplyConfirm(pageNum, communityno, memberid, replyno, communitykind) {
		if(confirm("댓글을 정말 삭제할까요?") == true){
			location.href="replyDelete.jsy?pageNum="+pageNum+"&communityno="+communityno+"&memberid="+memberid+"&replyno="+replyno+"&communitykind="+communitykind;
		}else{
			return;
		}
	}
	
	function message_open(url) {
		var h = screen.height * (3 / 4);
		var w = screen.width * (1.3 / 3);
		window.open(url, "message", "width=" + w + ", height=" + h
				+ ", left=100, top=100");
	}

	$(document).ready(function() {
		
			$('.upinput').hide();
			$('.reinput').hide();
			<c:forEach items="${replyList}" varStatus="status">
				$('#ReplyRe_'+${status.index}).click(function(){
					rechange_${status.index}();
				});
				$('#updateRe_'+${status.index}).click(function(){
					upchange_${status.index}();
				});
				function rechange_${status.index}() {
					$('#reinput_'+${status.index}).toggle();
				}
				function upchange_${status.index}() {
					$('#upinput_'+${status.index}).toggle();
				}
				
				/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
				$('#Select_'+${status.index}).click(function(e){
					var sWidth = window.innerWidth;
					var sHeight = window.innerHeight;

					var oWidth = $('#popupLayer_'+${status.index}).width();
					var oHeight = $('#popupLayer_'+${status.index}).height();

					// 레이어가 나타날 위치를 셋팅한다.
					var divLeft = e.clientX;
					var divTop = e.clientY;

					// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
					if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
					if( divTop + oHeight > sHeight ) divTop -= oHeight;
					
					// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
					if( divLeft < 0 ) divLeft = 0;
					if( divTop < 0 ) divTop = 0;

					$('#popupLayer_'+${status.index}).css({
						"top": divTop,
						"left": divLeft,
						"position": "fiexd"
					}).show();
				});
				$('#popupLayer_'+${status.index}).on('mousewheel DOMMouseScroll', function(e) {
					$('#popupLayer_'+${status.index}).hide();
	            });
				$('#popupLayer_'+${status.index}).mouseleave(function() {
					$('#popupLayer_'+${status.index}).hide();
				});
				
			</c:forEach>
	});
</script>
<style type="text/css">
.scale {
	-webkit-transform: scale(1);
	-moz-transform: scale(1);
	-ms-transform: scale(1);
	-o-transform: scale(1);
	transform: scale(1);
	-webkit-transition: all 0.3s ease-in-out;
	-moz-transition : all 0.3s ease-in-out;
	transition: all 0.3s ease-in-out;
}

.scale:hover {
	-webkit-transform: scale(5);
	-moz-transform: scale(5);
	-ms-transform: scale(5);
	-o-transform: scale(5);
	transform: scale(5);
}
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

/* 여기부터 */
.Select {
	cursor: pointer;
}

.popupLayer {
	position: fixed;
	display: none;
	text-align: center;
	background-color: #FFE4B5;
	border: solid 1px #d0d0d0;
	width: 100px;
	height: 40px;
	padding: 10px;
}
.popupLayer div {
	position: fixed;
	text-align: center;
	top: 5px;
	right: 5px
}

.popupLayer:hover {
	background-color: #FFE4B5;
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
		<form:form name="f" modelAttribute="community">
			<table class="board_view" style="width: 100%;">
				<c:if test="${communitykind==1}">
					<div class="w3-center" style="width: 100%;">
						<p>
							<span class="w3-content w3-text-amber w3-xxlarge">자유게시판</span>
						</p>
					</div>
				</c:if>
				<c:if test="${communitykind==2}">
					<div class="w3-center" style="width: 100%;">
						<p>
							<span class="w3-content w3-text-amber w3-xxlarge">Q & A</span>
						</p>
					</div>
				</c:if>
				<tr>
					<th style="text-align: left; font-size: 30px">제 목</th>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid orange;">${community.subject}<br><br></td>
				</tr>
				<tr>
					<th style="text-align: left; font-size: 30px">내 용</th>
				</tr>
				<tr>
					<td style="border-bottom: 1px solid orange;">${community.content}<br><br></td>
				</tr>
				<tr>
					<th style="text-align: left; font-size: 30px">첨 부 파 일</th>
				</tr>
				<tr>
					<c:if test="${empty fileList }">
						<td style="text-align: center;">첨부파일이 없습니다.</td>
					</c:if>
					<c:if test="${!empty fileList}">
						<td style="border-bottom: 1px solid orange;"><c:forEach var="files" items="${fileList}"
								varStatus="status">
								<img class="scale" src="../comfiles/${files.fname}"
									style="height: 50px; width: 50px;" alt="이미지 파일이 아닙니다.">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
									href="../comfiles/${files.fname}" download>다운로드</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<c:if test="${status.count%5==0}">
									<br>
								</c:if>
							</c:forEach><br><br></td>
					</c:if>
				</tr>
			</table>
			<div class="w3-right" style="margin-top: 10px">
				<input type="button" class="button"
					onclick="location.href='comList.jsy?pageNum=${pageNum}&communitykind=${communitykind}'"
					value="목록">
				<c:if test="${sessionScope.login.memberid == community.memberid }">
					<input type="button" class="button"
						onclick="javascript:updateConfirm('${pageNum}','${community.communityno}','${community.memberid}','${communitykind}')"
						value="수정">
					<input type="button" class="button"
						onclick="javascript:deleteConfirm('${pageNum}','${community.communityno}','${community.memberid}','${communitykind}')"
						value="삭제">
				</c:if>
			</div>
		</form:form>
		<br>
		<br>

		<div class="w3-center" style="width: 100%;">
			<p>
				<span class="w3-content w3-text-amber w3-xxlarge">댓 글</span>
			</p>
		</div>
		<table class="w3-table w3-bordered" style="width: 100%;">

			<c:if test="${empty replyList}">
				<tr>
					<td style="text-align: center;">등록 된 댓글이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty replyList}">
				<!-- 여기부터 -->
				<tr style="border-bottom: 1px solid orange;">
					<th style="text-align: center; width: 20%;">작성자</th>
					<th style="text-align: center; width: 40%;">내용</th>
					<th style="text-align: center; width: 20%;">날짜</th>
					<th style="text-align: center; width: 20%;">비고</th>
				</tr>
				<c:forEach var="re" items="${replyList}" varStatus="status">
				<div class="popupLayer" id="popupLayer_${status.index}">
					<a onclick="javascript:message_open('../message/messageWrite.jsy?memberid=${re.memberid}')">쪽지 보내기</a>
				</div>
					<tr style="border-bottom: 1px solid orange;">
						<td style="text-align: left;"><c:if
								test="${re.reflevel > 0 }">
								<c:forEach begin="1" end="${re.reflevel}">&nbsp;&nbsp;&nbsp;</c:forEach>
							┖
						</c:if> 
							<a class="Select" id="Select_${status.index}">${re.name}</a>
							
						</td>
						<td style="text-align: left;">${re.content}&nbsp;</td>
						<td style="text-align: center;"><fmt:formatDate
								value="${re.regdate}" pattern="yyyy-MM-dd HH:mm:ss" var="regnow" />
							${regnow}</td>
						<td style="text-align: center;"><a class="button"
							id="ReplyRe_${status.index}" style="width: 15px;"> <i
								class="fa fa-reply w3-large"></i>
						</a>&nbsp; <a class="button" id="updateRe_${status.index}"
							style="width: 15px;"> <i class="fa fa-edit w3-large"></i>
						</a>&nbsp; <a class="button" style="width: 15px;"
							onclick="javascript:deleteReplyConfirm('${pageNum}','${re.communityno}','${re.memberid }','${re.replyno}','${communitykind}')">
								<i class="fa fa-close w3-large"></i>
						</a>&nbsp;</td>
					</tr>
					<tr id="upinput_${status.index}" class="upinput" style="border-bottom: 1px solid orange;">
						<td colspan="4"><form:form action="updateRe.jsy"
								modelAttribute="replyUpdate" method="post">
								<input type="hidden" name="replyno" value="${re.replyno}">
								<input type="hidden" name="memberid" value="${re.memberid}">
								<input type="hidden" value="${communityno}" name="communityno">
								<input type="hidden" value="${communitykind}"
									name="communitykind">
								<input type="hidden" value="${pageNum}" name="pageNum">
								<font color="red"><form:errors path="content" /></font>
								<div style="width: 100%;">
									<form:input path="content" style="width: 90%;" />
									<input type="submit" class="button" value="수 정">
								</div>
							</form:form></td>
					</tr>
					<tr id="reinput_${status.index}" class="reinput" style="border-bottom: 1px solid orange;">
						<td colspan="4"><form:form action="replyRe.jsy"
								modelAttribute="replyRe" method="post">
								<input type="hidden" name="replyno" value="${re.replyno}">
								<input type="hidden" value="${communityno}" name="communityno">
								<input type="hidden" value="${communitykind}"
									name="communitykind">
								<input type="hidden" value="${pageNum}" name="pageNum">
								<font color="red"><form:errors path="content" /></font>
								<div style="width: 100%;">
									<form:input path="content" style="width: 90%;" />
									<input type="submit" class="button" value="답 변">
								</div>
							</form:form></td>
					</tr>
				</c:forEach>
			</c:if>
		</table>

		<form:form modelAttribute="reply" action="replyCreate.jsy"
			method="post">
			<input type="hidden" value="${communityno}" name="communityno">
			<input type="hidden" value="${communitykind}" name="communitykind">
			<input type="hidden" value="${pageNum}" name="pageNum">
			<font color="red"><form:errors path="content" /></font>
			<div style="width: 100%;">
				<form:input path="content" style="width: 90%;" />
				<input type="submit" class="button" style="margin-top: 5px"
					value="등 록">
			</div>
		</form:form>
	</div>
</body>
</html>