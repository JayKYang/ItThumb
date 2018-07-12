<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!DOCTYPE html>
<html>
<title><decorator:title></decorator:title></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon|Nanum+Gothic+Coding|Song+Myung|Sunflower:300" rel="stylesheet">
<decorator:head></decorator:head>
<style>
body {font-family: 'Do Hyeon', sans-serif;}
h1,h2,h3,h4,h5,h6 {
    font-family: "Playfair Display";
    /* font-family: 'Song Myung', serif;  */
    /* font-family: 'Nanum Gothic Coding', monospace; 
    font-family: 'Sunflower', sans-serif; */
    letter-spacing: 5px;
}

#topbar{
	opacity:0.7;
	filter:alpha(opacity=70);
}

#topbar:hover{
	opacity:1.0;
	filter: alpha(opacity=100);
}
</style>
<script>
function message_open(url) {
	var h = screen.height*(3/4);
	var w = screen.width*(1.3/3);
	window.open(url,"message", "width="+w+", height="+h+", left=100, top=100");
}
function find_password(url) {
	var h = screen.height*(2/5);
	var w = screen.width*(1.3/3);
	window.open(url,"message", "width="+w+", height="+h+", left=100, top=100");
}
</script>
<body>
<div id="topbar" class="w3-top" style="width:100%">
  <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
  	<div class="w3-left w3-bar-item" style="width:15%;">
	    <a href="${path}/main.jsy" class="w3-bar-item "><img src="${path }/mainimg/logo.png" style="width:100%"></a>
  	</div>
    <div class="w3-left w3-bar-item">
		<a href="${path }/hire/hirelist.jsy" class="w3-bar-item  w3-hover-text-red w3-xlarge" style="padding-top:5%;text-decoration:none;">채용공고</a>
		<c:if test="${sessionScope.login.membergrade=='1'}">
	    	<a class="w3-bar-item  w3-hover-text-orange w3-xlarge" href="${path }/user/portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}" style="padding-top:5%;text-decoration:none;">내 포트폴리오</a>
	  	</c:if>
	  	<c:if test="${sessionScope.login.membergrade=='2' or sessionScope.login.membergrade=='0'}">
	    	<a href="${path }/user/portfolio/portfoliolist.jsy" class="w3-bar-item  w3-hover-text-orange w3-xlarge" style="padding-top:5%;text-decoration:none;">포트폴리오 보기</a>
	 	</c:if>
    	<c:if test="${empty sessionScope.login }">
	    	<a class="w3-bar-item w3-hover-text-orange w3-xlarge" href="${path }/user/portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}" style="padding-top:5%; text-decoration:none;">내 포트폴리오</a>
	    </c:if>
	 	<a class="w3-bar-item w3-hover-text-pink w3-xlarge" href="${path}/study/studySearchList.jsy" style="text-decoration:none;padding-top:5%;">스터디 찾기</a>
	    <a class="w3-bar-item w3-hover-text-yellow w3-xlarge" href="${path}/community/comList.jsy?communitykind=1"  style="padding-top:5%;text-decoration:none; w3-xlarge">커뮤니티</a>
    </div>
    <div class="w3-right w3-bar-item">
    	<c:if test="${empty sessionScope.login }">
			<a href="${path }/user/login.jsy" class="w3-bar-item w3-hover-text-blue w3-xlarge" style="padding-top:5%;text-decoration:none;">로그인</a>
			<a href="javascript:find_password('${path}/user/findpassword.jsy')" class="w3-bar-item  w3-hover-text-green w3-xlarge" style="padding-top:5%;text-decoration:none;">비밀번호 찾기</a>
		    <a href="${path}/user/selectJoin.jsy" class="w3-bar-item  w3-hover-text-purple w3-xlarge" style="padding-top:5%;text-decoration:none;">회원가입</a>
	    </c:if>
	    <c:if test="${!empty sessionScope.login }">
			<a class="w3-bar-item w3-hover-text-blue w3-xlarge" href="${path }/user/mypage/myInfo.jsy?id=${sessionScope.login.memberid}" style="padding-top:5%;text-decoration:none;">마이페이지</a>
	    	<a class="w3-bar-item  w3-hover-text-green w3-xlarge" href="javascript:message_open('${path}/message/messageList.jsy?sort=1')" style="padding-top:5%;text-decoration:none;">쪽지함</a>
	    	<a class="w3-bar-item  w3-hover-text-purple w3-xlarge" href="${path }/user/logout.jsy" style="padding-top:5%;text-decoration:none;">로그아웃 </a>
	    </c:if>
    </div>
  </div>
</div>

<div style="margin-top:200px;"></div>

<div class="w3-content">
	<div>
		<p>
			<span class="w3-content w3-text-indigo w3-xxlarge">마이페이지</span>
		</p>
	</div>
	<div class="w3-bar w3-left-align w3-large w3-theme-l1">
		<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
			<a href="myInfo.jsy?id=${sessionScope.login.memberid }" class="w3-button"><p>내 정보</p></a>
		</div>
		<c:if test="${sessionScope.login.membergrade == 1}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="mypageportfolio.jsy" class="w3-button"><p>포트폴리오 관리</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 2}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="portfolioscraplist.jsy" class="w3-button"><p>관심 포트폴리오</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 0}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="manageuser.jsy" class="w3-button"><p>회원 관리</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 1}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="managestudy.jsy?smkind=1" class="w3-button"><p>스터디 관리</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 0}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="confirmHire.jsy" class="w3-button"><p>채용공고 승인</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 1}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="../../hire/hireScrapList.jsy" class="w3-button"><p>채용공고 스크랩</p></a>
			</div>
		</c:if>
		<c:if test="${sessionScope.login.membergrade == 2}">
			<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				<a href="../../hire/myhirelist.jsy" class="w3-button"><p>내가 쓴 채용공고</p></a>
			</div>
		</c:if>
	</div>
	<hr>
</div>	

<!-- Page content -->
<div class="w3-container" style="width:100%;">
	<decorator:body></decorator:body>
</div>

<!-- Footer -->
<footer class="w3-center w3-light-grey w3-padding-32" style="margin-top:5%;">
	<div class="w3-row">
		<div class="w3-half"><img src="${path }/mainimg/logo.png" style="width:50%"></div>
		<div class="w3-half w3-left-align">
			<h2>Company Info</h2>
			<p>COMPANY : ITThumb (공동)차용우,양진규,박승현 사업자등록번호 : 5673-34634-2345<br>
			ADDRESS : (우)08505 서울시 금천구 가산디지털2로 115, 509호, 811호(가산동,대륭테크노타운 3차)<br>
			Copyright@ 2018 ITThumb Inc. All rights reserved.</p>
			<h2>Customer Center</h2>
			<p>TEL : 010 - 1234 - 1234<br>
			Email : ITThumbmail@gmail.com<br>
			OPEN : 09:30 ~ 18:30</p>
		</div>
	</div>
</footer>
</body>
</html>







<%-- 
<!DOCTYPE html>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<title><decorator:title></decorator:title></title>
<decorator:head></decorator:head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-black.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
html,body,h1,h2,h3,h4,h5,h6 {font-family: "Roboto", sans-serif;}
.w3-sidebar {
  z-index: 3;
  width: 250px;
  top: 140px;
  bottom: 0;
  height: inherit;
}
#main {margin-left: 14%;}
</style>
<body>
<!-- Navbar -->
<div class="w3-top">
  <div class="w3-bar w3-top w3-left-align w3-large w3-theme-l1">
    <a class="w3-bar-item w3-button w3-right w3-hide-large w3-hover-white w3-large" href="javascript:void(0)" onclick="w3_open()"><i class="fa fa-bars"></i></a>
    <a href="${path }/main.jsy" class="w3-bar-item w3-button ">구디아카데미</a>
    <c:if test="${empty sessionScope.login }">
    	<a href="${path }/user/login.jsy" class="w3-bar-item w3-button w3-hide-small w3-hover-gray">로그인 </a>
    </c:if>
    <c:if test="${!empty sessionScope.login }">
    	<a href="${path }/user/logout.jsy" class="w3-bar-item w3-button w3-hide-small w3-hover-gray">${sessionScope.login.memberid }님! 로그아웃 </a>
    </c:if>
	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/hire/hirelist.jsy">채용공고</a>

	  <c:if test="${sessionScope.login.membergrade=='0' }">
	  	<a class="w3-bar-item w3-button w3-hover-gray" href="${path }/admin/admin.jsy">관리자</a>
	  </c:if>
	  <c:if test="${sessionScope.login.membergrade=='1'}">
		  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/user/portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}">포트폴리오</a>
	  </c:if>
	  <c:if test="${sessionScope.login.membergrade=='2' or sessionScope.login.membergrade=='0'}">
		  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/user/portfolio/portfoliolist.jsy">포트폴리오</a>
	  </c:if>

	  <c:if test="${!empty sessionScope.login }">
		  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/user/mypage/myInfo.jsy?id=${sessionScope.login.memberid}">마이페이지</a>
	  </c:if>
	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path}/study/studySearchList.jsy">스터디 검색</a>
	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path}/community/comList.jsy?communitykind=1">커뮤니티</a>
  	  <a class="w3-bar-item w3-button w3-hover-gray" href="javascript:message_open('${path}/message/messageList.jsy?sort=1')">쪽지함</a>
	  <c:if test="${empty sessionScope.login }">
	  	  <a class="w3-bar-item w3-button w3-hover-gray" href="javascript:message_open('${path}/user/findpassword.jsy')">비밀번호찾기</a>
	  </c:if>
  </div>
</div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main">
  <div class="w3-row w3-padding-64">
	 <div class="w3-bar w3-left-align w3-large w3-theme-l1">
	 	<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
			  <a href="myInfo.jsy?id=${sessionScope.login.memberid }" class="w3-button"><p>내 정보</p></a>
			</div>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
					  <a href="mypageportfolio.jsy" class="w3-button"><p>포트폴리오 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 2}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
					  <a href="portfolioscraplist.jsy" class="w3-button"><p>관심 포트폴리오</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 0}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				  <a href="manageuser.jsy" class="w3-button"><p>회원 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				  <a href="managestudy.jsy?smkind=1" class="w3-button"><p>스터디 관리</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 0}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				  <a href="confirmHire.jsy" class="w3-button"><p>채용공고 승인</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 1}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				  <a href="../../hire/hireScrapList.jsy" class="w3-button"><p>채용공고 스크랩</p></a>
				</div>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 2}">
				<div class="w3-container w3-cell w3-cell-middle w3-button" style="width:200px; float:left;">
				  <a href="../../hire/myhirelist.jsy" class="w3-button"><p>내가 쓴 채용공고</p></a>
				</div>
			</c:if>
	 </div>
  </div>
  <div>
	<decorator:body></decorator:body>
  </div>

  <footer id="myFooter">
    <div class="w3-container w3-theme-l2 w3-padding-32">
      <h4>IT Thumb</h4>
    </div>
  </footer>

<!-- END MAIN -->
</div>

<script>

// 쪽지 관련 스크립트 지우지 말것
function message_open(url) {
	var h = screen.height*(3/4);
	var w = screen.width*(1.3/3);
	window.open(url,"message", "width="+w+", height="+h+", left=100, top=100");
}
function find_password(url) {
	var h = screen.height*(1/4);
	var w = screen.width*(1.3/3);
	window.open(url,"message", "width="+w+", height="+h+", left=100, top=100");
}
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");

// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
    if (mySidebar.style.display === 'block') {
        mySidebar.style.display = 'none';
        overlayBg.style.display = "none";
    } else {
        mySidebar.style.display = 'block';
        overlayBg.style.display = "block";
    }
}

// Close the sidebar with the close button
function w3_close() {
    mySidebar.style.display = "none";
    overlayBg.style.display = "none";
}
</script>

</body>
</html>
 --%>