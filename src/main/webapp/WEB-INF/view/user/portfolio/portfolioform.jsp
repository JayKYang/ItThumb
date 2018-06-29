<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<title>잇썸 > 포트폴리오</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body, h1,h2,h3,h4,h5,h6 {font-family: "Montserrat", sans-serif}
#main {margin-left: 120px}
/* Remove margins from "page content" on small screens */
@media only screen and (max-width: 600px) {#main {margin-left: 0}}
</style>
<body class="w3-black">
<!-- Icon Bar (Sidebar - hidden on small screens) -->
<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center">
  <!-- Avatar image in top left corner -->
 <!--  <img src="../../photo/defaultphoto.png" style="width:50%"> -->
  <a href="" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-user w3-xxlarge"></i>
    <p>ABOUT ME</p>
  </a>
  <!-- <a href="#history" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-document w3-xxlarge"></i>
    <p>HISTORY</p>
  </a>
  <a href="#SKILL" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-document w3-xxlarge"></i>
    <p>SKILL</p>
  </a>
  <a href="#license" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-document w3-xxlarge"></i>
    <p>LICENSE</p>
  </a> -->
  <a href="#portfolio" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-eye w3-xxlarge"></i>
    <p>PORTFOLIO</p>
  </a>
  <!-- <a href="#contact" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-envelope w3-xxlarge"></i>
    <p>CONTACT</p>
  </a> -->
</nav>

<!-- Navbar on small screens (Hidden on medium and large screens) -->
<div class="w3-top w3-hide-large w3-hide-medium" id="myNavbar">
  <div class="w3-bar w3-black w3-opacity w3-hover-opacity-off w3-center w3-small">
    <a href="#about" class="w3-bar-item w3-button" style="width:25% !important">HOME</a>
    <!-- <a href="#history" class="w3-bar-item w3-button" style="width:25% !important">HISTORY</a>
     <a href="#skill" class="w3-bar-item w3-button" style="width:25% !important">SKILL</a> 
    <a href="#license" class="w3-bar-item w3-button" style="width:25% !important">LICENSE</a> -->
    <a href="#portfolio" class="w3-bar-item w3-button" style="width:25% !important">PORTFOLIO</a>
    <!-- <a href="#contact" class="w3-bar-item w3-button" style="width:25% !important">CONTACT</a> -->
  </div>
</div>

<!-- Page Content -->
  <!-- Header/Home -->
<div class="w3-content w3-container" id="about">
	<h3 class="w3-center"><a class="w3-xxxlarge">ABOUT</a><a class="w3-large"></a></h3>
	<div class="w3-content w3-container w3-padding-32">
		<div style="float:left; width:15%;">
			<c:if test="${empty sessionScope.login.image }">
				<img src="../../photo/defaultphoto.png" style="width:100%;">
			</c:if>
			<c:if test="${!empty sessionScope.login.image }">
				<img src="../../photo/${sessionScope.login.image }" style="width:100%;">
			</c:if>
		</div>
		<div class="w3-content w3-container w3-padding-30" style="padding-bottom:50px; width:60%; float:left;">
			<div style="width:40%; float:left; padding-left:80px;">
		  			<a class="w3-xlarge w3-hover-opacity">${sessionScope.login.name }</a><br>
					<a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="yyyy"/></a>년<a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="MM"/></a>월 <a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="DD"/></a>일<br>
					<a class="w3-xlarge w3-hover-opacity"><i class="fa fa-map-marker fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i>${sessionScope.login.address }</a>거주 
		  	</div>
		        
		  	<div style="width:60%;float:left;padding-left:120px;">
		  			<a class="w3-xlarge w3-hover-opacity"><i class="fa fa-phone fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i>&nbsp; ${sessionScope.login.tel }</a><br>
					<a class="w3-xlarge w3-hover-opacity"><i class="fa fa-envelope fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i> &nbsp; ${sessionScope.login.memberid }</a><br>
					<a href="${sessionScope.login.site }" class="w3-xlarge w3-hover-opacity" style="text-decoration:none;"><i class="fa fa-link"></i>&nbsp; ${sessionScope.login.site }</a><br>
		  	</div>
  		</div>
	</div>
  	<hr>
	  <h3 class="w3-center"><a class="w3-xxxlarge">SW SKILL</a><a class="w3-large"> &nbsp; 보유기술</a></h3>
	  <div class="w3-content w3-container w3-padding-30" style="padding-bottom:50px;">
		  <div class="w3-content w3-container" style="width:30%; float:left;">
			  <p class="w3-large w3-center w3-padding-16"><i class="material-icons" style="font-size:15px;">language</i> LANGUAGE</p>
			  <p class="w3-wide">C</p>
			  <div class="w3-light-grey">
			  	<div class="w3-container w3-padding-small w3-dark-grey w3-center" style="width:95%">95%</div>
			  </div>
			  <p class="w3-wide">JAVA</p>
			  <div class="w3-light-grey">
			    <div class="w3-container w3-padding-small w3-dark-grey w3-center" style="width:85%">85%</div>
			  </div>
			  <p class="w3-wide">SQL</p>
			  <div class="w3-light-grey">
			    <div class="w3-container w3-padding-small w3-dark-grey w3-center" style="width:90%">90%</div>
			  </div>
		  </div>
		  <div class="w3-content w3-container" style="width:30%; float:left;">
			  <p class="w3-large w3-center w3-padding-16"><i class="material-icons" style="font-size:15px;">inbox</i> DATABASE</p>
			  <p class="w3-wide">Oracle</p>
			  <div class="w3-light-grey">
			    <div class="w3-container w3-padding-small w3-dark-grey w3-center" style="width:90%">90%</div>
			  </div>
			  <p class="w3-wide">Mysql</p>
			  <div class="w3-light-grey">
			    <div class="w3-container w3-padding-small w3-dark-grey w3-center" style="width:85%">85%</div>
			  </div>
		  </div>
	  </div>
	  <p class="w3-center"><em>I love photography</em></p>
	  <p>We have created a fictional "personal" website/blog, and our fictional character is a hobby photographer. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
	    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa
	    qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	  <div class="w3-row">
	    <div class="w3-col m6 w3-center w3-padding-large">
	      <p><b><i class="fa fa-user w3-margin-right"></i>JayK에게 물어보세요</b></p><br>
	      <img src="${path }/images/avatar2.png" class="w3-round w3-image w3-opacity w3-hover-opacity-off" alt="Photo of Me" width="160">
	    </div>
	
	    <!-- Hide this text on small devices -->
	    <div class="w3-col m6 w3-hide-small w3-padding-large">
	      <p>Welcome to my website. I am lorem ipsum consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure
	        dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum consectetur adipiscing elit, sed do eiusmod tempor
	        incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
	    </div>
	</div>
</div>
  
  <!-- Footer -->
  <!--   
  <footer class="w3-content w3-padding-64 w3-text-grey w3-xlarge">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
    <p class="w3-medium">Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank" class="w3-hover-text-green">w3.css</a></p>
  End footer
  </footer> -->

<!-- END PAGE CONTENT -->

</body>
</html>
