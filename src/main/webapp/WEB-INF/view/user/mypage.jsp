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
			<form>
				<table class="w3-table">
					<tr>
						<td>사진</td>
						<td><input type="button" value="사진첨부" name="image"/></td>
					</tr>
					<tr>
						<td>이름</td><td><input class="w3-input" type="text" name="name"/></td>
					</tr>
					<tr>
						<td>비밀번호</td><td><input class="w3-input" type="password" name="pass"/></td>
					</tr>
					<tr>
						<td>생일</td><td><input class="w3-input" type="date" name="birth"/></td>
					</tr>				
					<tr>
						<td>연락처</td><td><input class="w3-input" type="text" name="tel"/></td>
					</tr>				
					<tr>
						<td>포트폴리오 link</td><td><input class="w3-input" type="text" name="link"/></td>
					</tr>				
					<tr>
						<td>거주 지역</td><td><input class="w3-input" type="text" name="address"/></td>
					</tr>				
					<tr>
						<td>소개 한 마디</td><td><input class="w3-input" type="text" name="slogun"/></td>
					</tr>				
					<tr>
						<td>자기 소개</td><td><textarea class="w3-input"  name="introduce"></textarea></td>
					</tr>				
					<tr>
						<td class="w3-center"><input class="w3-button" value="회원탈퇴"></td>
						<td class="w3-center"><input class="w3-button" value="수정"></td>
					</tr>
				</table>
			</form>
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