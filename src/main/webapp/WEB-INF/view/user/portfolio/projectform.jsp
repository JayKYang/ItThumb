<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<title>잇썸 > 포트폴리오</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<script>
	$(function() {
	    $("#imagefile").on('change', function(){
	        readURL(this);
	    });
	});
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function (e) {
	            $('#profilephoto').attr('src', e.target.result);
	            $('#profilephoto').attr('style', "width:70%; display:block;");
	            $('#profilephoto2').attr('style', "display:none;");
	        }
	
	      reader.readAsDataURL(input.files[0]);
	    }
	}
	function openPortfolio(mypageName) {
	    var i;
	    var x = document.getElementsByClassName("portfoliopage");
	    for (i = 0; i < x.length; i++) {
	        x[i].style.display = "none"; 
	    }
	    document.getElementById(mypageName).style.display = "block"; 
	}
	$(document).ready(function(){
		url = document.URL.split("#");
		if(url[1]!=null){
			openPortfolio(url[1]);
		}else{
			openPortfolio("project");
		}
	});
	

	//페이지 이탈 시 이벤트발생 
	/* jQuery(document).ready(function($) {
	    var checkload = true;
	    $("#submit-btn").click(function () {
	        checkload = false;
	    });
	    $(window).on("beforeunload", function () {
	        if (checkload == true) return "";
	    });
	}); */
	
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
	 function fileUpload(){
 	   eventOccur(document.getElementById('imagefile'),'click');
 	   /* alert(orgFile.value); 이벤트 처리가 끝나지 않은 타이밍이라 값 확인 안됨! 시간차 문제 */
 	  }
</script>
</head>
<style>
body, h1, h2, h3, h4, h5, h6 {
	font-family: "Montserrat", sans-serif
}

.w3-row-padding img {
	margin-bottom: 12px
}
/* Set the width of the sidebar to 120px */
.w3-sidebar {
	width: 120px;
	background: #222;
}

#main {
	margin-left: 120px
}
/* Remove margins from "page content" on small screens */
@media only screen and (max-width: 600px) {
	#main {
		margin-left: 0
	}
}
</style>
<body class="w3-black">
	<!-- Icon Bar (Sidebar - hidden on small screens) -->
	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center w3-black">
		<!-- Avatar image in top left corner -->
		<a class="w3-bar-item w3-button w3-padding-large w3-hover-gray"  href="javascript:location.href='portfolioform.jsy?id=${sessionScope.login.memberid}'">
		    <i class="fa fa-user w3-xxlarge"></i>
		    <p>ABOUT ME</p>
	    </a>
		<a href="javascript:location.href='portfolioform.jsy?id=${sessionScope.login.memberid }#project'" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"  onclick="openPortfolio('project')">
			<i class="fa fa-eye w3-xxlarge"></i>
			<p>MY WORK</p>
		</a>
	</nav>
	<!-- Page Content -->
	<!-- Header/Home -->

	<div class="portfoliopage w3-content w3-container w3-animate-left" id="project">
		<div class="w3-content w3-container w3-padding-32">
		<form:form modelAttribute="project" method="post" action="projectform.jsy" name="f" enctype="multipart/form-data">
		<input type="hidden" name="projectno" value="${project.projectno }">
		<input type="hidden" name="imagefileUrl" value="${project.imagefileUrl }">
		<input type="hidden" name="memberid" value="${sessionScope.login.memberid }">
			<table style="width:100%;">
				<tr>
					<td style="width:20%;">프로젝트 명</td><td style="width:58%;"><form:input path="subject" class="w3-input" placeholder="프로젝트명"/></td>
				</tr>
				<tr>
					<td>프로젝트 기간</td><td><form:input path="term" class="w3-input" type="text" placeholder="ex) 2010-02-20 ~ 2010-05-22"/></td>
				</tr>
				<tr>
					<td>사용 기술</td><td><form:input path="skills" class="w3-input" type="text" placeholder="ex) C,JAVA,SPRING ..."/></td>
				</tr>
				<tr>
					<td>맡은 역할</td><td><form:input path="role" class="w3-input" type="text" placeholder="ex) 프로젝트 기획, DB설계 ...."/></td>
				</tr>
				<tr>
					<td>프로젝트 링크</td><td><form:input path="link" class="w3-input" type="text" placeholder="http://"/></td>
				</tr>
				<tr>
					<td>대표 사진</td>
					<td colspan="2" align="center">
						<c:if test="${empty project.imagefileUrl }">
							<img class="w3-button" id="profilephoto" style="width:70%; display:none;" onclick="fileUpload()">
							<a id="profilephoto2" class="w3-small w3-button" onclick="fileUpload()">이곳을 눌러 이미지를<br> 추가하세요.</a> 
						</c:if>
						<c:if test="${!empty project.imagefileUrl }" >
							<img class="w3-button" id="profilephoto" src="../../projectimg/${project.imagefileUrl }" style="width:70%;" onclick="fileUpload()">
						</c:if>
						<input type="file" name="imagefile" id="imagefile" style="display:none"/>
						
					</td>
				</tr>
				<tr><td colspan="2"><hr></td></tr>
				<tr>
					<td colspan="2">내용</td>
				</tr>
				<tr>
					<td colspan="2"><form:textarea path="content" class="" placeholder="프로젝트 내용" cols="120" rows="50"/></td>
				</tr>
			</table>
			</form:form>
			<table style="width: 98%">
				<tr>
					<td colspan="3" align="right"><a class="w3-button w3-xlarge" style="border:1px solid black; border-radius:5px;" onclick="javascript:document.f.submit();"><i class="fa fa-floppy-o"></i> 저장하기</a></td>
				</tr>
			</table>
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