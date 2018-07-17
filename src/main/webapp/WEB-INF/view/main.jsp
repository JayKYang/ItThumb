<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 메인</title>
<style>
#applybutton {
  border-radius: 4px;
  background-color: skyblue;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 18px;
  padding: 20px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}
#applybutton:hover {
  background-color: pink;
}

#applybutton span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

#applybutton span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

#applybutton:hover span {
  padding-right: 25px;
}

#applybutton:hover span:after {
  opacity: 1;
  right: 0;
}
</style>
</head>
<body>
	<header class="w3-wide" style="width: 100%;">
		<img src="mainimg/mainphoto2.jpg"
			class="w3-round w3-image w3-opacity-min" width="100%">
	</header>


	<!-- About Section -->
	<div class="w3-row w3-container w3-padding-64" style="margin-left: 5%; margin-right: 5%;">
		<h2>채용공고</h2>
		<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" var="now" pattern="yyyyMMdd" />
		<div class="w3-row-padding">
			<c:if test="${!empty popBoardlist }">
				<c:forEach var="popBoard" items="${popBoardlist}" varStatus="status">
					<div
						class="w3-quarter w3-container w3-card w3-center w3-padding-16"
						style="width:25%; height:380px;">
						<div class="w3-container" style="height:100px;">
							<img src="photo/${popBoard.user.imageUrl }" style="width: 60%; height:100%;">
						</div>
						<div class="w3-container">
							<h3>
								<a href="hire/companyDetail.jsy?hireno=${popBoard.hireno }&pageNum=${pageNum}" style="text-decoration:none; font-size:20px;" target="_blank"><b>${popBoard.company }</b></a>
							</h3>
						</div>
						<div class="w3-container">
							<h3><a href="hire/hiredetail.jsy?hireno=${popBoard.hireno }"  style="text-decoration:none; font-size:12px;">${popBoard.subject }</a></h3>
						</div>
						<div class="w3-container">
							<fmt:formatDate value="${popBoard.deadline}" var="date"
								pattern="yyyyMMdd" />
							<c:if test="${date-now != 0 }">
								<p>마감 ${date - now } 일 전</p>
								<c:if test="${date-now < 3 }">
									<a class="w3-text-red w3-tag">마감 임박</a>
								</c:if>
							</c:if>
							<c:if test="${date-now == 0 }">
								<a class="w3-text-red">마감 공고입니다.</a>
							</c:if>
							
						</div>
						<c:set value="${status.count }" var="regNum" />
					</div>
				</c:forEach>
			</c:if>
			<c:forEach begin="1" end="${4-regNum }">
				<div class="w3-quarter w3-container w3-card w3-center"
					style="width:25%; height:380px;">
					<h4 style="margin-top: 48%;">공고가 없습니다.</h4>
				</div>
			</c:forEach>
		</div>
	</div>
	<hr>
	<div class="w3-row w3-container w3-padding-64" style="margin-left: 5%; margin-right: 5%;">
		<div class="w3-container w3-half" style="height:150px;">
			<div class="w3-half" style="width: 20%">
				<img src="mainimg/manual1.png" style="width:140px; height:140px;">
			</div>
			<div class="w3-half">
				<h5 class="w3-text-orange">1.포트폴리오 작성을 쉽게!</h5>
				<p>포트폴리오는 어떻게 만들어? 궁금증이 있는 당신!<br>
				사이트에서 제공하는 폼을 이용해서 포트폴리오
				</p>
			</div>
		</div>
		<div class="w3-container w3-half" style="height:150px;">
			<div class="w3-half" style="width: 20%">
				<img src="mainimg/manual2.png">
			</div>
			<div class="w3-half">
				<h5 class="w3-text-green">2.기업과 함께하는 ITThumb!</h5>
				<p>기업이 눈여겨보는 포트폴리오를 만들어보세요.<br> 기업이 포트폴리오를 직접 보고 연락을 드립니다.<br>채용공고도 같이 만나는건 덤!
			</div>
		</div>
	</div>
	<div class="w3-row w3-container" style="margin-left: 5%; margin-right: 5%;">
		<div class="w3-container w3-half" style="height:150px;">
			<div class="w3-half" style="width: 20%">
				<img src="mainimg/manual3.png">
			</div>
			<div class="w3-half">
				<h5 class="w3-text-blue">3.효율적인 공부 스터디 매칭!</h5>
				<p>스터디를 구해서 같이 공부해보세요.<br>
				ITThumb은 편리한 스터딩 매칭 시스템이 있습니다.</p>
			</div>
		</div>
		<div class="w3-container w3-half" style="height:150px;">
			<div class="w3-half" style="width: 20%">
				<img src="mainimg/manual4.png">
			</div>
			<div class="w3-half">
				<h5 class="w3-text-red">4.다양한 정보의 커뮤니티</h5>
				<p>여러분들의 입을 모아주세요.<br>
				코딩 질문, 회사 관련 후기 등등 ITThumb커뮤니티를 이용하여 여러분의 이야기를 들려주세요!</p>
			</div>
		</div>
	</div>
	<hr>
	<div class="w3-row w3-container w3-padding-64" style="margin-left: 5%; margin-right: 5%;">
			<div class="w3-half w3-center">
				<img src="mainimg/hire.png">
			</div>
			<div class="w3-half">
				<br>
				<h1>같이 일 할 인재를 찾고 계신가요?</h1><br>
				<p>채용 공고를 신청해주세요. 관리자가 채용공고를 사이트에 등록해드립니다!<br>
				<button id="applybutton" onclick="location.href='hire/hirewrite.jsy'"><span>채용 공고 신청하기</span></button>
			</div>
	</div>
</body>
</html>

