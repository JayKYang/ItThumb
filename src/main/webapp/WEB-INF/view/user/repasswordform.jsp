<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 비밀번호 변경</title>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<spring:hasBindErrors name="user">
			<c:forEach items="${errors.globalErrors }" var="error">
				alert('<spring:message code="${error.code }"></spring:message>');
			</c:forEach>
		</spring:hasBindErrors>
	})
</script>
<style>
	button{
		width:200px;
		height:80px;
		margin-left:20px;
	}
   	button {
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
	button:hover {
	  background-color: pink;
	}
	
	button span {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	button span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	}
	
	button:hover span {
	  padding-right: 25px;
	}
	
	button:hover span:after {
	  opacity: 1;
	  right: 0;
	}
</style>
</head>
<body>
<div class="w3-content w3-padding-64">
	<div>
		<p>
			<span class="w3-content w3-text-indigo w3-xxlarge">새 비밀번호 변경</span>
		</p>
	</div>
	<div class="w3-content">
		<div class="w3-half w3-center" style="width:50%">
			<img src="../mainimg/logo.png" style="width:90%">
		</div>
		<hr>
		<div class="w3-half" style="width:50%;">
			<form:form modelAttribute="user" method="post" name="f" action="repasswordform.jsy">
				<p>
				<label>아이디</label>
				${user.memberid }
				<font color="red"><form:errors path="memberid"/></font>
				</p>
				<p>
				<label>새 비밀번호</label>
				<form:password class="w3-input" path="password" />
				<font color="red"><form:errors path="password"/></font>
				</p>
				<p>
				<label>새 비밀번호 확인</label>
				<input class="w3-input" type="password" name="passconfirm">
				</p>
				<input type="submit" style="display:none;">
				<button class="w3-right" onclick="javascript:document.f.submit()">비밀번호변경</button>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>