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
 
</style>



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
<h2 style="font-family:'Raleway', sans-serif;">Post a Job Opening</h2>
<br>
<br>
<table width="80%">
		<c:if test="${hirelistcount>0}">
	<c:if test="${hire.hide==1}">
    <div class="w3-row-padding" style="margin:0 -16px">
    <c:forEach items="${hirelist}" var="hire">
		
     <!-- Pricing Tables -->
      <div class="w3-third w3-margin-bottom" id="listDiv">
        <ul class="w3-ul w3-border w3-white w3-center w3-opacity w3-hover-opacity-off">
          <li class="w3-dark-gray w3-xlarge w3-padding-32">${hire.subject}</li>
          <li class="w3-padding-16">${hire.qualification}</li>
          <li class="w3-padding-16">${hire.hirestatus}</li>
          <li class="w3-padding-16">${hire.region}</li>
          <li class="w3-padding-16">${hire.workday}</li>
        </ul>
      </div>
</c:forEach>
     </div> 
     <div>
     <form name="f">
     <input type="hidden" name="hireno" value="${param.hireno }">
     <table align="center">
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
     </form>
     <script type="text/javascript">
function detailhirelist(pageNum){
		var i = document.f.hireno.value
		location.href = "companyDetail.jsy?hireno=" + i+"&pageNum="+pageNum;
		return true;
}
</script>
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
<div id="map" style="width:100%;height:400px;"></div>
 <script>
      var map = new naver.maps.Map('map');
      var myaddress = '탄중로 523';// 도로명 주소나 지번 주소만 가능 (건물명 불가!!!!)
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
</div>
</body>
</html>
