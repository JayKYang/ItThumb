<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script>
	$(document).ready(function(){
		url = document.URL.split("#");
		openMypage(url[1])
	});
	function openMypage(mypageName) {
	    var i;
	    var x = document.getElementsByClassName("mypage");
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none"; 
	    }
	    document.getElementById(mypageName).style.display = "block"; 
	}
</script>
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
       
        // input date 타입 사용시 폼 전달
       /* function change_date(){
            birth = document.getElementById("datePicker").value
            document.getElementById("birth").value = birth
       }  */
       
       // 사진 파일추가버튼 없이 이미지눌렀을 때 클릭이벤트 발생시키는 자바스크립트
       function eventOccur(evEle, evType){
    	   if (evEle.fireEvent) {
    	   evEle.fireEvent('on' + evType);
    	   } else {
    	   //MouseEvents가 포인트 그냥 Events는 안됨~ ??
    	   var mouseEvent = document.createEvent('MouseEvents');
    	   /* API문서 initEvent(type,bubbles,cancelable) */
    	   mouseEvent.initEvent(evType, true, false);
    	   var transCheck = evEle.dispatchEvent(mouseEvent);
    	   if (!transCheck) {
    	   //만약 이벤트에 실패했다면
    	   console.log("클릭 이벤트 발생 실패!");
    	   }
    	   }
    	  }
    	  /** 대체버튼 클릭시 강제 이벤트 발생**/
    	  function fileUpload(){
    	   eventOccur(document.getElementById('image'),'click');
    	   /* alert(orgFile.value); 이벤트 처리가 끝나지 않은 타이밍이라 값 확인 안됨! 시간차 문제 */
    	  }
</script>
</head>
<body>
	<div class="w3-container w3-padding-32" style="width:70%; margin-left:15%;">
		<div class="w3-cell-row">
			<p>마이페이지</p>
		</div>
		<!-- <div class="w3-cell-row">
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('info')" style="width:200px; float:left;">
			  <p>회원정보</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('portfolio')" style="width:200px; float:left;">
			  <p>포트폴리오 관리</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('study')" style="width:200px; float:left;">
			  <p>스터디 관리</p>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employment')" style="width:200px; float:left;">
			  <p>채용공고 스크랩</p>
			</div>
		</div> -->
		<div class="w3-cell-row">
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('info')" style="width:200px; float:left;">
			  <a href="#info" class="w3-button"><p>회원정보</p></a>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('portfolio')" style="width:200px; float:left;">
			  <a href="#portfolio" class="w3-button"><p>포트폴리오 관리</p></a>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('study')" style="width:200px; float:left;">
			  <a href="#study" class="w3-button"><p>스터디 관리</p></a>
			</div>
			<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employment')" style="width:200px; float:left;">
			  <a href="#employment" class="w3-button"><p>채용공고 스크랩</p></a>
			</div>
		</div>
		<hr>
		<div id="info" class="mypage">
			<form:form modelAttribute="user" method="post" action="mypage.jsy" enctype="multipart/form-data">
				<form:hidden path="imageUrl" />
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
								<c:if test="${empty sessionScope.login.imageUrl }">
									<img class="w3-button" id="profilephoto" src="../photo/defaultphoto.png"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
								</c:if>
								<c:if test="${!empty sessionScope.login.imageUrl }" >
									<img class="w3-button" id="profilephoto" src="../photo/${sessionScope.login.imageUrl }"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
								</c:if>
								<input type="file" name="image" id="image" style="display:none"/>
							</div>
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
					<%-- <tr>
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
					</tr> --%>
					<tr>
						<td class="w3-center"><input class="w3-button" type="button" value="회원탈퇴" onclick="location.href='delete.jsy?id=${login.memberid}'"></td>
						<td class="w3-center"><input class="w3-button" type="submit" value="수정"></td>
					</tr>
				</table>
			</form:form>
		</div>
		
		<div id="portfolio" class="mypage" style="display:none">
			<c:if test="${sessionScope.login.createpf == 0 }">
				등록된 포트폴리오가 없습니다.<br>
				<button onclick="javascript:location.href='portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'">포트폴리오 작성</button>
			</c:if>
			<c:if test="${sessionScope.login.createpf == 1 }">
				<h3>포트폴리오 목록</h3>
				<fmt:formatDate value="${sessionScope.login.modifydate }" type="both" pattern="yyyy-MM-dd HH:MM:SS" var="modifydate"/>
				<div class="w3-content w3-center" style="width:100%">
					<table class="w3-table">
						<tr><th style="width:30%" align="center">수정날짜</th><th style="width:40%">포트폴리오 이름</th><th style="width:5%"></th><th style="width:5%"></th><th style="width:5%"></th></tr>           	
						<tr>
							<td>${modifydate }</td><td>${sessionScope.login.slogun}</td>
							<td><a href="portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}"><i class="fa fa-eye w3-button"></i></a></td>
							<td><i class="fa fa-edit w3-button" onclick="javascript:location.href='portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'"></i></td>
							<td><a href="javascript:location.href='portfolio/deleteportfolio.jsy?id=${sessionScope.login.memberid}'"><i class="fa fa-trash-o w3-button"></i></a></td>
						</tr>
					</table>
				</div>
			</c:if>
		</div>
		<div id="study" class="mypage" style="display:none">
			<h2>스터디 관리</h2>
		</div>
		<div id="employment" class="mypage" style="display:none">
			<h2>채용공고 스크랩</h2>
		</div>

	</div>
</body>
</html>