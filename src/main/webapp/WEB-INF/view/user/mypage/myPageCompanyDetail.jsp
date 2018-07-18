<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=qDOuw0wNL1zXEzspRGUC&submodules=geocoder"></script>
<script type="text/javascript">

</script>
<style>
	.button{
		width:60px;
		height:38px;
	}
   	.button {
	  border-radius: 4px;
	  background-color: skyblue;
	  border: none;
	  color: #FFFFFF;
	  text-align: center;
	  font-size: 18px;
	  padding: 5px;
	  transition: all 0.5s;
	  cursor: pointer;
	}
	.button:hover {
	  background-color: pink;
	}
	
	.button span {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	.button span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	}
	
	.button:hover span {
	  padding-right: 25px;
	}
	
	.button:hover span:after {
	  opacity: 1;
	  right: 0;
	}
	
	#tableOne {
		text-align : center;
		align:center;
		
		height : 350px;
		
	}
	
	#tableOne tr {
		border-bottom : 1pt solid #000000;
	}
	

	
	.tdNameCon{
		text-align : left;
	}
	
	#tableTwo{
		height : 500px;
		font-size : 13pt;
	}
	
	#tableTwo tr {
		border-bottom : 1px solid #000000;
	}
	
	.trName{
		border-bottom: 1px solid blue;
	}
	
	.tdNameCon{
		font-size : 11pt;
	}
	
	
</style>
</head>
<body>



<div class="w3-content">

    <!-- About Section -->
<div width="80%" align="center">
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
</div>

<h3>기업정보</h3>
<br>
<table width="100%" id="tableOne" style="font-size:13pt;">
	<tr class="trName">
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-top: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			기업명
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${user.name}
		</td>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-top: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			대표자명
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.ceoname}
		</td>
	</tr>
	<tr class="trName">
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			업종
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${user.industy}
		</td>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			사이트
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${user.site}
		</td>
	</tr>
	<tr>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			설립일
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			<fmt:formatDate value="${user.birth}" pattern="yyyy년 MM월 dd일" />
		</td>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF;  border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			채용 현황
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${hirelistcount} 건
		</td>
	</tr>
		<tr>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF;  border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			사원수
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.worker}
		</td>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			매출액
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.sales}
		</td>
	</tr>
		<tr>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			자본금
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.capital}
		</td>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			영업이익
		</td>
		<td class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.profit}
		</td>
	</tr>
		<tr>
		<td class="tdName" style="border-bottom: 1px solid #CFCFCF; border-right : 1px solid #CFCFCF; background-color:#E6E6FF;">
			회사 주소
		</td>
		<td colspan="3" class="tdNameCon" style="border-bottom: 1px solid #CFCFCF;">
			${user.address}
		</td>
	</tr>
</table>
<br>

<div style="max-width:1400px;">

  <div class="w3-row-padding">
  
       <h3>연혁 및 실적</h3>
        <c:forEach items="${comHistorylist}" var="comHislist">
        <div class="w3-container">
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>${comHislist.historydate}</h6>
          <h6 class="w3-opacity"><b>${comHislist.content}</b></h6>
          <hr>
        </div>
		</c:forEach>
    </div>
  
</div>

<br>
<h3>근무조건</h3>
<br>
<table width="100%" id="tableTwo" class="board_view">
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			연금보험
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.insurance}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			급여제도
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.salsystem}
		</td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			동호회/조직
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.society}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			회사분위기
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.mood}
		</td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			명절/기념일
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.anniversary }
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			의료/건강
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.health}
		</td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			출산/육아
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.care}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			사무실 환경
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.office}
		</td>
	</tr>
		<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			의복관련
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.clothes}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			식사관련
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.meal}
		</td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			교통 출퇴근
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.traffic}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			지급품
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.supplies}
		</td>
	</tr>
		<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			지원금/대출
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.supportfund}
		</td>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			회사 행사
		</td>
		<td style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.companyevent}
		</td>
	</tr>
	<tr>
		<td style="border-bottom: 1px solid #CFCFCF; background-color:#E6E6FF; text-align:center;">
			교육관련
		</td>
		<td colspan="3" style="border-bottom: 1px solid #CFCFCF;">
			${companyinfo.education}
		</td>
	</tr>
</table>
	<div class="w3-right">
		<br>
		<input type="button" onclick="location.href='../../hire/companyInfoUpdate.jsy'" class="button" style="width: 100px; height: 38px;" value="기업정보 수정">
		<input type="button" onclick="location.href='../../hire/companyHistoryreWrite.jsy'" class="button" style="width: 170px; height: 38px;" value="연혁 및 실적 다시쓰기">
		<input type="button" onclick="location.href='../../hire/hirewrite.jsy'" class="button" style="width: 100px; height: 38px;" value="채용공고 신청">
	
	</div>
</div>
</body>
</html>