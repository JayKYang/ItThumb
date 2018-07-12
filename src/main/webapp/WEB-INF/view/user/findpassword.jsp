<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link
	href="https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic+Coding|Song+Myung|Sunflower:300"
	rel="stylesheet">
<title>잇썸 > 비밀번호 찾기</title>
<style>
body {
	font-family: 'Do Hyeon', sans-serif;
}

h1, h2, h3, h4, h5, h6 {
	font-family: "Playfair Display";
	/* font-family: 'Song Myung', serif;  */
	/* font-family: 'Nanum Gothic Coding', monospace; 
    font-family: 'Sunflower', sans-serif; */
	letter-spacing: 5px;
}
</style>
<style>
.button {
	width: 150px;
	height: 60px;
}

.button {
	border-radius: 4px;
	background-color: skyblue;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 20px;
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
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		<spring:hasBindErrors name="user">
		<c:forEach items="${errors.globalErrors }" var="error">
		alert('<spring:message code="${error.code }"></spring:message>');
		</c:forEach>
		</spring:hasBindErrors>
	})
</script>
</head>
<body>
<div class="w3-content">
	<div>
		<p>
			<span class="w3-content w3-text-indigo w3-xxlarge">비밀번호찾기</span>
		</p>
	</div>
	<hr>
	<div class="w3-content w3-padding-64">
		<div class="w3-half" style="width: 50%">
			<img src="../mainimg/logo.png" style="width: 90%">
		</div>
		<div class="w3-half" style="width: 50%">
			<div class="w3-container">
				<form:form modelAttribute="user" method="post" name="f"	action="findpassword.jsy">
					<p>
						<label>아이디</label>
						<form:input class="w3-input" path="memberid" />
						<font color="red"><form:errors path="memberid" /></font>
					</p>
					<input type="submit" style="display:none;">
				</form:form>
			</div>
			<button class="button w3-right" onclick="javascript:document.f.submit()" style="margin-right:30px;">메일전송하기</button>
		</div>
	</div>
</div>
</body>
</html>