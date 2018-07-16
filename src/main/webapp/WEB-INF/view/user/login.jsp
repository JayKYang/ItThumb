<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContact.request.contextPath }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 로그인</title>
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
<div class="w3-content w3-padding-64" style="margin-bottom:20%;">
	<div>
		<p>
			<span class="w3-content w3-text-indigo w3-xxlarge">로그인</span>
		</p>
	</div>
	<hr>
	<div class="w3-content">
		<div class="w3-half w3-center" style="width:50%">
			<img src="../mainimg/logo.png" style="width:90%">
		</div>
		<div class="w3-half" style="width:50%">
			<div class="w3-container">
				<form:form modelAttribute="user" method="post" name="f" action="login.jsy">
					<p>
					<label>아이디</label>
					<form:input class="w3-input" path="memberid" />
					<font color="red"><form:errors path="memberid"/></font>
					</p>
					<p>
					<label>비밀번호</label>
					<form:password class="w3-input" path="password" />
					<font color="red"><form:errors path="password"/></font>
					</p>
					<input type="submit" style="display:none;">
				</form:form>
			</div>
			<div class="w3-container">
				<div class="w3-half">
					<p>회원이 아니신가요?&nbsp;<a href="selectJoin.jsy" class="w3-text-blue">회원가입</a></p>
					<p>비밀번호가 기억안나세요?&nbsp;<a href="javascript:find_password('findpassword.jsy')" class="w3-text-blue">비밀번호찾기</a></p>
				</div>
				<div class="w3-half w3-right">
					<button onclick="javascript:document.f.submit()" value="로그인">로그인</button>		
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>