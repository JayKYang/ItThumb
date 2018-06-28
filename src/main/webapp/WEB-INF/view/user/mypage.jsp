<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script>
function openMypage(mypageName) {
    var i;
    var x = document.getElementsByClassName("mypage");
    for (i = 0; i < x.length; i++) {
        x[i].style.display = "none"; 
    }
    document.getElementById(mypageName).style.display = "block"; 
}
</script>
</head>
<body>
	<div class="w3-container w3-padding-32" style="width:70%; margin-left:15%;">
		<div class="w3-cell-row ">
			<p>마이페이지</p>
		</div>
		<div class="w3-cell-row">
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('info')">
			  <p>회원정보</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('portfolio')">
			  <p>포트폴리오 관리</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('study')">
			  <p>스터디 관리</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employment')">
			  <p>채용공고 스크랩</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('message')">
			  <p>쪽지함</p>
			</div>
		</div><hr>
		<div id="info" class="mypage w3-animate-bottom">
			<form:form modelAttribute="user" method="post" action="update.shop">
				<spring:hasBindErrors name="user">
					<font color="red">
						<c:forEach items="${errors.globalErrors }" var="error">
							<spring:message code="${error.code }"/>
						</c:forEach>
					</font>
				</spring:hasBindErrors>
				<table class="w3-table">
					<tr>
						<td align="center">사진</td>
						<td>
							<div id="profile">
								<img id="profilephoto" src="../photo/defaultphoto.png"  style="height:200px; width:150px;" alt="이미지 파일이 아닙니다.">
							</div>
							<input type="file" name="image" id="image"/>
						</td>
					</tr>
					<tr>
						<td>아이디</td><td><form:input path="memberid" class="w3-input"/><font color="red"><form:errors path="memberid" readonly="true"/></font></td>
					</tr>
					<tr>
						<td>이름</td><td><form:input path="name" class="w3-input" /><font color="red"><form:errors path="name"/></font></td>
					</tr>
					<tr>
						<td>패스워드</td><td><form:password path="password" class="w3-input"/><font color="red"><form:errors path="password"/></font></td>
					</tr>
					<tr>
						<td>포트폴리오 link</td><td><form:input class="w3-input" path="site"/><font color="red"><form:errors path="site"/></font></td>
					</tr>	
					<tr>
						<td>연락처</td><td><form:input path="tel" class="w3-input" /><font color="red"><form:errors path="tel"/></font></td>
					</tr>
					<tr>
						<td>거주 지역</td><td><form:input path="address" class="w3-input"/><font color="red"><form:errors path="address"/></font></td>
					</tr>
					<tr>
						<td>소개 한 마디</td><td><form:input path="slogun" class="w3-input"/><font color="red"><form:errors path="slogun"/></font></td>
					</tr>
					<tr>
						<td>자기 소개</td><td><form:input path="introduce" class="w3-input"/><font color="red"><form:errors path="introduce"/></font></td>
					</tr>
					<tr>
						<td class="w3-center"><input class="w3-button" value="회원탈퇴"></td>
						<td class="w3-center"><input class="w3-button" value="수정"></td>
					</tr>
				</table>
			</form:form>
		</div>
		
		<div id="portfolio" class="mypage w3-animate-bottom" style="display:none">
			<h2>포트폴리오 관리</h2>
		</div>
		<div id="study" class="mypage w3-animate-bottom" style="display:none">
			<h2>스터디 관리</h2>
		</div>
		<div id="employment" class="mypage w3-animate-bottom" style="display:none">
			<h2>채용공고 스크랩</h2>
		</div>
		<div id="message" class="mypage w3-animate-bottom" style="display:none">
			<h2>쪽지함</h2>
		</div>
	</div>
</body>
</html>