<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<title>잇썸 > 포트폴리오</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
#savebutton {
  border-radius: 4px;
  background-color: orange;
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
#savebutton:hover {
  background-color: #ffe4b3;
}

#savebutton span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

#savebutton span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

#savebutton:hover span {
  padding-right: 25px;
}

#savebutton:hover span:after {
  opacity: 1;
  right: 0;
}
</style>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#scrap').click(function() {
			$.ajax({
				url : "portfolioScrap.jsy",
				type : "POST",
				data : {"memberid":'${sessionScope.login.memberid}',"memberid2":'${user.memberid}'},
				success : function(data) {
					if(data.success == 'success'){
						$("#scrap2").attr("class","fa fa-heart w3-xxlarge");
						alert("스크랩 되었습니다.");
					}else{
						$("#scrap2").attr("class","fa fa-heart-o w3-xxlarge");
						alert("스크랩이 해제 되었습니다.");
					}
				}
			});
		})
	})
</script>
<script>
	$(document).ready(function() {
		url = document.URL.split("#");
		if (url[1] != null) {
			openPortfolio(url[1]);
		}
	});
	function openPortfolio(mypageName) {
		var i;
		var x = document.getElementsByClassName("portfoliopage");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		document.getElementById(mypageName).style.display = "block";
	}
</script>
<script>
	function openPortfolio(pageName) {
		var i;
		var x = document.getElementsByClassName("portfoliopage");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		document.getElementById(pageName).style.display = "block";
	}
	function message_open(url) {
		window.open(url, "message", "width=40%, height=80%, left=100, top=100");
	}
</script>
<style>
.skills {
	text-align: right;
	padding-right: 20px;
	line-height: 40px;
	color: white;
}

.fullbar {
	width: 100%;
	background-color: #ddd;
}
</style>
</head>
<body>
	<a href="#about"></a>
	<!-- Icon Bar (Sidebar - hidden on small screens) -->
	<div class="w3-bar w3-small w3-left w3-orange" style="width:100%;">
		<!-- Avatar image in top left corner -->
		<a href="#about" class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;"
			onclick="openPortfolio('about')"> <i
			class="fa fa-user w3-xxlarge"></i>
			<p>ABOUT ME</p>
		</a> <a href="#project" style="width:10%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-amber"
			onclick="openPortfolio('project')"> <i
			class="fa fa-eye w3-xxlarge"></i>
			<p>MY WORK</p>
		</a>
		<c:if test="${sessionScope.login.memberid == user.memberid }">
			<a class="w3-bar-item w3-button w3-padding-large w3-hover-amber w3-right" style="width:10%;"
				onclick="javascript:location.href='portfolioform.jsy?id=${sessionScope.login.memberid}'">
				<i class="fa fa-edit w3-xxlarge"></i>
				<p>EDIT</p>
			</a>
		</c:if>
		<c:if test="${sessionScope.login.memberid != user.memberid }">
			<a class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;"
				onclick="javascript:message_open('../../message/messageWrite.jsy?memberid=${user.memberid}')">
				<i class="fa fa-commenting w3-xxlarge"></i>
				<p>CONTACT</p>
			</a>
			<c:if test="${sessionScope.login.membergrade == 0 or sessionScope.login.membergrade == 2 }">
			<a class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;"
			onclick="javascript:location.href='portfoliolist.jsy'">
				<i class="fa fa-align-justify w3-xxlarge"></i>
				<p>List 돌아가기</p>
			</a>
			</c:if>
			<c:if test="${sessionScope.login.membergrade == 0 or sessionScope.login.membergrade == 2 }">
			<a id="scrap" class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;"> 
				<c:if test="${scrapConfirm==0}">
					<i id="scrap2" class="fa fa-heart-o w3-xxlarge"></i>
				</c:if>
				<c:if test="${scrapConfirm==1}">
					<i id="scrap2" class="fa fa-heart w3-xxlarge"></i>
				</c:if>
				<p>스크랩</p>
			</a>
			</c:if>
		</c:if>
	</div>

	<!-- Page Content -->
	<!-- Header/Home -->
	<div class="portfoliopage w3-content w3-container"
		id="about">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-orange w3-xxlarge">포트폴리오</span>
			</p>
		</div>
		<h3 class="w3-center">
			<a class="w3-xxxlarge">${user.slogun }</a>
		</h3>
		<p class="w3-center">
			<a class="w3-xlarge">${user.introduce }</a>
		</p>
		<div class="w3-content w3-container w3-padding-32">
			<table style="width: 98%">
				<tr class="w3-center">
					<td rowspan="7" style="width: 40%;"><c:if
							test="${empty user.imageUrl }">
							<img class="w3-circle w3-card" src="../../photo/defaultphoto.png"
								style="width: 70%">
						</c:if> <c:if test="${!empty user.imageUrl }">
							<img class="w3-circle w3-card"
								src="../../photo/${user.imageUrl }" style="width: 70%">
						</c:if></td>
				</tr>
				<tr>
					<td style="width: 5%;"><i
						class="fa fa-user fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td style="width: 60%;"><a class="w3-xlarge w3-hover-opacity">${user.name }</a></td>
				</tr>
				<tr>
					<td><i
						class="fa fa-calendar fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td>
						<c:if test="${!empty user.birth }">
							<a class="w3-xlarge w3-hover-opacity"><fmt:formatDate
									value="${user.birth}" type="both" pattern="yyyy" /></a>년<a
							class="w3-xlarge w3-hover-opacity"><fmt:formatDate
									value="${user.birth}" type="both" pattern="MM" /></a>월 <a
							class="w3-xlarge w3-hover-opacity"><fmt:formatDate
									value="${user.birth}" type="both" pattern="dd" /></a>일
						</c:if>
						<c:if test="${empty user.birth }">
							<a class="w3-xlarge w3-text-gray">비공개</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
						<i class="fa fa-map-marker fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i>
					</td>
					<td>
						<c:if test="${!empty user.address }">
							<a class="w3-xlarge w3-hover-opacity">${user.address }</a>거주
						</c:if>
						<c:if test="${empty user.address }">
							<a class="w3-xlarge w3-text-gray">비공개</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>
						<i class="fa fa-phone fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i>
					</td>
					<td>
						<c:if test="${!empty user.tel }">
							<a class="w3-xlarge w3-hover-opacity">${user.tel }</a>
						</c:if>
						<c:if test="${empty user.tel }">
							<a class="w3-xlarge w3-text-gray">비공개</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td><i class="fa fa-envelope fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity">${user.memberid }</a></td>
				</tr>
				<tr>
					<td><i class="fa fa-link fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td>
						<c:if test="${!empty user.site }">
							<a class="w3-xlarge w3-hover-opacity" href="http://${user.site }">${user.site }</a>
						</c:if>
						<c:if test="${empty user.site }">
							<a class="w3-xlarge w3-text-gray">비공개</a>
						</c:if>
					</td>
				</tr>
			</table>
			<c:if test="${!status.last }">
				<hr style="height: 2px; background: orange;">
			</c:if>
		</div>
		<c:if test="${!empty user.historyList }">
		<div class="w3-row">
			<div class="w3-container w3-half"
				style="padding-bottom: 50px; width: 50%; float: left;">
					<h3 class="w3-center">
						<a class="w3-xxxlarge">EXPERIENCE</a><a class="w3-large"></a>
					</h3>
				<div class="w3-container" style="float: left; margin-bottom:50px; width:100%;">
					<c:forEach items="${user.historyList }" var="history">
						<c:if test="${history.kindno == 0 }">
						<br>
							<div class="w3-center w3-orange" style="width:100%; height:70px; border-radius:25px;"><br>
								<fmt:formatDate value="${history.getdate }" type="both"
									pattern="yyyy-MM-dd" />
								<c:if test="${history.enddate != null }">
					  			 ~ <fmt:formatDate value="${history.enddate }" type="both"
										pattern="yyyy-MM-dd" />
								</c:if>
								 : ${history.content }
							</div>
						</c:if>
					</c:forEach>
				</div>
				<h3 class="w3-center" style="margin-top:110px;">
					<a class="w3-xxxlarge">LICENSE</a>
				</h3>
				<div class="w3-container" style="width: 100%" style="float:left;">
					<div id="licenseform" style="width: 100%">
						<c:forEach items="${user.historyList }" var="history">
							<c:if test="${history.kindno == 2 }">
							<br>
							<div class="w3-center w3-orange" style="width:100%; height:70px; border-radius:25px;"><br>
								<fmt:formatDate value="${history.getdate }" type="both"
									pattern="yyyy-MM-dd" var="getdate" />
									${getdate } : ${history.content }
							</div>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="w3-container w3-half"
				style="padding-bottom: 50px; width: 50%;">
				<h3 class="w3-center">
					<a class="w3-xxxlarge">SKILLS</a><a class="w3-large"></a>
				</h3>
				<div class="w3-container" style="width: 100%; float: left;">
					<c:forEach items="${user.historyList }" var="history">
						<c:if test="${history.kindno == 1 }">
							<p class="w3-wide">${history.content }</p>
							<div class="fullbar">
								<c:if test="${history.skillful >= 90}">
									<div class="skills"	style="width:${history.skillful }%; background-color:#ff4000;">${history.skillful }%</div>
								</c:if>
								<c:if test="${history.skillful < 90  && history.skillful >= 70}">
									<div class="skills"	style="width:${history.skillful }%; background-color:#ff8000;">${history.skillful }%</div>
								</c:if>
								<c:if test="${history.skillful < 70 && history.skillful >= 50}">
									<div class="skills"	style="width:${history.skillful }%; background-color:#ffbf00;">${history.skillful }%</div>
								</c:if>
								<c:if test="${history.skillful < 50 && history.skillful >= 30}">
									<div class="skills"	style="width:${history.skillful }%; background-color:#ffecb3;">${history.skillful }%</div>
								</c:if>
								<c:if test="${history.skillful < 30 }">
									<div class="skills"	style="width:${history.skillful }%; background-color:#fff9e6;">${history.skillful }%</div>
								</c:if>
							</div>
						</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
		</c:if>
	</div>

	<div class="portfoliopage w3-container w3-animate-right" id="project" style="display: none; margin-left:20%;margin-right:20%;">
	<div class="w3-center">
		<p style="margin-top:5%;">
			<span class="w3-content w3-text-orange w3-xxlarge w3-padding-32">프로젝트</span>
		</p>
	</div>
		<c:if test="${empty projectList }">
			<img src="../../mainimg/logo.png" style="width:50%; margin-left:25%;">
			<h3 class="w3-center">
				<span class="w3-large">현재 작성된 프로젝트가 없습니다.<br>
				다음에 <a class="w3-text-indigo w3-xlarge"><b>${user.name }</b></a>님의 포트폴리오를 다시 방문해주세요.
				</span><br>
			</h3>
		</c:if>
		<c:forEach items="${projectList }" var="project" varStatus="status">
		<div class="w3-row" style="width:100%;">
			<c:if test="${status.index % 2 == 0 }">
			<div class="w3-half" style="width:40%;">
				<c:if test="${empty project.imagefileUrl }">
					<img id="profilephoto" style="width: 100%;" src="../../photo/defaultphoto.png">
				</c:if> 
				<c:if test="${!empty project.imagefileUrl }">
					<img id="profilephoto" style="width: 50%;" src="../../projectimg/${project.imagefileUrl }">
				</c:if> 
				<input type="file" name="imagefile" id="imagefile" style="display: none" />
			</div>
			<div class="w3-half">
				<table class="w3-table">
					<tr>
						<td style="width:30%;">
							<span class="w3-xxlarge w3-text-orange">
								<c:if test="${status.count < 10}">
								0
								</c:if>
								${status.count }
							</span>
						</td>
						<td>${project.subject }</td>
					</tr>
					<c:if test="${!empty project.term }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">프로젝트 기간</a></td>
							<td>${project.term }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.skills }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">사용 기술</a></td>
							<td>${project.skills }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.role }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">맡은 역할</a></td>
							<td>${project.role }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.link }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">프로젝트 링크</a></td>
							<td><a href="${project.link }">${project.link }</a></td>
						</tr>
					</c:if>
				</table>
			</div>
			<div class="w3-container">
				<table class="w3-table" style="width:100%;">
					<tr><td colspan="2" style="width:100%;padding-left:3%;"><a class="w3-text-orange w3-large">내용</a><hr></td></tr>
					<c:if test="${!empty project.content }">
						<tr>
							<td colspan="2"><a class="w3-large" style="padding-left:3%">${project.content }</a></td>
						</tr>
					</c:if>
				</table>
				<c:if test="${!status.last }">
					<hr style="height: 2px; background: orange;">
				</c:if>
			</div>
			</c:if>
			<c:if test="${status.index % 2 != 0 }">
			<div class="w3-half">
				<table class="w3-table">
					<tr>
						<td style="width:30%;">
							<span class="w3-xxlarge w3-text-orange">
								<c:if test="${status.count < 10}">
								0
								</c:if>
								${status.count }
							</span>
						</td>
						<td>${project.subject }</td>
					</tr>
					<c:if test="${!empty project.term }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">프로젝트 기간</a></td>
							<td>${project.term }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.skills }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">사용 기술</a></td>
							<td>${project.skills }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.role }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">맡은 역할</a></td>
							<td>${project.role }</td>
						</tr>
					</c:if>
					<c:if test="${!empty project.link }">
						<tr>
							<td align="right"><a class="w3-text-orange w3-large">프로젝트 링크</a></td>
							<td><a href="${project.link }">${project.link }</a></td>
						</tr>
					</c:if>
				</table>
			</div>
			<div class="w3-half" style="width:40%;">
				<c:if test="${empty project.imagefileUrl }">
					<img id="profilephoto" style="width: 100%;" src="../../photo/defaultphoto.png">
				</c:if> 
				<c:if test="${!empty project.imagefileUrl }">
					<img id="profilephoto" style="width: 50%;" src="../../projectimg/${project.imagefileUrl }">
				</c:if> 
				<input type="file" name="imagefile" id="imagefile" style="display: none" />
			</div>
			<div class="w3-container">
				<table class="w3-table" style="width:100%;">
					<tr><td colspan="2" style="width:100%;padding-left:3%;"><a class="w3-text-orange w3-large">내용</a><hr></td></tr>
					<c:if test="${!empty project.content }">
						<tr>
							<td colspan="2"><a class="w3-large" style="padding-left:3%">${project.content }</a></td>
						</tr>
					</c:if>
				</table>
				<c:if test="${!status.last }">
					<hr style="height: 2px; background: orange;">
				</c:if>
			</div>
			</c:if>
			
		</div>	
		</c:forEach>
	</div>
</body>
</html>
