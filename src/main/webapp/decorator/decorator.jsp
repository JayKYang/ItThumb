<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
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
  top: 43px;
  bottom: 0;
  height: inherit;
}
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
	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/user/portfolio/myportfolio.jsy?id=${sessionScope.login.memberid}">포트폴리오</a>
	  <c:if test="${sessionScope.loginUser.userId=='admin' }">
	  	<a class="w3-bar-item w3-button w3-hover-gray" href="${path }/admin/admin.shop">관리자</a>
	  </c:if>
	  <c:if test="${!empty sessionScope.login }">
		  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/user/mypage.jsy?id=${sessionScope.login.memberid}">마이페이지</a>
	  </c:if>
	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/">스터디</a>
  	  <a class="w3-bar-item w3-button w3-hover-gray" href="${path }/">쪽지함</a>
  </div>
</div>

<!-- Sidebar -->
<%-- <nav class="w3-sidebar w3-bar-block w3-collapse w3-large w3-theme-l5 w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-right w3-xlarge w3-padding-large w3-hover-black w3-hide-large" title="Close Menu">
    <i class="fa fa-remove"></i>
  </a>
  <h4 class="w3-bar-item"><b>Menu</b></h4>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/user/mypage.shop?id=${loginUser.userId}">회원관리</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/item/list.shop">상품관리</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/hire/hirelist.jsy">채용공고</a>
  <a class="w3-bar-item w3-button w3-hover-black" href="${path }/portfolio/myportfolio.jsy">포트폴리오</a>
  <c:if test="${sessionScope.loginUser.userId=='admin' }">
  	<a class="w3-bar-item w3-button w3-hover-black" href="${path }/admin/admin.shop">관리자</a>
  </c:if>
</nav> --%>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- Main content: shift it to the right by 250 pixels when the sidebar is visible -->
<div class="w3-main">
  <div class="w3-row w3-padding-64">
	<decorator:body></decorator:body>
    
  </div>

  <footer id="myFooter">
    <div class="w3-container w3-theme-l2 w3-padding-32">
      <h4>구디아카데미 Since 2016</h4>
    </div>
  </footer>

<!-- END MAIN -->
</div>

<script>
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
