<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>messageInfo</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic+Coding|Song+Myung|Sunflower:300" rel="stylesheet">
<head>
<style>
.button {
	width: 60px;
	height: 30px;
}

.button {
	border-radius: 4px;
	background-color: green;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 5px;
	transition: all 0.5s;
	cursor: pointer;
}

.button:hover {
	background-color: #98FB98;
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
body {font-family: 'Do Hyeon', sans-serif;}
h1,h2,h3,h4,h5,h6 {
    font-family: "Playfair Display";
    /* font-family: 'Song Myung', serif;  */
    /* font-family: 'Nanum Gothic Coding', monospace; 
    font-family: 'Sunflower', sans-serif; */
    letter-spacing: 5px;
}

#topbar{
	opacity:0.7;
	filter:alpha(opacity=70);
}

#topbar:hover{
	opacity:1.0;
	filter: alpha(opacity=100);
}
</style>
</head>
<body>
	<div class="w3-bar w3-small w3-left w3-green" style="width: 100%;">
		<a href="messageList.jsy?sort=1"
			class="w3-bar-item w3-button w3-padding-large w3-hover-light-green">
			<i class="fa fa-envelope-o  w3-xxlarge"></i>
			<p>받은 쪽지함</p>
		</a> <a href="messageList.jsy?sort=2"
			class="w3-bar-item w3-button w3-padding-large w3-hover-light-green">
			<i class="fa fa-pencil-square-o  w3-xxlarge"></i>
			<p>보낸 쪽지함</p>
		</a> <a href="messageWrite.jsy"
			class="w3-bar-item w3-button w3-padding-large w3-hover-light-green">
			<i class="fa fa-send w3-xxlarge"></i>
			<p>쪽지 보내기</p>
		</a>
	</div>
	<div class="w3-content w3-container" id="main">
		<c:if test="${sort==1}">
			<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-text-green w3-xxlarge">받은 쪽지 상세보기</span>
				</p>
			</div>
		</c:if>
		<c:if test="${sort==2}">
			<div class="w3-center" style="width: 100%">
				<p>
					<span class="w3-content w3-text-green w3-xxlarge">보낸 쪽지 상세보기</span>
				</p>
			</div>
		</c:if>
		<div style="margin-left: 15%; margin-right: 15%;">
			<form:form modelAttribute="message" method="post"
				action="messagedelete.jsy">
				<input type="hidden" name="sort" value="${sort}">
				<input type="hidden" name="messageno" value="${messageno}">
				<input type="hidden" name="pageNum" value="${pageNum}">
				<input type="hidden" name="idchks" value="${message.messageno}">
				<table class="board_view" style="width: 100%;">
					<c:if test="${sort==1}">
						<tr>
							<td><b style="text-align: left; font-size: 30px;">보낸 사람</b>
							</td>
						</tr>
						<tr>
							<td style="text-align: left; border-bottom: 1px solid green;">
								${message.sender}<br>
							<br>
							</td>
						</tr>
					</c:if>
					<c:if test="${sort==2}">
						<tr>
							<td><b style="text-align: left; font-size: 30px;">받는 사람</b>
							</td>
						</tr>
						<tr>
							<td style="text-align: left; border-bottom: 1px solid green;">
								${message.receiver}<br>
							<br>
							</td>
						</tr>
					</c:if>
					<tr>
						<td><b style="text-align: left; font-size: 30px;">제목</b></td>
					</tr>
					<tr>
						<td style="text-align: left; border-bottom: 1px solid green;">
							${message.subject }<br>
						<br>
						</td>
					</tr>
					<tr>
						<td><b style="text-align: left; font-size: 30px;">내용</b></td>
					</tr>
					<tr>
						<td style="text-align: left; border-bottom: 1px solid green;">
							${message.content }<br>
						<br>
						</td>
					</tr>
				</table>
				<div class="w3-right" style="margin-top: 10px;">
					<input type="button" class="button"
						onclick="location.href='messageList.jsy?sort=${sort}&pageNum=${pageNum}'"
						value="목록"> &nbsp; <input type="submit" class="button"
						value="삭제">
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>