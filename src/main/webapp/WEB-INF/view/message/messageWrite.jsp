<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>messagewrite</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic+Coding|Song+Myung|Sunflower:300" rel="stylesheet">
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      $(".listbox").hide();
      $("#memberid").keyup(function() {
      var uid = $("#memberid").val(); //입력된 아이디
      var data = "memberid="+uid;//파라미터값 설정
      $.ajax({
         type : "POST",
         url : "./autoIdComplete.jsy",
         data : data,
         success : function(html) {
            $(".listbox").show();
            $(".namelist").html(html);
            $("li").hover(function() {
               $(this).addClass("hover");
            }, function() {
               $(this).removeClass("hover");
            });
            $("li").click(function() {
               $("#receiver").val($("#receiver").val()+$(this).text()+","); // this : li테그
               $(".listbox").hide();
            })
         }
      })
   })
   })
</script>
<style>
.button {
	width: 80px;
	height: 50px;
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

#topbar {
	opacity: 0.7;
	filter: alpha(opacity = 70);
}

#topbar:hover {
	opacity: 1.0;
	filter: alpha(opacity = 100);
}

.namelist {
	font-size:20px;
	margin: 0px;
	padding: 0px;
	list-style: none;
}

.hover {
	color: teal;
}

ul{
	list-style:none;
}
</style>
</head>
<body>
<div class="w3-bar w3-small w3-left w3-green" style="width: 100%;">
		<a href="messageList.jsy?sort=1" style="width:20%;" class="w3-bar-item w3-button w3-padding-large w3-hover-light-green"> 
			<i class="fa fa-envelope-o  w3-xxlarge"></i>
			<p>받은 쪽지함</p>
		</a> 
		<a href="messageList.jsy?sort=2" style="width:20%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-light-green"> <i
			class="fa fa-pencil-square-o  w3-xxlarge"></i>
			<p>보낸 쪽지함</p>
		</a>
		<a href="messageWrite.jsy" style="width:20%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-light-green">
			<i class="fa fa-send w3-xxlarge"></i>
			<p>쪽지 보내기</p>
		</a>
</div>
<div class="w3-content w3-container" id="main">
		<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-text-green w3-xxlarge">쪽지 보내기</span>
				</p>
			</div>
	<div style="margin-left: 15%; margin-right: 15%;">
	<form:form modelAttribute="message" action="messageWrite.jsy" method="post">
	<spring:hasBindErrors name="message">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table class="board_view" style="width: 100%;">
		<tr>
			<td>
				<b style="text-align: left; font-size: 20px;">아이디 검색</b>
			</td>
		<tr>
		<tr>
			<td>
				<input type="text" id="memberid" class="w3-input w3-border" style="width: 40%; float:left;">
				<div class="listbox w3-right" style="width:60%; float:left;">
					<div class="namelist"></div>
				</div>
				<br><br><br>
			</td>
		<tr>
		<tr>
			<td>
				<b style="text-align: left; font-size: 20px;">받는 사람</b>&nbsp;<font color="red"><form:errors path="receiver"/></font>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">
				<c:if test="${memberid!=null}">
					<form:input class="w3-input w3-border" path="receiver" id="receiver" value="${memberid},"/>
				</c:if>
				<c:if test="${memberid==null}">
					<form:input class="w3-input w3-border" path="receiver" id="receiver"/>
				</c:if>
				<br><br>
			</td>
		</tr>
		<tr>
			<td>
				<b style="text-align: left; font-size: 20px;">제 목</b>&nbsp;<font color="red"><form:errors path="subject"/></font>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">
				<form:input class="w3-input w3-border" path="subject" />
				<br><br>
			</td>
		</tr>
		<tr>
			<td>
				<b style="text-align: left; font-size: 20px;">내 용</b>&nbsp;<font color="red"><form:errors path="content"/></font>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;">
				<form:textarea class="w3-input w3-border" path="content" rows="10" cols="30"/>
				<br><br>
			</td>
		</tr>	
	</table>
	<div class="w3-right">
		<input type="submit" class="button" value="보내기">
	</div>
	<br><br><br>
	</form:form>
  	</div>
</div>

</body>
</html>
