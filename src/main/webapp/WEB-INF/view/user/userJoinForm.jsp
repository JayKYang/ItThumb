<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 회원가입</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<spring:hasBindErrors name="user">
			<c:forEach items="${errors.globalErrors }" var="error">
				alert('<spring:message code="${error.code }"></spring:message>');
			</c:forEach>
		</spring:hasBindErrors>
	})
	
	$(function() {
	    $("#image").on('change', function(){
	        readURL(this);
	    });
	});
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	
	    reader.onload = function (e) {
	            $('#profilephoto').attr('src', e.target.result);
	        }
	
	      reader.readAsDataURL(input.files[0]);
	    }
	}
</script>
<style>
	.button{
		width:150px;
		height:60px;
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
</head>
<body>
	<div class="w3-content w3-padding-64">
		<h1>회원가입</h1>
		<div>
			<p>
				<span class="w3-content w3-text-gray w3-xlarge" style="width:80%;margin-left:10%;"><a href="selectJoin.jsy" style="text-decoration:none;">가입유형선택</a></span>&nbsp;&nbsp;
				<span class="w3-content w3-text-indigo w3-xxlarge">회원정보입력</span>
			</p>
		</div>
		<hr>
		<div class="w3-content w3-container" style="margin-left:15%;">
			<div class="w3-container w3-indigo">
				<span class="w3-text-white w3-xlarge">일반 사용자</span><br>
			</div>
			<form:form style="container" modelAttribute="user" action="joinForm.jsy" name="f" method="post" enctype="multipart/form-data">
				<input type="hidden" name="kind" value="${kind }">
				<label>회원 사진</label>
				<div id="profile">
					<img id="profilephoto" src="../photo/defaultphoto.png"  style="height:150px; width:150px;" alt="이미지 파일이 아닙니다.">
				</div>
				<input type="file" name="image" id="image"/>
				<p>
				<label>이메일</label>
				<form:input class="w3-input" path="memberid" />
				<font color="red"><form:errors path="memberid"/></font>
				</p>
				<p>
				<label>비밀번호</label>
				<form:password class="w3-input" path="password" />
				<font color="red"><form:errors path="password"/></font>
				</p>
				<p>
				<label>비밀번호 확인</label>
				<input class="w3-input" type="password" name="passconfirm">
				</p>
				<p>
				<label>이름</label>
				<form:input class="w3-input" path="name"/>
				<font color="red"><form:errors path="name"/></font>
				</p>
				<div class="w3-container">
					<input type="button" id="btn1" class="button w3-left" onclick="javascript:location.href='selectJoin.jsy'" value="뒤로가기">
					<input type="submit" id="btn2" class="button w3-right" onclick="document.f.submit()" value="회원가입">
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>