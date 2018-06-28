<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
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
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
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
       function change_date(){
            birth = document.getElementById("datePicker").value
            document.getElementById("birth").value = birth
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
		<div id="info" class="mypage">
			<form:form modelAttribute="user" method="post" action="mypage.jsy">
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
						<td>아이디</td><td><form:input path="memberid" class="w3-input" readonly="true"/><font color="red"><form:errors path="memberid" readonly="true"/></font></td>
					</tr>
					<tr>
						<td>이름</td><td><form:input path="name" class="w3-input" /><font color="red"><form:errors path="name" id="name"/></font></td>
					</tr>
					<tr>
						<td>패스워드</td><td><form:password path="password" class="w3-input"/><font color="red"><form:errors path="password"/></font></td>
					</tr>
					<tr>
						<td>생일</td><td><input type="date" id="datePicker" class="w3-input" onchange="change_date()"><form:hidden id="birth" path="birth" class="w3-input" value=""/><font color="red"><form:errors path="birth"/></font></td>
					</tr>
					<script>document.getElementById("datePicker").value =  document.getElementById("birth").value</script>
					<tr>
						<td>연락처</td><td><form:input path="tel" class="w3-input" /><font color="red"><form:errors path="tel"/></font></td>
					</tr>
					<tr>
						<td>거주 지역</td><td><form:input path="address" class="w3-input"/><font color="red"><form:errors path="address"/></font></td>
					</tr>
					<tr>
						<td>포트폴리오 link</td><td><form:input class="w3-input" path="site"/><font color="red"><form:errors path="site"/></font></td>
					</tr>	
					<tr>
						<td>소개 한 마디</td><td><form:input path="slogun" class="w3-input"/><font color="red"><form:errors path="slogun"/></font></td>
					</tr>
					<tr>
						<td>자기 소개</td><td><form:input path="introduce" class="w3-input"/><font color="red"><form:errors path="introduce"/></font></td>
					</tr>
					<tr>
						<td class="w3-center"><input class="w3-button" type="button" value="회원탈퇴" onclick=""></td>
						<td class="w3-center"><input class="w3-button" type="submit" value="수정"></td>
					</tr>
				</table>
			</form:form>
		</div>
		
		<div id="portfolio" class="mypage" style="display:none">
			<h2>포트폴리오 관리</h2>
		</div>
		<div id="study" class="mypage" style="display:none">
			<h2>스터디 관리</h2>
		</div>
		<div id="employment" class="mypage" style="display:none">
			<h2>채용공고 스크랩</h2>
		</div>
		<div id="message" class="mypage" style="display:none">
			<h2>쪽지함</h2>
		</div>
	</div>
</body>
</html>