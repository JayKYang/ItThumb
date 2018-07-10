<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>communityWrite</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
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
	-webkit-transform: scale(4);
	-moz-transform: scale(4);
	-ms-transform: scale(4);
	-o-transform: scale(4);
	transform: scale(4);
}
</style>
</head>

<style>
body, h1,h2,h3,h4,h5,h6 {font-family: "Montserrat", sans-serif}
.w3-row-padding img {margin-bottom: 12px}
@media only screen and (max-width: 600px) {#main {margin-left: 0}}
</style>

<body class="w3-black">
	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center w3-black">
		<a href="comList.jsy?communitykind=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
		<i class="fa fa-clipboard w3-xxlarge"></i>
			<p>자유 게시판</p>
		</a> 
		<a href="comList.jsy?communitykind=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
		<i class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>Q & A</p>
		</a>
		<c:if test="${!empty sessionScope.login}"> 
			<a href="comList.jsy?communitykind=3" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
			<i class=" fa fa-edit w3-xxlarge"></i>
				<p>내가 쓴 글</p>
			</a>
		</c:if>
	</nav>
<div id="main">
	<form:form name="f" modelAttribute="community">
		<table class="w3-table w3-bordered" style="width: 1500px;">
			<c:if test="${communitykind==1}">
            	<caption>자유게시판</caption>
            </c:if>
            <c:if test="${communitykind==2}">
            	<caption>Q & A</caption>
            </c:if>
			<tr>
				<th>제 목</th>
			</tr>
			<tr>
				<td>${community.subject}</td>
			</tr>
			<tr>
				<th>내 용</th>
			</tr>
			<tr>
				<td>${community.content}</td>
			</tr>
			<tr>
				<th>첨 부 파 일</th>
			</tr>
			<tr>
				<c:if test="${empty fileList }">
					<td>첨부파일이 없습니다.</td>
				</c:if>
				<c:if test="${!empty fileList}">
					<td>
					<c:forEach var="files" items="${fileList}" varStatus="status">
						<img class="scale" src="../comfiles/${files.fname}" style="height:50px; width:50px;" alt="이미지 파일이 아닙니다.">&nbsp;&nbsp;&nbsp;<a href="../comfiles/${files.fname}" download>다운로드</a>&nbsp;&nbsp;&nbsp;
						<c:if test="${status.count%5==0}">
							<br>
						</c:if>
					</c:forEach>
					</td>
				</c:if>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="location.href='comList.jsy?pageNum=${pageNum}&communitykind=${communitykind}'" value="목록">
					<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="javascript:updateConfirm('${pageNum}','${community.communityno}','${community.memberid}','${communitykind}')" value="수정">
					<input type="button" class="w3-button w3-black w3-round-xlarge" onclick="javascript:deleteConfirm('${pageNum}','${community.communityno}','${community.memberid}','${communitykind}')" value="삭제">
				</td>
			</tr>
		</table>
	</form:form>
	<br><br>
	
	<table class="w3-table w3-bordered" style="width: 1500px;">
			<caption> 댓글</caption>
			<c:if test="${empty replyList}">
				<tr>
					<td>등록 된 댓글이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${!empty replyList}">
			<tr>
					<th width="300px" height="20px" style="text-align:center;">작성자</th>
					<th width="700px" height="20px" style="text-align:center;">내용</th>
					<th width="200px" height="20px" style="text-align:center;">날짜</th>
					<th width="300px" height="20px" style="text-align:center;">비고</th>
			</tr>
			<c:forEach var="re" items="${replyList}" varStatus="status">
				<tr>
					<td width="300px" height="40px" style="text-align:left;">
						<c:if test="${re.reflevel > 0 }">
							<c:forEach begin="1" end="${re.reflevel}">&nbsp;&nbsp;&nbsp;</c:forEach>
							┖
						</c:if>
						${re.name}&nbsp;[${re.memberid}]
					</td>
					<td width="700px" height="40px" style="text-align:left;">${re.content}&nbsp;</td>
					<td width="200px" height="40px" style="text-align:center;">
						<fmt:formatDate value="${re.regdate}" pattern="yyyy-MM-dd HH:mm:ss" var="regnow" />
						${regnow}
					</td>
					<!-- onclick="javascript:replyedisp('ReplyRe')"  onclick="javascript:replyedisp('updateRe')" -->
					<td width="300px" height="40px" style="text-align:center;">
						<input type="button" id="ReplyRe_${status.index}" class="w3-button"  value="답변">
						<input type="button" id="updateRe_${status.index}" class="w3-button" value="수정">
						<input type="button" class="w3-button" onclick="javascript:deleteReplyConfirm('${pageNum}','${re.communityno}','${re.memberid }','${re.replyno}','${communitykind}')" value="삭 제">
					</td>
				</tr>
				<tr id="upinput_${status.index}" class="upinput">
					<td colspan="4">
						<form:form action="updateRe.jsy" modelAttribute="replyUpdate" method="post">
							<input type="hidden" name="replyno" value="${re.replyno}">
							<input type="hidden" name="memberid" value="${re.memberid}">
							<input type="hidden" value="${communityno}" name="communityno">
							<input type="hidden" value="${communitykind}" name="communitykind">
							<input type="hidden" value="${pageNum}" name="pageNum">
								<form:input path="content" size="170px"/>
								<input type="submit" class="w3-button" value="수 정">
								<font color="red"><form:errors path="content"/></font>
						</form:form>
					</td>
				</tr>
				<tr id="reinput_${status.index}" class="reinput">
					<td colspan="4">
						<form:form action="replyRe.jsy" modelAttribute="replyRe" method="post">
							<input type="hidden" name="replyno" value="${re.replyno}">
							<input type="hidden" value="${communityno}" name="communityno">
							<input type="hidden" value="${communitykind}" name="communitykind">
							<input type="hidden" value="${pageNum}" name="pageNum">
								<form:input path="content" size="170px"/>
								<input type="submit" class="w3-button" value="등 록">
								<font color="red"><form:errors path="content"/></font>
						</form:form>
					</td>
				</tr>
			</c:forEach>
			</c:if>
	</table>
	
	<form:form modelAttribute="reply" action="replyCreate.jsy" method="post">
		<input type="hidden" value="${communityno}" name="communityno">
		<input type="hidden" value="${communitykind}" name="communitykind">
		<input type="hidden" value="${pageNum}" name="pageNum">
		<div style="width: 1500px;">
			<form:input path="content" size="170px"/>
			<input type="submit" class="w3-button" value="등 록">
			<font color="red"><form:errors path="content"/></font>
		</div>
	</form:form>
</div>
</body>
</html>