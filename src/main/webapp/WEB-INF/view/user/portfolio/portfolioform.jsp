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
.w3-row-padding img {margin-bottom: 12px}
/* Set the width of the sidebar to 120px */
.w3-sidebar {width: 120px;background: #222;}
#main {margin-left: 120px}
/* Remove margins from "page content" on small screens */
@media only screen and (max-width: 600px) {#main {margin-left: 0}}
</style>
<body class="w3-black">
<!-- Icon Bar (Sidebar - hidden on small screens) -->
<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center">
  <!-- Avatar image in top left corner -->
  <a href="#about" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-user w3-xxlarge"></i>
    <p>ABOUT ME</p>
  </a>
  <a href="#portfolio" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <i class="fa fa-eye w3-xxlarge"></i>
    <p>PORTFOLIO</p>
  </a>
</nav>
<!-- Navbar on small screens (Hidden on medium and large screens) -->
<!-- 
<div class="w3-top w3-hide-large w3-hide-medium" id="myNavbar">
  <div class="w3-bar w3-black w3-opacity w3-hover-opacity-off w3-center w3-small">
    <a href="#about" class="w3-bar-item w3-button" style="width:25% !important">HOME</a>
    <a href="#history" class="w3-bar-item w3-button" style="width:25% !important">HISTORY</a>
     <a href="#skill" class="w3-bar-item w3-button" style="width:25% !important">SKILL</a> 
    <a href="#license" class="w3-bar-item w3-button" style="width:25% !important">LICENSE</a>
    <a href="#portfolio" class="w3-bar-item w3-button" style="width:25% !important">PORTFOLIO</a>
    <a href="#contact" class="w3-bar-item w3-button" style="width:25% !important">CONTACT</a>
  </div>
</div>
 -->
<!-- Page Content -->
  <!-- Header/Home -->
<div class="w3-content w3-container" id="about">
	<h3 class="w3-center"><a class="w3-xxxlarge">${sessionScope.login.slogun }</a></h3>
	<p class="w3-center"><a class="w3-xlarge">${sessionScope.login.introduce }</a></p>
	<div class="w3-content w3-container w3-padding-32">
		<table style="width:98%">
			<tr class="w3-center">
				<td rowspan="7" style="width:40%;">
					<c:if test="${empty sessionScope.login.imageUrl }">
						<img class="w3-circle w3-card" src="../../photo/defaultphoto.png" style="width:70%">
					</c:if>
					<c:if test="${!empty sessionScope.login.imageUrl }" >
						<img class="w3-circle w3-card" src="../../photo/${sessionScope.login.imageUrl }" style="width:70%">
					</c:if>
				</td>
			</tr>
			<tr>
				<td style="width:5%;"><i class="fa fa-user fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td style="width:60%;"><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.name }</a></td>
			</tr>
			<tr>
				<td><i class="fa fa-calendar fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td><a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="yyyy"/></a>년<a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="MM"/></a>월 <a class="w3-xlarge w3-hover-opacity"><fmt:formatDate value="${sessionScope.login.birth}" type="both" pattern="DD"/></a>일</td>
			</tr>
			<tr>
				<td><i class="fa fa-map-marker fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.address }</a>거주 </td>
			</tr>
			<tr>
				<td><i class="fa fa-phone fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.tel }</a></td>
			</tr>
			<tr>
				<td><i class="fa fa-envelope fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.memberid }</a></td>
			</tr>
			<tr>
				<td><i class="fa fa-link fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
				<td><a class="w3-xlarge w3-hover-opacity" href="http://${sessionScope.login.site }">${sessionScope.login.site }</a></td>
			</tr>
		</table>
	</div>
  	<hr>
  	<div class="w3-row">
		<div class="w3-container w3-half" style="padding-bottom:50px; width:50%; float:left;">
		  <h3 class="w3-center"><a class="w3-xxxlarge">EXPERIENCE</a><a class="w3-large"></a></h3>
			  <div class="w3-container" style="float:left;">
			  	<c:forEach items="${sessionScope.login.historyList }" var="history">
			  		<c:if test="${history.kindno == 0 }">
			  			<fmt:formatDate value="${history.getdate }" type="both" pattern="yyyy-MM-dd"/>
					  		<c:if test="${history.enddate != null }">
				  			 ~ <fmt:formatDate value="${history.enddate }" type="both" pattern="yyyy-MM-dd"/>
							</c:if>
							 : ${history.content }<br>
					</c:if>
			  	</c:forEach>
			  </div>
		  </div>
		  <div class="w3-container w3-half" style="padding-bottom:50px; width:50%;">
		  	<h3 class="w3-center"><a class="w3-xxxlarge">SW SKILL</a><a class="w3-large"></a></h3>
			  <div class="w3-container" style="width:30%; float:left;">
				  <c:forEach items="${sessionScope.login.historyList }" var="history">
			  		<c:if test="${history.kindno == 1 }">
						<p class="w3-large w3-center w3-padding-16"><i class="fa fa-keyboard-o fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i> SW PROGRAMMING</p>
			  			<p class="w3-wide">${history.content }</p>
				  	</c:if>
			  	  </c:forEach>
		  	</div>
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
