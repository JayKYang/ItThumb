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
<title>잇썸 > 기업 정보</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=qDOuw0wNL1zXEzspRGUC&submodules=geocoder"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
function detailhirelist(pageNum){
	var i = $("#hireno").val();
	location.href = "companyDetail.jsy?hireno=" + i+"&pageNum="+pageNum;
	return true;
}
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
 

body {font-family: 'Do Hyeon', sans-serif;}
h1,h2,h3,h4,h5,h6 {
    font-family: "Playfair Display";
    /* font-family: 'Song Myung', serif; */
    /* font-family: 'Nanum Gothic Coding', monospace; 
    font-family: 'Sunflower', sans-serif; */
    letter-spacing: 5px;
} 

.trName{
	text-align:center;
}
 
 .tdCon{
 	text-align:left;
 	 font-size : 13px;
 }
 
 #label1{
 	text-align:right;
 	align : right;
 	font-size :7pt;
 }
 
</style>
</head>
<body>
    <!-- About Section -->
<div style="width:100%;">
<div class="w3-indigo" style="padding:100px;opacity:0.7;">
  <h2 class="w3-center"><b>${user.name}</b></h2>
</div>
  <div class="w3-center">
    <div class="w3-quarter w3-border" style="padding-top:50px;padding-bottom:50px;">
      <i class="fa fa-drivers-license-o w3-margin-bottom w3-jumbo w3-center"></i>
      <p class="w3-large">The Date of Incorporation</p>
      <p><fmt:formatDate value="${user.birth}" pattern="yyyy년 MM월 dd일" /></p>
    </div>
    <div class="w3-quarter w3-border" style="padding-top:50px;padding-bottom:50px;">
        <i class="fa fa-file-text-o w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Type of Business</p>
      <p>${user.industy}</p>
    </div>
    <div class="w3-quarter w3-border" style="padding-top:50px;padding-bottom:50px;">
      <i class="fa fa-location-arrow w3-margin-bottom w3-jumbo"></i>
      <p class="w3-large">Business Address</p>

      <p>${user.address}</p>
    </div>
    <div class="w3-quarter w3-border" style="padding-top:50px;padding-bottom:50px;">
         <i class="fa fa-desktop w3-margin-bottom w3-jumbo w3-center"></i>
      <p class="w3-large">Site</p>
      <p><a href="${user.site}">${user.site}</a></p>
    </div>
  </div>
</div>
<div class="w3-container" style="width:100%;">
	<br>
	<p><span class="w3-large w3-text-indigo"><b>지난 채용 공고</b></span></p>
	<br>
	<div style="width:100%;height:360px;">
		<c:forEach items="${hirelist}" var="hire">
			<c:if test="${hirelistcount>0}">
				<c:if test="${hire.hide==1}">
			      <div class="w3-third w3-margin-bottom" id="listDiv" style="width:33%;">
			        <ul class="w3-ul w3-border w3-white w3-center w3-opacity w3-hover-opacity-off">
			          <li class="w3-indigo w3-xlarge w3-padding-32" style="opacity:0.6;height:120px;"><a href="hiredetail.jsy?hireno=${hire.hireno}">${hire.subject}</a></li>
			          <li class="w3-padding-16">${hire.qualification}</li>
			          <li class="w3-padding-16">${hire.hirestatus}</li>
			          <li class="w3-padding-16">${hire.region} ${hire.regiongu}</li>
			          <li class="w3-padding-16">${hire.workday}</li>
			        </ul>
			      </div>
				</c:if>
			</c:if>
			<c:if test="${hirelistcount==0}">
				<h2>해당 목록이 비어있습니다.</h2>
			</c:if>
		</c:forEach>
	</div>
	<div class="w3-center" style="width:100%;">
		<input id="hireno" type="hidden" name="hireno" value="${param.hireno}">
		<c:if test="${pageNum >1}">
			<a href="javascript:detailhirelist(${pageNum -1})">[이전]</a>
		</c:if> &nbsp;
		<c:if test="${pageNum <= 1}">[이전]</c:if>&nbsp;
		<c:forEach var="a" begin="${startpage}" end = "${endpage}">
			<c:if test="${a == pageNum}">[${a}]</c:if>
			<c:if test="${a != pageNum}">
			<a href="javascript:detailhirelist(${a})">[${a}]</a>
			</c:if>
		</c:forEach>
		<c:if test="${pageNum < maxpage}">
			<a href="javascript:detailhirelist(${pageNum + 1})">[다음]</a>
		</c:if> &nbsp;
		<c:if test="${pageNum >= maxpage}">[다음]
		</c:if> &nbsp;
	</div>
	<p><span class="w3-large w3-text-indigo"><b>기업 정보</b></span></p>
	
	<br>
	<div class="content">
	<table style="width:100%; align:center; height:450px;">
		<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				기업명
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${user.name}
			</td>
			<td style="background-color:#e6e6ff; font-weight:bold;">
				대표자명
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${companyinfo.ceoname}
			</td>
		</tr>
		<tr class="trName" style="border-bottom:1px solid #CFCFCF;">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				업종
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${user.industy}
			</td>
			<td style="background-color:#e6e6ff; font-weight:bold;">
				영업이익
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${companyinfo.profit} (전년대비 기준)
			</td>
		</tr>
		<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				설립일
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				<fmt:formatDate value="${user.birth}" pattern="yyyy년 MM월 dd일" />
			</td>
			<td style="background-color:#e6e6ff; font-weight:bold;">
				채용 현황
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${hirelistcount} 건
			</td>
		</tr>
			<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				사원수
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${companyinfo.worker} 명
			</td>
			<td style="background-color:#e6e6ff; font-weight:bold;">
				매출액
			</td>
			<td class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${companyinfo.sales} (전년대비 기준)
			</td>
		</tr>
			<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				자본금
			</td>
			<td colspan="3" class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${companyinfo.capital} (전년대비 기준)
			</td>
		</tr>
			<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				회사 주소
			</td>
			<td colspan="3" class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${user.address}
			</td>
		</tr>
			<tr class="trName">
			<td style="background-color:#e6e6ff; font-weight:bold;">
				사이트
			</td>
			<td colspan="3" class="tdCon" style="border-bottom:1px solid #CFCFCF;">
				${user.site}
			</td>
		</tr>
	</table>
	<label id ="label1">매출액,자본금,영업이익 : 백만단위 기준</label>
	</div>
	<div class="w3-content w3-margin-top" style="max-width:1400px;">
	  <div class="w3-row-padding">
	    
	      
	      <p><span class="w3-large w3-text-indigo"><b>연혁 및 실적</b></span></p>
	   
	        <c:forEach items="${comHistorylist}" var="comHislist">
	        <div class="w3-container">
	          <h6 class="w3-text-teal"><i class="fa fa-calendar fa-fw w3-margin-right"></i>${comHislist.historydate}</h6>
	          <h6 class="w3-opacity"><b>${comHislist.content}</b></h6>
	          <hr>
	        </div>
			</c:forEach>
		    
		  
		</div>
	</div>
	<p><span class="w3-large w3-text-indigo"><b>근무 조건</b></span></p>
	<br>
	<div>
	<table style="width:100%; align:center; height:500px;">
	<tr class="trName">
		<td style="width:10%;background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			연금보험
		</td>
		<td style="width:35%; border-bottom:1px solid #CFCFCF;" class="tdCon">
			${companyinfo.insurance}
		</td>
		<td style="width:10%; background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			급여제도
		</td>
		<td style="width:35%; border-bottom:1px solid #CFCFCF;" class="tdCon">
			${companyinfo.salsystem}
		</td>
	</tr>
	<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			동호회/조직
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.society}
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			회사분위기
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.mood}
		</td>
	</tr>
	<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			명절/기념일
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.anniversary }
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			의료/건강
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.health}
		</td>
	</tr>
	<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			출산/육아
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.care}
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			사무실 환경
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.office}
		</td>
	</tr>
		<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			의복관련
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.clothes}
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			식사관련
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.meal}
		</td>
	</tr>
	<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			교통 출퇴근
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.traffic}
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			지급품
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.supplies}
		</td>
	</tr>
		<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			지원금/대출
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.supportfund}
		</td>
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			회사 행사
		</td>
		<td class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.companyevent}
		</td>
	</tr>
	<tr class="trName">
		<td style="background-color:#e6e6ff; font-weight:bold; font-size : 10pt;">
			교육관련
		</td>
		<td colspan="3" class="tdCon" style=" border-bottom:1px solid #CFCFCF;">
			${companyinfo.education}
		</td>
	</tr>
</table>
</div>
<br>
<p><span class="w3-large w3-text-indigo"><b>회사 위치</b></span></p>
<br>
<div id="map" style="width:100%;height:400px;"></div>
<br>
<br>
</div>
<script type="text/javascript">
	var map = new naver.maps.Map('map');
    var myaddress = '${address}';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
    	
      
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
          // 마커 클릭 이벤트 처리
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4> [네이버 개발자센터]</h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
          });
      });
</script>
</body>
</html>

<%-- <p><span class="w3-large">지난 채용 공고</span></p>
	<table>
			<c:if test="${hirelistcount>0}">
		<c:if test="${hire.hide==1}">
	    <div class="w3-row-padding" style="margin:0 -16px">
		    <c:forEach items="${hirelist}" var="hire">
		      <div class="w3-third w3-margin-bottom" id="listDiv" style="height:300px;">
		        <ul class="w3-ul w3-border w3-white w3-center w3-opacity w3-hover-opacity-off">
		          <li class="w3-dark-gray w3-xlarge w3-padding-32"><a href="hiredetail.jsy?hireno=${hire.hireno}">${hire.subject}</a></li>
		          <li class="w3-padding-16">${hire.qualification}</li>
		          <li class="w3-padding-16">${hire.hirestatus}</li>
		          <li class="w3-padding-16">${hire.region} ${hire.regiongu}</li>
		          <li class="w3-padding-16">${hire.workday}</li>
		        </ul>
		      </div>
			</c:forEach>
	     </div> 
	     <div>
		     <input type="hidden" name="hireno" value="${param.hireno}">
		    <table>
		     	<tr align="center" height="26">
					<td colspan="8">
						<c:if test="${pageNum >1}">
							<a href="javascript:detailhirelist(${pageNum -1})">PREV</a>
						</c:if> &nbsp;
						<c:if test="${pageNum <= 1}">PREV</c:if>&nbsp;
						<c:forEach var="a" begin="${startpage}" end = "${endpage}">
							<c:if test="${a == pageNum}">${a}</c:if>
							<c:if test="${a != pageNum}">
							<a href="javascript:detailhirelist(${a})">${a}</a>
							</c:if>
						</c:forEach>
						<c:if test="${pageNum < maxpage}">
							<a href="javascript:detailhirelist(${pageNum + 1})">NEXT</a>
						</c:if> &nbsp;
						<c:if test="${pageNum >= maxpage}">NEXT
						</c:if> &nbsp;
					</td>
				</tr>
		   </table>
	     </div>
	</c:if>
	</c:if>
		<c:if test="${hirelistcount==0}">
					<tr>
						<td>
							<h2>해당 목록이 비어있습니다.</h2>
						</td>
					</tr>
				</c:if>
	</table>
</div>
<h4>기업정보</h4>
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
        <a href="companyHistoryUpdate.jsy">수정</a>
        <a>삭제</a>
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
</table>
<div id="map" style="width:100%;height:400px;"></div>
<script type="text/javascript">

		var map = new naver.maps.Map('map');
      var myaddress = '${address}';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
    	
      
      naver.maps.Service.geocode({address: myaddress}, function(status, response) {
          if (status !== naver.maps.Service.Status.OK) {
              return alert(myaddress + '의 검색 결과가 없거나 기타 네트워크 에러');
          }
          var result = response.result;
          // 검색 결과 갯수: result.total
          // 첫번째 결과 결과 주소: result.items[0].address
          // 첫번째 검색 결과 좌표: result.items[0].point.y, result.items[0].point.x
          var myaddr = new naver.maps.Point(result.items[0].point.x, result.items[0].point.y);
          map.setCenter(myaddr); // 검색된 좌표로 지도 이동
          // 마커 표시
          var marker = new naver.maps.Marker({
            position: myaddr,
            map: map
          });
          // 마커 클릭 이벤트 처리
          naver.maps.Event.addListener(marker, "click", function(e) {
            if (infowindow.getMap()) {
                infowindow.close();
            } else {
                infowindow.open(map, marker);
            }
          });
          // 마크 클릭시 인포윈도우 오픈
          var infowindow = new naver.maps.InfoWindow({
              content: '<h4> [네이버 개발자센터]</h4><a href="https://developers.naver.com" target="_blank"><img src="https://developers.naver.com/inc/devcenter/images/nd_img.png"></a>'
          });
      });

      </script> --%>
