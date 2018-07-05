<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>messageInfo</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.w3-sidebar {width: 120px;background: #222;}
#main {margin-left: 120px}
</style>
<body>

<nav class="w3-sidebar w3-bar-block w3-small w3-center">
  <a href="messageList.jsy?sort=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">받은 쪽지함</p>
  </a>
  <a href="messageList.jsy?sort=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">보낸 쪽지함</p>
  </a>
  <a href="messageWrite.jsy" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">쪽지 보내기</p>
  </a>
</nav>

<div class="w3-container" id="main">
	<div>
		<c:if test="${sort==1}">
			<h2>받은 쪽지 상세정보</h2>
		</c:if>
		<c:if test="${sort==2}">
			<h2>보낸 쪽지 상세정보</h2>
		</c:if>
		
	</div>
	<form:form modelAttribute="message" method="post" action="messagedelete.jsy">					
		<input type="hidden" name="sort" value="${sort}">
		<input type="hidden" name="messageno" value="${messageno}">
		<input type="hidden" name="pageNum" value="${pageNum}">
		<input type="hidden" name="idchks" value="${message.messageno}">
		<c:if test="${sort==1}">
		<p>
			<label> <b>보낸 사람</b></label><br> 
			<input name="sender" type="text" value="${message.sender}" readonly="readonly">
		</p>
		</c:if>
		<c:if test="${sort==2}">
		<p>
			<label> <b>받는 사람</b></label><br>
			<input name="receiver" type="text" value="${message.receiver}" readonly="readonly">
		</p>
		</c:if>
		<p>
			<label ><b>제목</b></label><br>
			<input name="subject" type="text" value="${message.subject }" readonly="readonly">
		</p>
		<p>
			<label><b>내용</b></label><br>
			<textarea rows="20" cols="60" name="content" readonly="readonly">${message.content }</textarea>
		</p>
		<p>
			<input type="button" onclick="location.href='messageList.jsy?sort=${sort}&pageNum=${pageNum}'" value="목록">
			<input type="submit" value="삭제">
		</p>
	</form:form>
</div>
</body>
</html>
