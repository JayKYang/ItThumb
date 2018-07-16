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
	$(document).ready(function(){
		url = document.URL.split("#");
		if(url[1]!=null){
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
	var count1 = 500;
	var count2 = 600;
	var count3 = 700;
	var count4 = 800;

	function openPortfolio(pageName) {
		var i;
		var x = document.getElementsByClassName("portfoliopage");
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		document.getElementById(pageName).style.display = "block";
	}

	// input date 타입 사용시 폼 전달
	function change_date() {
		birth = document.getElementById("datePicker").value
		document.getElementById("birth").value = birth
	}

	// ADD Experience, Skill
	function addForm(id) {
		var addedFormDiv = id;
		var inputtext = null;
		
		if(addedFormDiv.id=='experienceform'){
			inputtext = '<table><tr><td style="width:15%"><input id="getdate_'+count1+'" class="w3-input" type="date" placeholder="시작날짜" name="getdate" style="width:80px;font-size:10px;"/></td>'
					+ '<td style="width:15%"><input id="enddate_'+count1+'" class="w3-input" type="date" placeholder="종료일자" name="enddate" style="width:80px;font-size:10px;"/></td>'
					+ '<td style="width:60%"><input id="content_'+count1+'" class="w3-input" type="text" placeholder="내용" name="content" style="font-size:10px;"/></td>'
					+ '<td style="width:5%"><a id="insert_'+addedFormDiv.id +'_'+ count1 + '" class="w3-button" onclick="insertExperience(\'' + addedFormDiv.id+'_'+ count1 + '_0\')"><i class="fa fa-file-text-o"></i></a></td>'
					+ '<td style="width:5%"><a id="delete_'+addedFormDiv.id +'_'+ count1 + '" class="w3-button" onclick="deleteForm(\''+ addedFormDiv.id +'_'+ count1
					+ '\')">x</a></td></tr></table><input id="chk_'+addedFormDiv.id +'_'+ count1 + '" type="checkbox" style="display:none"><hr>';
					
			if( $("#chk_"+addedFormDiv.id+"_"+(count1-1)).length == 0 || $("#chk_"+addedFormDiv.id+"_"+(count1-1)).attr('checked') == 'checked' ){
				var addedDiv = document.createElement("div");
				addedDiv.setAttribute("id", addedFormDiv.id + "_" + count1);
				addedDiv.innerHTML = inputtext;
		
				addedFormDiv.appendChild(addedDiv);
		
				count1++;			
			}
			else{
				alert('이전 작업이 완료되지 않았습니다.');
			}
		}
		else if(addedFormDiv.id=='skillform'){
			inputtext = '<table><tr><td style="width:15%"><input id="content_'+count2+'" class="w3-input" type="text" placeholder="기술명" name="content" style="font-size:10px;"/></td>'
				+ '<td style="width:15%"><input id="skillful_'+count2+'" class="w3-input" type="text" placeholder="숙련도(0~100)" name="skillful" value="${history.skillful }" style="font-size:10px;"/></td>'
				+ '<td style="width:5%"><a id="insert_'+addedFormDiv.id +'_'+ count2 + '" class="w3-button" onclick="insertExperience(\'' + addedFormDiv.id+'_'+ count2 + '_1\')"><i class="fa fa-file-text-o"></i></a></td>'
				+ '<td style="width:5%"><a id="delete_'+addedFormDiv.id +'_'+ count2 + '" class="w3-button" onclick="deleteForm(\''+ addedFormDiv.id +'_'+ count2
				+ '\')">x</a></td></tr></table><input id="chk_'+addedFormDiv.id +'_'+ count2 + '" type="checkbox" style="display:none"><hr>';
				
			if( $("#chk_"+addedFormDiv.id+"_"+(count2-1)).length == 0 || $("#chk_"+addedFormDiv.id+"_"+(count2-1)).attr('checked') == 'checked' ){
				var addedDiv = document.createElement("div");
				addedDiv.setAttribute("id", addedFormDiv.id + "_" + count2);
				addedDiv.innerHTML = inputtext;
		
				addedFormDiv.appendChild(addedDiv);
		
				count2++;			
			}
			else{
				alert('이전 작업이 완료되지 않았습니다.');
			}
		}
		else if(addedFormDiv.id=='licenseform'){
			inputtext = '<table><tr><td style="width:20%"><input id="getdate_'+count3+'" class="w3-input" type="date" placeholder="취득일자" name="getdate" style="width:80px;font-size:10px;"/></td>'
				+ '<td style="width:30%"><input id="content_'+count3+'" class="w3-input" type="text" placeholder="내용" name="content" style="font-size:10px;"/></td>'
				+ '<td style="width:5%"><a id="insert_'+addedFormDiv.id +'_'+ count3 + '" class="w3-button" onclick="insertExperience(\'' + addedFormDiv.id+'_'+ count3 + '_2\')"><i class="fa fa-file-text-o"></i></a></td>'
				+ '<td style="width:5%"><a id="delete_'+addedFormDiv.id +'_'+ count3 + '" class="w3-button" onclick="deleteForm(\''+ addedFormDiv.id +'_'+ count3
				+ '\')">x</a></td></tr></table><input id="chk_'+addedFormDiv.id +'_'+ count3 + '" type="checkbox" style="display:none"><hr>';
				
			if( $("#chk_"+addedFormDiv.id+"_"+(count3-1)).length == 0 || $("#chk_"+addedFormDiv.id+"_"+(count3-1)).attr('checked') == 'checked' ){
				var addedDiv = document.createElement("div");
				addedDiv.setAttribute("id", addedFormDiv.id + "_" + count3);
				addedDiv.innerHTML = inputtext;		
				addedFormDiv.appendChild(addedDiv);		
				count3++;			
			}
			else{
				alert('이전 작업이 완료되지 않았습니다.');
			}
		}
	}
	
	// Insert Experience
	function insertExperience(cnt1) {  
		id1 = cnt1.split('_'); // id2[0] = 폼네임 , id2[1] = count, id2[2] = kindno
		
		var getdate = null;
		var enddate = null;
		var content = null;
		var skillful = null;
	
		if($('#getdate_'+id1[1]).length != 0) getdate = $("#getdate_"+id1[1]).val();
		if($('#enddate_'+id1[1]).length != 0) enddate = $("#enddate_"+id1[1]).val();
		if($('#content_'+id1[1]).length != 0) content = $("#content_"+id1[1]).val();
		if($('#skillful_'+id1[1]).length != 0) skillful = $("#skillful_"+id1[1]).val();
		
		// unchecked일때 insert 실행
		if( $("#chk_"+id1[0]+"_"+id1[1]).attr('checked') != 'checked'){
			$.ajax({
		        url : "insertExperience.jsy",
		        type : "POST",
		        data : {"getdate":getdate, "enddate":enddate, "content":content, "skillful":skillful, "kindno" : id1[2]},
		        success : function (data) {
		        	if(data.success == 'success'){
			            $("#chk_"+id1[0]+"_"+id1[1]).attr('checked','checked');
			            $("#insert_"+id1[0]+"_"+id1[1]).html('<i class="fa fa-edit"></i>');
			            $("#insert_"+id1[0]+"_"+id1[1]).attr('onclick','insertExperience(\'' + id1[0] +'v_'+ data.historyno + '_'+id1[2]+'\')');
			            $("#delete_"+id1[0]+"_"+id1[1]).attr('onclick','deleteForm(\'' + id1[0] +'v_'+ data.historyno+'\')');
			            $("#insert_"+id1[0]+"_"+id1[1]).attr('id','insert_' + id1[0] +'v_'+ data.historyno);
			            $("#delete_"+id1[0]+"_"+id1[1]).attr('id','delete_' + id1[0] +'v_'+ data.historyno);
			            $("#"+id1[0] + "_" + id1[1]).attr('id',id1[0] +'v_'+ data.historyno);
			            $("#chk_"+id1[0]+"_"+id1[1]).attr('id','chk_'+id1[0]+'v_'+data.historyno);
			            $("#content_"+id1[1]).attr('id','content_'+data.historyno);
			            $("#skillful_"+id1[1]).attr('id','skillful_'+data.historyno);
			            $("#getdate_"+id1[1]).attr('id','getdate_'+data.historyno);
			            $("#enddate_"+id1[1]).attr('id','enddate_'+data.historyno);
			            alert('등록이 완료되었습니다.');
					}else{
						
					}
		        },error:function(request,status,error){
		        }
		    });
		}else{ // checked 일땐 update 실행
			$.ajax({
		        url : "updateExperience.jsy",
		        type : "POST",
		        data : {"getdate":getdate, "enddate":enddate, "content":content, "skillful":skillful, "kindno" : id1[2], "historyno" : id1[1]},
		        success : function (data) {
		        	if(data.success == 'success'){
		        		alert('수정되었습니다.');
					}else{
						
					}
		        },error:function(request,status,error){
		            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error); 
		        }
		    });
		}
	    
	}
	
	// Delete Experience
	function deleteForm(cnt2) {
		id2 = cnt2.split('_'); // id2[0] = 폼네임 , id2[1] = historyno
		
		var deleteFormDiv = null;
		var thisDiv = document.getElementById(id2[0]+"_"+id2[1]);
		
		// data checked상태. -> db제거 후 form 제거
		if( $("#chk_"+id2[0]+"_"+id2[1]).attr('checked') == 'checked' ){
			deleteFormDiv = document.getElementById(id2[0].slice(0,-1));
			  $.ajax({
		        url : "deleteExperience.jsy",
		        type : "POST",
		        data : {"historyno":id2[1]},
		        success : function (data) {
		        	if(data.success == 'success'){
					}else{
						
					}
		        },error:function(request,status,error){
		        }
		    });  
			
		}else{ // data unchecked상태. -> form 만 제거
			deleteFormDiv = document.getElementById(id2[0]);
		} 
		deleteFormDiv.removeChild(thisDiv);
	}

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
<script>
	function pfsubmit(){
		
		
		document.f.submit();
	}
</script>
<style>
button {
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
button:hover {
  background-color: #ffe4b3;
}

button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

button:hover span {
  padding-right: 25px;
}

button:hover span:after {
  opacity: 1;
  right: 0;
}
</style>
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
	<div class="w3-bar w3-small w3-left w3-orange w3-card" style="width:100%;">
		<!-- Avatar image in top left corner -->
		<a href="#about" class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;" onclick="openPortfolio('about')">
		    <i class="fa fa-user w3-xxlarge"></i>
		    <p>ABOUT ME</p>
	    </a>
		<a href="#project" class="w3-bar-item w3-button w3-padding-large w3-hover-amber" style="width:10%;" onclick="openPortfolio('project')">
			<i class="fa fa-eye w3-xxlarge"></i>
			<p>MY WORK</p>
		</a>
	</div>
	<!-- Page Content -->
	<!-- Header/Home -->
	<div class="portfoliopage w3-content w3-container w3-animate-left" id="about">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-orange w3-xxlarge">포트폴리오</span>
			</p>
		</div>
		<form:form modelAttribute="user" action="updateAboutMe.jsy" method="post" enctype="multipart/form-data" name="f">
		<input type="hidden" value="${sessionScope.login.memberid}" name="id">
		<div class="w3-content w3-container w3-padding-32">
		<form:hidden path="imageUrl" />
		<form:hidden class="w3-input" path="password" value="passwordddddd"/>
		<h3 class="w3-center">
			<a class="w3-xxxlarge"><form:input class="w3-input" type="text" placeholder="포트폴리오 이름" path="slogun"/><font color="red"><form:errors path="slogun"/></font></a><input type="checkbox" style="display:none">
		</h3>
			<spring:hasBindErrors name="user">
				<font color="red">
					<c:forEach items="${errors.globalErrors }" var="error">
						<spring:message code="${error.code }"></spring:message>
					</c:forEach>
				</font>
			</spring:hasBindErrors>
			<table style="width: 98%">
				<tr class="w3-center">
					<td rowspan="7" style="width: 40%;">
						<c:if test="${empty sessionScope.login.imageUrl }">
							<img class="w3-circle w3-card" src="../../photo/defaultphoto.png" style="width:70%">
						</c:if> 
						<c:if test="${!empty sessionScope.login.imageUrl }">
							<img class="w3-circle w3-card" src="../../photo/${sessionScope.login.imageUrl }" style="width:70%">
						</c:if>
						<input type="file" name="image" id="image" style="display:none"/>
					</td>
				</tr>
				<tr>
					<td style="width: 5%;"><i class="fa fa-user fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td style="width: 60%;"><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.name }</a><form:hidden path="name"/></td>
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td><i class="fa fa-calendar fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity">
					<!-- <input type="date" id="datePicker" class="w3-input" onchange="change_date()"> -->
					<form:input type="text" path="birth" class="w3-input" placeholder="생일(YYYY-MM-DD)"></form:input><font color="red"><form:errors path="birth"/></font>
					<%-- <form:hidden id="birth" class="w3-input" path="birth" placeholder="생일"/><font color="red"><form:errors path="birth"/></font> --%></a></td>
					<!-- <script>
						document.getElementById("datePicker").value = document.getElementById("birth").value
					</script> -->
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td><i class="fa fa-map-marker fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity"><form:input class="w3-input" path="address" placeholder="거주지"/><font color="red"><form:errors path="address"/></font></a></td>
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td><i class="fa fa-phone fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity"><form:input class="w3-input" path="tel" placeholder="연락처"/><font color="red"><form:errors path="tel"/></font></a></td>
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td><i class="fa fa-envelope fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity">${sessionScope.login.memberid }</a><form:hidden path="memberid"/></td>
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td><i class="fa fa-paperclip fa-fw w3-hover-text-black w3-xlarge w3-margin-right"></i></td>
					<td><a class="w3-xlarge w3-hover-opacity"><form:input class="w3-input" path="site" placeholder="링크주소"/><font color="red"><form:errors path="site"/></font></a></td>
					<td><input type="checkbox" style="display:none"></td>
				</tr>
				<tr>
					<td colspan="3">
						<p class="w3-center">
							<a class="w3-xlarge"><form:textarea class="w3-input" cols="50" rows="10" placeholder="자기소개" path="introduce" value=""></form:textarea><font color="red"><form:errors path="introduce"/></font></a><input type="checkbox" style="display:none">
						</p>
					</td>
				</tr>
			</table>
		</div>
		<hr>
		<div class="w3-row">
			<div class="w3-container w3-half" style="padding-bottom: 50px; width: 50%; float: left;">
				<h3 class="w3-center">
					<a class="w3-xxxlarge">EXPERIENCE</a>
				</h3>
				<div class="w3-container w3-center" style="width: 100%">
					<div id="experienceform" style="width: 100%">
						<c:forEach items="${sessionScope.login.historyList }" var="history" varStatus="status">
							<c:if test="${history.kindno == 0 }">
								<div id="experienceformv_${history.historyno}">
										<fmt:formatDate value="${history.getdate }" type="both" pattern="yyyy-MM-dd" var="getdate"/>
										<fmt:formatDate value="${history.enddate }" type="both" pattern="yyyy-MM-dd" var="enddate"/>
										<table>
											<tr>
												<td style="width:20%"><input class="w3-input" type="text" id="getdate_${history.historyno}" placeholder="시작날짜" name="getdate" value="${getdate }" style="width:80px;font-size:10px;""/></td>
												<td style="width:20%"><input class="w3-input" type="text" id="enddate_${history.historyno}" placeholder="종료일자" name="enddate" value="${enddate }" style="width:80px;font-size:10px;"/></td>
												<td style="width:30%"><input class="w3-input" type="text" id="content_${history.historyno}" placeholder="내용" name="content" value="${history.content }" style="font-size:10px;"/></td>
												<td style="width:5%"><a id="insert_experienceformv_${history.historyno }" class="w3-button" onclick="insertExperience('experienceformv_${history.historyno}_0')"><i class="fa fa-edit"></i></a></td>
												<td style="width:5%"><a id="delete_experienceformv_${history.historyno }" class="w3-button" onclick="deleteForm('experienceformv_${history.historyno}')">x</a><input id="chk_experienceformv_${history.historyno}" type="checkbox" checked="checked" style="display:none"></td>
											</tr>
										</table><hr>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<h3>
						<a class="w3-button w3-center" onclick="javascript:addForm(experienceform)"><i class="fa fa-plus-square-o"></i></a>
					</h3>
				</div>
				<div class="w3-container" style="padding-bottom: 50px; width: 100%; float: left;">
					<h3 class="w3-center">
						<a class="w3-xxxlarge">LICENSE</a>
					</h3>
					<div class="w3-center" style="width: 100%">
						<div id="licenseform" style="width: 100%">
							<c:forEach items="${sessionScope.login.historyList }" var="history" varStatus="status">
								<c:if test="${history.kindno == 2 }">
									<div id="licenseformv_${history.historyno}">
											<fmt:formatDate value="${history.getdate }" type="both" pattern="yyyy-MM-dd" var="getdate"/>
											<fmt:formatDate value="${history.enddate }" type="both" pattern="yyyy-MM-dd" var="enddate"/>
											<table>
												<tr>
													<td style="width:20%"><input class="w3-input" id="getdate_${history.historyno}" type="text" placeholder="취득일자" name="getdate" value="${getdate }" style="width:80px;font-size:10px;"/></td>
													<td style="width:30%"><input class="w3-input" id="content_${history.historyno}" type="text" placeholder="내용" name="content" value="${history.content }" style="font-size:10px;"/></td>
													<td style="width:5%"><a class="w3-button" onclick="insertExperience('licenseformv_${history.historyno}_2')"><i class="fa fa-edit"></i></a></td>
													<td style="width:5%"><a class="w3-button" onclick="deleteForm('licenseformv_${history.historyno}')">x</a><input id="chk_licenseformv_${history.historyno}" type="checkbox" checked="checked" style="display:none"></td>
												</tr>
											</table><hr>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<h3>
							<a class="w3-button w3-center" onclick="javascript:addForm(licenseform)"><i class="fa fa-plus-square-o"></i></a>
						</h3>
					</div>
				</div>
			</div>
			<div class="w3-container w3-half" style="padding-bottom: 50px; width: 50%;">
				<h3 class="w3-center">
					<a class="w3-xxxlarge">SKILLS</a><a class="w3-large"></a>
				</h3>
				<div class="w3-container w3-center" style="width: 100%">
					<div id="skillform" style="width: 100%">
						<c:forEach items="${sessionScope.login.historyList }" var="history">
							<c:if test="${history.kindno == 1 }">
								<div id="skillformv_${history.historyno}">
									<fmt:formatDate value="${history.getdate }" type="both" pattern="yyyy-MM-dd" var="getdate"/>
									<table>
										<tr>
											<td style="width:15%"><input class="w3-input" id="content_${history.historyno}" type="text" placeholder="기술명" name="content" value="${history.content }" style="font-size:10px;"/></td>
											<td style="width:15%"><input class="w3-input" id="skillful_${history.historyno}" type="text" placeholder="숙련도(0~100)" name="skillful" value="${history.skillful }" style="font-size:10px;"/></td>
											<td style="width:5%"><a id="insert_skillformv_${history.historyno }" class="w3-button" onclick="insertExperience('skillformv_${history.historyno}_1')"><i class="fa fa-edit"></i></a></td>
											<td style="width:5%"><a class="w3-button" onclick="deleteForm('skillformv_${history.historyno}')">x</a><input  id="chk_skillformv_${history.historyno}" type="checkbox" checked="checked" style="display:none"></td>
										</tr>
									</table><hr>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<h3>
						<a class="w3-button w3-center" onclick="javascript:addForm(skillform)"><i class="fa fa-plus-square-o"></i></a>
					</h3>
				</div>
			</div>
		</div>
		<table style="width: 98%">
				<tr>
					<td colspan="3" align="right"><button id="savebutton" class="w3-xlarge" onclick="javascript:pfsubmit();"><i class="fa fa-floppy-o"></i>&nbsp;저장하기</button></td>
				</tr>
		</table>
		</form:form>
	</div>



	<div class="portfoliopage w3-content w3-container w3-animate-right" id="project" style="display: none">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-orange w3-xxlarge">프로젝트</span>
			</p>
		</div>
		<div class="w3-content w3-container w3-padding-32 w3-center">
			<table class="w3-table w3-bordered">
				<tr><th style="width:10%">순서</th><th style="width:40%">대표사진</th><th style="width:40%">제목</th><th style="width:10%;"></th></tr>
				<c:if test="${!empty projectList }">
						<c:forEach items="${projectList }" var="project" varStatus="status">
							<tr><td>${status.count }</td><td><img src="../../projectimg/${project.imagefileUrl }" style="width:30%"></td><td>${project.subject }</td><td><a href="projectform.jsy?id=${sessionScope.login.memberid }&projectno=${project.projectno}">수정</a>
							<a href="deleteproject.jsy?id=${sessionScope.login.memberid }&projectno=${project.projectno}">삭제</a></td></tr>
						</c:forEach>
				</c:if>
				<c:if test="${empty projectList }">
					<tr>
						<td colspan="4">프로젝트가 존재하지 않습니다.</td>
					</tr>
				</c:if>
			</table>
		</div>
		<div class="w3-right">
			<button onclick="location.href='projectform.jsy?id=${sessionScope.login.memberid }'">프로젝트 추가</button>
		</div>
		<div class="w3-center">
			<img src="../../mainimg/project.jpg" style="margin-top:5%; opacity:0.65; width:900px; height:400px;">
		</div>
	</div>
</body>
</html>
