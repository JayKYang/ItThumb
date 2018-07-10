<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<script>
	$(document).ready(function(){
		url = document.URL.split("#");
		if(url[1]!=null){
			openMypage(url[1]);
		}
	});

	function openMypage(mypageName) {
	    var i;
	    var x = document.getElementsByClassName("mypage");
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none"; 
	    }
	    document.getElementById(mypageName).style.display = "block"; 
	}
	
	function managemem(membergrade,pageNum){
		$.ajax({
	        url : "mypage_info.jsy",
	        type : "POST",
	        data : {"membergrade":membergrade,"id":'${sessionScope.login.memberid}',"pageNum":pageNum},
	        success : function (html) {
	        	console.log(html);
	        	$("#managememberdiv").html(html);
	        },error:function(request,status,error){
	        }
	    });
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
			  <a href="#info" class="w3-button"><p>내 정보</p></a>
			</div>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('portfolio')" style="width:200px; float:left;">
					  <a href="#portfolio" class="w3-button"><p>포트폴리오 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 2}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('portfolio')" style="width:200px; float:left;">
					  <a href="#portfolio" class="w3-button"><p>관심 포트폴리오</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 0}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('managemember')" style="width:200px; float:left;">
				  <a href="#managemember" class="w3-button"><p>회원 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('study')" style="width:200px; float:left;">
				  <a href="#study" class="w3-button"><p>스터디 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 0}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employmentConfirm')" style="width:200px; float:left;">
				  <a href="#employmentConfirm" class="w3-button"><p>채용공고 승인</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employmentScrap')" style="width:200px; float:left;">
				  <a href="#employmentScrap" class="w3-button"><p>채용공고 스크랩</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 2}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" onclick="openMypage('employment')" style="width:200px; float:left;">
				  <a href="#employment" class="w3-button"><p>내가 쓴 채용공고</p></a>
				</div>
			</c:if>
		</div>
		<hr>
		<div id="info" class="mypage" style="display:block;">
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
									<img class="w3-button" id="profilephoto" src="../../photo/defaultphoto.png"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
								</c:if>
								<c:if test="${!empty sessionScope.login.imageUrl }" >
									<img class="w3-button" id="profilephoto" src="../../photo/${sessionScope.login.imageUrl }"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
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
					<tr>
						<td class="w3-center"><input class="w3-button" type="button" value="회원탈퇴" onclick="location.href='delete.jsy?id=${login.memberid}'"></td>
						<td class="w3-center"><input class="w3-button" type="submit" value="수정"></td>
					</tr>
				</table>
			</form:form>
		</div>
		<div id="managemember" class="mypage" style="display:none">
			<h2>회원관리</h2>
			<table>
				<tr>
					<td>
						<%-- <a href="mypage.jsy?id=${sessionScope.login.memberid}">전체</a>
						<a href="mypage.jsy?id=${sessionScope.login.memberid}&membergrade=1">일반 사용자</a>&nbsp;&nbsp;
						<a href="mypage.jsy?id=${sessionScope.login.memberid}&membergrade=2">기업 사용자</a> --%>
						<a href="javascript:managemem(0,1)">전체</a>&nbsp;&nbsp;
						<a href="javascript:managemem(1,1)">일반 사용자</a>&nbsp;&nbsp;
						<a href="javascript:managemem(2,1)">기업 사용자</a>
					</td>
				</tr>
			</table>
			<div id="managememberdiv">
			<input type="hidden" name="pageNum" value="${pageNum}"> 
			<input type="hidden" name="membergrade" value="${membergrade}"> 
				<table>
					<tr>
						<th>번호</th><th>아이디</th><th>이름</th><th>강제탈퇴</th>						
					</tr>
					<c:forEach items="${userlist }" var="user" varStatus="status">
						<tr><td>${status.count }</td><td>${user.memberid }</td><td>${user.name }</td><td><input type="button" onclick="location.href='delete.jsy?id=${user.memberid}'" value="강제탈퇴"/></td></tr>
					</c:forEach>
				</table>
				<div class="w3-bar w3-center">
					<c:if test="${pageNum > 1 }">
						<a href="javascript:managemem(${membergrade},${pageNum - 1})">[이전]</a>
					</c:if>
					&nbsp;
					<c:if test="${pageNum <=1 }">
							[이전]
					</c:if>
					&nbsp;
					<c:forEach var="a" begin="${startpage }" end="${endpage }">
						<c:if test="${a == pageNum }">[${a}]</c:if>
						<c:if test="${a != pageNum }">
							<a href="javascript:managemem(${membergrade},${a})">[${a}]</a>
						</c:if>
					</c:forEach>
					<c:if test="${pageNum < maxpage}">
						<a href="javascript:managemem(${membergrade},${pageNum + 1 })">[다음]</a>
					</c:if>
					&nbsp;
					<c:if test="${pageNum >= maxpage }">[다음]</c:if>
					&nbsp;
				</div>
			</div>
			<br>
		</div>
		<div id="portfolio" class="mypage" style="display:none">
			<c:if test="${sessionScope.login.createpf == 0 }">
				등록된 포트폴리오가 없습니다.<br>
				<button onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'">포트폴리오 작성</button>
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
							<td><i class="fa fa-edit w3-button" onclick="javascript:location.href='../portfolio/portfolioform.jsy?id=${sessionScope.login.memberid}'"></i></td>
							<td><a href="javascript:location.href='../portfolio/deleteportfolio.jsy?id=${sessionScope.login.memberid}'"><i class="fa fa-trash-o w3-button"></i></a></td>
						</tr>
					</table>
				</div>
			</c:if>
		</div>
		<div id="study" class="mypage" style="display:none">
			<h2>스터디 관리</h2>
		</div>
		<div id="employmentConfirm" class="mypage" style="display:none">
			<h2>채용공고 승인</h2>
		</div>
		<div id="employmentScrap" class="mypage" style="display:none">
			<h2>채용공고 스크랩</h2>
			<div id="employmentScrapdiv">
				
			</div>
		</div>
	</div>
</body>
</html>