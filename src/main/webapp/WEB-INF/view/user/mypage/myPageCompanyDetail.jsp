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
</head>
<body>
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
<br>
<br>

<h4>기업정보</h4>
<c:if test="${sessionScope.login.memberid == companyinfo.memberid}">
<a href="companyInfoUpdate.jsy?hireno=${hireno}">수정</a>
</c:if>
<table border="1" width="80%">
	<tr>
		<td>
			기업명
		</td>
		<td>
			${user.name}
		</td>
		<td>
			대표자명
		</td>
		<td>
			${companyinfo.ceoname}
		</td>
	</tr>
		<tr>
		<td>
			업종
		</td>
		<td colspan="3">
			${user.industy}
		</td>
	</tr>
	<tr>
		<td>
			설립일
		</td>
		<td>
			<fmt:formatDate value="${user.birth}" pattern="yyyy년 MM월 dd일" />
		</td>
		<td>
			채용 현황
		</td>
		<td>
			${hirelistcount} 건
		</td>
	</tr>
		<tr>
		<td>
			사원수
		</td>
		<td>
			${companyinfo.worker}
		</td>
		<td>
			매출액
		</td>
		<td>
			${companyinfo.sales}
		</td>
	</tr>
		<tr>
		<td>
			자본금
		</td>
		<td>
			${companyinfo.capital}
		</td>
		<td>
			영업이익
		</td>
		<td>
			${companyinfo.profit}
		</td>
	</tr>
		<tr>
		<td>
			회사 주소
		</td>
		<td colspan="3">
			${user.address}
		</td>
	</tr>
		<tr>
		<td>
			사이트
		</td>
		<td colspan="3">
			${user.site}
		</td>
	</tr>
	
</table>
<div class="w3-content w3-margin-top" style="max-width:1400px;">

  <div class="w3-row-padding">
  
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal"></i>연혁 및 실적</h2>
        <c:forEach items="${comHistorylist}" var="comHislist">
        <div class="w3-container">
          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>${comHislist.historydate}</h6>
          <h5 class="w3-opacity"><b>${comHislist.content}</b></h5>
          <hr>
        </div>
		</c:forEach>
    </div>
  </div>
</div>
</div>
<h4>근무조건</h4>
<table border="1" width="80%">
	<tr>
		<td>
			연금보험
		</td>
		<td>
			${companyinfo.insurance}
		</td>
		<td>
			급여제도
		</td>
		<td>
			${companyinfo.salsystem}
		</td>
	</tr>
	<tr>
		<td>
			동호회/조직
		</td>
		<td>
			${companyinfo.society}
		</td>
		<td>
			회사분위기
		</td>
		<td>
			${companyinfo.mood}
		</td>
	</tr>
	<tr>
		<td>
			명절/기념일
		</td>
		<td>
			${companyinfo.anniversary }
		</td>
		<td>
			의료/건강
		</td>
		<td>
			${companyinfo.health}
		</td>
	</tr>
	<tr>
		<td>
			출산/육아
		</td>
		<td>
			${companyinfo.care}
		</td>
		<td>
			사무실 환경
		</td>
		<td>
			${companyinfo.office}
		</td>
	</tr>
		<tr>
		<td>
			의복관련
		</td>
		<td>
			${companyinfo.clothes}
		</td>
		<td>
			식사관련
		</td>
		<td>
			${companyinfo.meal}
		</td>
	</tr>
	<tr>
		<td>
			교통 출퇴근
		</td>
		<td>
			${companyinfo.traffic}
		</td>
		<td>
			지급품
		</td>
		<td>
			${companyinfo.supplies}
		</td>
	</tr>
		<tr>
		<td>
			지원금/대출
		</td>
		<td>
			${companyinfo.supportfund}
		</td>
		<td>
			회사 행사
		</td>
		<td>
			${companyinfo.companyevent}
		</td>
	</tr>
	<tr>
		<td>
			교육관련
		</td>
		<td colspan="3">
			${companyinfo.education}
		</td>
	</tr>
	<tr>
		<td colspan="4" align="right">
		<a href="../../hire/companyInfoUpdate.jsy">기업정보 수정</a>
		<a href="../../hire/companyHistoryreWrite.jsy">연혁 및 실적 다시쓰기</a>
		<a href="../../hire/hirewrite.jsy">채용공고 신청</a>
		</td>
	</tr>
</table>
<div id="map" style="width:100%;height:400px;"></div>
</body>
</html>