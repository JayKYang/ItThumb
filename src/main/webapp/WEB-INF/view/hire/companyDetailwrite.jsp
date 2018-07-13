<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=qDOuw0wNL1zXEzspRGUC&submodules=geocoder"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	var array = []
	var month = new Date();
		month = ${birth};
	
	var now = new Date();
	now = now.getFullYear();
	
	for(var i=month; i<=now; i++){
		array.push(i);
	}
	
	var html = "";
		html += '<select id="selectCareerYear" name="selectCareerYear">'
		html += '<option>선택해주세요</option>';
		for(var i=0; i<array.length; i++){
			html+= '<option name="year" value="'+array[i]+'">'+array[i]+'<option>';
		}
		html+='</select>';

	array=[]
	for(var i=1; i<13; i++){
		array.push(i);
	};
		html += '<select id="selectCareerMonth" name="selectCareerMonth">'
		html += '<option>선택해주세요</option>';
	for(var i=0; i<array.length; i++){
		html+= '<option name="month" value="'+array[i]+'">'+array[i]+'<option>';
	}
		html+='</select>';
	
	array =[]
	for(var i=1; i<32; i++){
		array.push(i);
	};
		html += '<select id="selectCareerDay" name="selectCareerDay">'
		html += '<option>선택해주세요</option>';
		for(var i=0; i<array.length; i++){
			html+= '<option name="" value="'+array[i]+'">'+array[i]+'<option>';
		}
		html+='</select>';
		$("#career").append(html);
	});
	
	
</script>
<style type="text/css">
 #comDiv,#comrepDiv {
 	border : 1px solid #000000;
 }
 
 #comDiv{
 	width : 500px;
 	height : 150px;
 	float : left;
 }
 #comrepDiv{
 	width : 500px;
 	height : 150px;
 }
 tr {
 	border-bottom : 1px solid #000000;
 }
</style>
 </head>
<body>
<div class="w3-container" style="padding:128px 16px" id="about">
  <h2 class="w3-center"><b>${user.name}</b></h2>
  <br>
  <br>
  <p class="w3-center w3-large"></p>
  <div class="w3-row-padding w3-center" style="margin-top:64px">
    <div class="w3-quarter">
      <i class="fa fa-drivers-license-o w3-margin-bottom w3-jumbo w3-center"></i>
      <p class="w3-large">The Date of Incorporation</p>
      <p><fmt:formatDate value="${user.birth}" pattern="yyyy년 MM월 dd일" /></p>
    </div>
    <div class="w3-quarter">
        <i class="fa fa-file-text-o w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Type of Business</p>
      <p>${user.industy}</p>
    </div>
    <div class="w3-quarter">
      <i class="fa fa-location-arrow w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Business Address</p>
      <p>${user.address}</p>
    </div>
    <div class="w3-quarter">
         <i class="fa fa-desktop w3-margin-bottom w3-jumbo w3-center"></i>
      <p class="w3-large">Site</p>
      <p><a href="${user.site}">${user.site}</a></p>
    </div>
  </div>
</div>
<br>
<br>
	<form modelAttribute="" action="companyDetailwrite.jsy" method="post" enctype="multipart/form-data" name="f">
<table width="80%" border="1">
	<tr>
		<td>기업명</td>
		<td>${user.name}</td>
		<td>대표자명</td>
		<td>
			<input type="text">
		</td>
	</tr>
	<tr>
		<td>
			사업내용
		</td>
		<td colspan="3">
			${user.industy}
		</td>
	</tr>
	<tr>
		<td>설립일</td>
		<td>${user.birth}</td>
		<td>
			<td>사원수</td>
		<td><input type="text"></td>
		
	</tr>
		<tr>
		<td>연혁 및 실적</td>
		<td>
			<div id="career" name="career">
				
				
				<input type="text" id="careerYear">
				<input type="text" id="careerMonth">
				<input type="text" id="careerDay">	
			</div>
		</td>
		</tr>
	<tr>
		<td colspan="4" align="center">
			<a href="javascript:document.f.submit()">신청하기</a>
			<a href="hirelist.jsy">LIST</a>
		</td>
	</tr>
</table>
	</form>
</body>
</html>
