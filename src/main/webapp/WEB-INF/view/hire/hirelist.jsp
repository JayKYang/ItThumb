<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="fmt2" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 채용공고</title>
 <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=qDOuw0wNL1zXEzspRGUC&submodules=geocoder"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
button {
  border-radius: 4px;
  background-color: blue;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 18px;
  padding: 10px;
  width: 100px;
  height:40px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}
button:hover {
  background-color: skyblue;
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
<script type="text/javascript">
var divchkarr = new Array();
var idx = 0;
$(document).ready(function(){
	var a = ['서울특별시','인천광역시','대전광역시','광주광역시','대구광역시','울산광역시','부산광역시','세종특별자치시','경기도','강원도','충청북도','충청남도','전라북도','전라남도','경상북도','경상남도','제주도'];
	var html ="";
	html += "<br>";
	for(var i=0; i<a.length; i++){
		html += '<input style="font-size:2px;" type="checkbox" name="bbb" id="bbb'+i+'" value="\''+a[i]+'\'">'+a[i];
		//if(i==5){
		html += '<br>';
		//}
	}
	$("#region").append(html);	
	
	var b = ['고등학교 졸업 이상','대학교(2,3년) 졸업 이상', '대학교(4년) 졸업 이상', '석사 졸업 이상', '박사 졸업 이상']
	var html2 = "<br>";
	for(var i=0; i<b.length; i++){
		html2 += ' <input class="w3-radio w3-large" type="radio" name="aaa" value="\''+b[i]+'\'">'+b[i];
		html2 += "<br>";
	}
	$("#levelofedu").append(html2);
	
	var c =['정규직','파견직','인턴직','계약직','위촉직','프리랜서','기타']
	var html3 = "";
	html3 += "<br>";
	for(var i=0; i<c.length; i++){
		html3 += '<input class="w3-checkbox w3-large" type="checkbox" name="ccc" id="ccc'+i+'" value="\''+c[i]+'\'">'+c[i];
		html3 += "<br>";
	}
	$("#employmenttype").append(html3);	

	
	var d =["신입","경력"];
	var e = ['6개월 이하','1년 이하','3년 이하','5년 이하'];
	var html4 ="";
	html4 += "<br>";
	for(var i=0; i<d.length; i++){
		html4 += '<input class="w3-checkbox" type="checkbox" name="ddd" id="ddd'+i+'" value="\''+d[i]+'\'">'+d[i];
		html4 += "<br>";
	}
		html4 += '<select class="w3-select" id="inputCareerDate" name="inputCareerDate">';
		html4 += '<option>선택해주세요</option>';
		for(var j=0; j <e.length; j++){
			html4 += '<option value="\''+e[j]+'\'">' + e[j] + '</option>';
		}
		html += '</select>'
	$("#carrarea").append(html4);
		$("select[name=inputCareerDate]").attr("disabled",true);

	
	//checkbox 
	
	$('input[name="bbb"]').click(function(i){
		var classRegion = "classRegion";
		var a=[];
		if ($( this ).prop( "checked" ) == true)
			divchkarr[idx++] =$( this ).val();
		else {
			for(var i=0;i<idx;i++) {
				console.log($( this ).val()+","+ divchkarr[i]);
				if($( this ).val() == divchkarr[i]) {
			         divchkarr.splice(i,1);
			         idx--;
			         break;
				}
			}
		} 
   divchkdisp(classRegion);
 		$('input[name="searchRegion"]').val(null);	
		$('input[name="bbb"]:checked').each(function(){
			
			a.push($(this).val());
			$('input[name="searchRegion"]').val(a);
   		}) 
	})
		
		
	$('input[name="aaa"]').click(function(){
		var classEdu = "classEdu";
		var b = "";
		b = $('input[name="aaa"]:checked').val();
		$('input[name="searchEdu"]').val(b);
		
   	  var i =0;
       for(i=0;i<idx;i++) {
			if(divchkarr[i].indexOf("졸업") >0) {
		         divchkarr.splice(i,1, b);
		        break;
		         if($(this).val() == divchkarr[i]) {
		        
			         divchkarr.splice(i,1);
			         idx--;
			         break;
				}
			}
		}
      if( i == idx) {
	         divchkarr[idx++] = b;
      }      
     divchkdisp(classEdu);		
	})
	
	
	
	
	
	$('input[name="ccc"]').click(function(){
		var classCarr = "classCarr";
		var c = [];
		if ($( this ).prop( "checked" ) == true)
			divchkarr[idx++] =$( this ).val();
		else {
			for(var i=0;i<idx;i++) {
				if($( this ).val() == divchkarr[i]) {
			         divchkarr.splice(i,1);
			         idx--;
			         break;
				}
			}
		} 
   divchkdisp(classCarr);
		
		$('input[name="searchCarr"]').val(null);			
		$('input[name="ccc"]:checked').each(function(){
			c.push($(this).val());				
            $('input[name="searchCarr"]').val(c);

	   });
	})
	
	$('input[name="ddd"]').click(function(){
		var classCareer = "classCareer";
		if($("#ddd1").prop("checked")==true){
			$("select[name=inputCareerDate]").attr("disabled",false);
		} else{
			$("select[name=inputCareerDate]").attr("disabled",true);
			$('input[name="searchCareerDate"]').val(null);
		}
		var d=[];
		if ($( this ).prop( "checked" ) == true)
			divchkarr[idx++] =$( this ).val();
		else {
			for(var i=0;i<idx;i++) {
				console.log($( this ).val()+","+ divchkarr[i]);
				if($( this ).val() == divchkarr[i]) {
			         divchkarr.splice(i,1);
			         idx--;
			         break;
				}
			}
		} 
		divchkdisp(classCareer);
		$('input[name="searchCareer"]').val(null);	
		$('input[name="ddd"]:checked').each(function(){
			d.push($(this).val());		
			console.log(d);
            $('input[name="searchCareer"]').val(d);
		
	   });
	});
	
	$("#inputCareerDate").change(function(){
		var inputCareerDate = "inputCareerDate";

		var e = $("#inputCareerDate option:selected").val();
	 	if(e == '선택해주세요'){
	 		e="";
	 		alert("경력을 선택해 주세요.");
	 	}
	 	$('input[name="searchCareerDate"]').val(e);
       var i=0;
       for(i=0;i<idx;i++) {
			if(divchkarr[i].indexOf("이하") > 0) {
				console.log($( this ).val()+","+ i+",b="+e);
		         divchkarr.splice(i,1, e);
		         break;
			}
		}
		console.log("i=" + i + ",idx=" + idx)
      if( i == idx) {
	         divchkarr[idx++] = e;
      }      
     divchkdisp(inputCareerDate);		
	}) //
	


	
	
	     	$(".classRegion").click(function(){
	     		event.preventDefault();
	    		var def=[]
	    		$('input[name="searchRegion"]').val(null);
	    	    $('input[name="bbb"]').each(function(i,item) {
	    		    if($('input[name="bbb"]').prop("checked")==true) {
	    		    	def.push($(this).val());
	    		    }
	    	    })
	    		$('input[name="searchRegion"]').val(def);
	    	    })
	    	
	    	    $(".classCarr").click(function(){
	    	    	event.preventDefault();
	    	    })
})


function divchkdisp(classname) {
	htmla = "";
	for(var i =0; i<idx; i++){
		htmla+='<a href="javascript:checkOn('+divchkarr[i]+')" class="'+classname+'  "  name="'+divchkarr[i]+'" value="'+divchkarr[i]+'">'+divchkarr[i]+'</a> ';	
	}
	$("#divchk").html(htmla);	
}


function checkOn(check){
	
	abc = "'"+check+"'";
	
	for(var i=0;i<divchkarr.length;i++) {
		if(check.indexOf('졸업') < 0&&abc.indexOf('이하') > 0){ //셀렉트 박스 를 위한
			console.log("if"); 
			if(abc==divchkarr[i]){
				divchkarr.splice(i,1);
		         idx--;
		         $('input[name="searchCareerDate"]').val(null);
		         $('select[name="inputCareerDate"]').val("선택해주세요").prop("selected", true);
		         divchkdisp(check);				
					break;
				}	
		} else if (check.indexOf('졸업') < 0){ // 체크박스를 위한
			
		if(abc== divchkarr[i]) {
		         divchkarr.splice(i,1);
		         idx--;
		         $('input:checkbox[value="'+abc+'"]').trigger("click");
		         $('input:radio[value="'+abc+'"]').prop('checked',false);
				 break;
			}
		}else{//라디오를 위한
			$('input[name="searchEdu"]').val(null);
			$('input:radio[value="'+abc+'"]').prop('checked',false);
			for(var i=0;i<divchkarr.length;i++) {
				if(abc == divchkarr[i]) {
			         divchkarr.splice(i,1);
			         idx--;
			         break;
				}
			}
			divchkdisp(check);
		}
	}
 }

function hirelist(pageNum){
	var searchRegion = document.searchform.searchRegion.value;
	var searchEdu = document.searchform.searchEdu.value;
	var searchCarr = document.searchform.searchCarr.value;
	var searchCareer = document.searchform.searchCareer.value;
	var searchCareerDate = document.searchform.searchCareerDate.value;
	
	
	
	
	if(searchRegion==null&&searchEdu==null&&searchCarr==null&&searchCareer==null&&searchCareerDate==null|| searchRegion.length==0&&searchEdu.length==0&&searchCarr.length==0&&searchCareer.length==0&&searchCareerDate.length==0){
		document.searchform.pageNum.value = "1";
		location.href = "hirelist.jsy?pageNum=" + pageNum;
	} else{
		document.searchform.pageNum.value = pageNum;
		document.searchform.submit();
		return true;
	}
	return false;
	}
</script>
<style type="text/css">
#aa, #bb,#cc {
	border: 1px solid #000000;
	width: 250px;
	height : 400px;	
}

#table  td, th{
	border-bottom : 1px solid #000000;
}

</style>
</head>
<body>
<div class="w3-content">
	<p>
		<span class="w3-content w3-text-indigo w3-xxlarge">채용공고</span>
	</p>
	<div class="w3-quarter" style="overflow-y: scroll; height:300px;">
		<h4 class="w3-text-indigo">지역</h4>
		<div id="region" class="w3-container">
		</div>
	</div>
	<div class="w3-quarter" style="overflow-y: scroll; height:300px;">
		<h4 class="w3-text-indigo">학력</h4>
		<div id="levelofedu" >
		</div>
	</div>
	<div class="w3-quarter" style="overflow-y: scroll; height:300px;">
		<h4 class="w3-text-indigo">고용형태</h4>
		<div id="employmenttype">
		</div>
	</div>
	<div class="w3-quarter" style="overflow-y: scroll; height:300px;">
		<h4 class="w3-text-indigo">경력</h4>
		<div id="carrarea">
		</div>
	</div>
	<div class="w3-container w3-border" style="width:100%">
		<form action="hirelist.jsy" method="post" name="searchform" onsubmit="return hirelist(1)">
			<table class="w3-table" style="width:100%" id="table">
				<tr>
					<td colspan="8" align="center">
						<input type="hidden" name="pageNum" value="1">
						<input type="hidden" name="popPageNum" value="1">
						<input type="hidden" name="searchRegion" id="searchRegion" value="${param.searchRegion}">
						<input type="hidden" name="searchEdu" value="${param.searchEdu}">
						<input type="hidden" name="searchCarr" value="${param.searchCarr}">
						<input type="hidden" name="searchCareer" value="${param.searchCareer }">
						<input type="hidden" name="searchCareerDate" value="${param.searchCareerDate}">
					</td>
				</tr>
				<tr>
					<td colspan="8" width="90%" height="100px" id="allchk">
							<div id="divchk">
							
							</div>
					</td>
				</tr>
				<tr><td><button class="w3-right" onclick="javascript:document.searchform.submit()" >조회하기</button></td></tr>
			</table>
		</form>	
	</div>
	<table>
		<tr>
			<td colspan="8">
				<p>
					<span class="w3-content w3-text-indigo w3-xlarge">인기공고</span>
				</p>
				<a href="calender.jsy">달력</a>
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" var="now" pattern="yyyyMMdd" />
		<div class="w3-row-padding">
			<c:if test="${!empty popBoardlist }">
				<c:forEach var="popBoard" items="${popBoardlist}" varStatus="status">
					<div
						class="w3-quarter w3-container w3-card w3-center w3-padding-16"
						style="width:25%; height: 350px;">
						<div class="w3-container" style="height:100px;">
							<img src="../photo/${popBoard.user.imageUrl }" style="width: 60%; height:100%;">
						</div>
						<div class="w3-container">
							<h4>
								<a href="companyDetail.jsy?hireno=${popBoard.hireno }&pageNum=${pageNum}" style="text-decoration:none; font-size:20px;" target="_blank"><b>${popBoard.company }</b></a>
							</h4>
						</div>
						<div class="w3-container">
							<h6><a href="hiredetail.jsy?hireno=${popBoard.hireno }" style="text-decoration:none; font-size:12px;" target="_blank">${popBoard.subject }</a></h6>
						</div>
						<div>
							<div>
							<fmt:formatDate value="${popBoard.deadline}" var="date"	pattern="yyyyMMdd" />
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
						</div>
						<c:set value="${status.count }" var="regNum" />
					</div>
				</c:forEach>
			</c:if>
			<c:forEach begin="1" end="${4-regNum }">
				<div class="w3-quarter w3-container w3-card w3-center"
					style="width:25%; height: 350px;">
					<h4 style="margin-top: 70%;">공고가 없습니다.</h4>
				</div>
			</c:forEach>
			</div>
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<p>
					<span class="w3-content w3-text-indigo w3-xlarge">전체 채용공고</span>
				</p>
			</td>
		</tr>
		
		<tr align="center" valign="middle" bordercolor="#212121">
				<th width="10%" height="26">기업명</th>
				<th width="43%" height="26">제목</th>
				<th width="13%" height="26">지원자격</th>
				<th width="8%">경력</th>
				<th width="6%" height="26">근무조건</th>
				<th width="9%" height="26">마감일</th>
				<th width="6%" height="26">마감상태</th>
			</tr>
			<c:forEach var="hireboard" items="${boardlist}" varStatus="status">
			<c:if test="${hireboard.hide==1}">
			<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.color='#1DDB16', this.style.border='2px solid'" onmouseout="this.style.color=''">
				<td>
						${hireboard.company}			
				</td>
				<td>
						<a href="hiredetail.jsy?hireno=${hireboard.hireno}&pageNum=${pageNum}">${hireboard.subject}</a>
				</td>
					<td align="center">${hireboard.qualification}</td>
					<td align="center">${hireboard.career} <br>${hireboard.careerdate}</td>
					<td align="center">${hireboard.hirestatus}</td>
					<td align="center">
					<fmt:formatDate value="${hireboard.deadline}" pattern="yyyy-MM-dd" var="end"/>
					${end}
					</td>
					<td>
						${datelist[status.index]} 일 전
					</td>
			</tr>
			</c:if>
			</c:forEach>
					<tr align="center" height="26">
				<td colspan="8">
					<c:if test="${pageNum >1}">
						<a href="javascript:hirelist(${pageNum -1})">[이전]</a>
					</c:if> &nbsp;
					<c:if test="${pageNum <= 1}">[이전]</c:if>&nbsp;
					<c:forEach var="a" begin="${startpage}" end = "${endpage}">
						<c:if test="${a == pageNum}">[${a}]</c:if>
						<c:if test="${a != pageNum}">
						<a href="javascript:hirelist(${a})">[${a}]</a>
						</c:if>
					</c:forEach>
					<c:if test="${pageNum < maxpage}">
						<a href="javascript:hirelist(${pageNum + 1})">[다음]</a>
					</c:if> &nbsp;
					<c:if test="${pageNum >= maxpage}">[다음]
					</c:if> &nbsp;
				</td>
			</tr>
			
				<c:if test="${listcount==0}">
			<tr>
				<td colspan="8">등록된 채용공고 게시물이 없습니다.</td>
			</tr>
		</c:if>
		<c:if test="${sessionScope.login.membergrade==0 || sessionScope.login.membergrade==2}">
			<tr>
				<td align="right" colspan="8">
					<button onclick="location.href='hirewrite.jsy'">글쓰기</button>
					<button style="width:140px; "onclick="window.open('companyDetailwrite.jsy')">기업세부정보 변경</button>
				</td>
			</tr>
		</c:if>
	</table>
</div>
</body>
</html>

<%-- <div name="aa">
<h6 class="region">지역</h6>
</div>
<div name="bb">
<h6  name="levelofedu" id="levelofedu">학력</h6>

</div>
<div name="cc">
<h6 id="fff">고용형태</h6>

</div>
<div name="cc">
<h6 id="carrarea">경력</h6>


</div>
<table width="90%" id="table" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="8" align="center">
	<form action="hirelist.jsy" method="post" name="searchform" onsubmit="return hirelist(1)">
		<input type="hidden" name="pageNum" value="1">
		<input type="hidden" name="popPageNum" value="1">
			<input type="text" name="searchRegion" id="searchRegion" value="${param.searchRegion}">
			<input type="text" name="searchEdu" value="${param.searchEdu}">
			<input type="text" name="searchCarr" value="${param.searchCarr}">
			<input type="text" name="searchCareer" value="${param.searchCareer }">
			<input type="text" name="searchCareerDate" value="${param.searchCareerDate}">
			<input type="submit" value="Search">
	</form>	
		</td>
	</tr>
	<tr>
		<td colspan="8" width="90%" height="100px" id="allchk">
				<div id="divchk">
				
				</div>
		</td>
	</tr>
	<tr>
		<td colspan="8">
			<h2>인기 공고</h2>
			<a href="calender.jsy">달력</a>
		</td>
	</tr>
	<tr>
		<td colspan="8">
			<table width="100%" id="table"  cellpadding="0" cellspacing="0">
				<tr align="center" valign="middle" border="#212121">
					<th width="10%" height="26">기업명</th>
			<th width="40%" height="26">제목</th>
			<th width="14%" height="26">지원자격</th>
			<th width="10%" height="26">경력</th>
			<th width="6%" height="26">근무조건</th>
			<th width="8%" height="26">작성일</th>
			<th width="8%" height="26">마감일</th>
			<th width="5%" height="26">마감상태</th>
				</tr>
				
				<c:forEach var="popBoard" items="${popBoardlist}" varStatus="status">
					<tr align="center" valign="middle" bordercolor="#333333" >
						<td>
							${popBoard.company}
						</td>
						<td>
						<a href="hiredetail.jsy?hireno=${popBoard.hireno}&pageNum=${pageNum}">${popBoard.subject}</a>
						</td>
						<td>
						${popBoard.qualification}
						</td>
						<td>
						${popBoard.career} ${popBoard.careerdate }
						</td>
						<td>
							${popBoard.hirestatus}
						</td>
						<td align="left">
					<fmt:formatDate value="${popBoard.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="left">
				<fmt:formatDate value="${popBoard.deadline}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="center">
					${popDatelist[status.index]} 일 전
				</td>
					</tr>
					</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="8">
			<h2>공고 전체</h2>
		</td>
	</tr>
	
	<tr align="center" valign="middle" bordercolor="#212121">
			<th width="10%" height="26">기업명</th>
			<th width="34" height="26">제목</th>
			<th width="14%" height="26">지원자격</th>
			<th width="10%">경력</th>
			<th width="6%" height="26">근무조건</th>
			<th width="8%" height="26">작성일</th>
			<th width="8%" height="26">마감일</th>
			<th width="5%" height="26">마감상태</th>
		</tr>
		<c:forEach var="hireboard" items="${boardlist}" varStatus="status">
		<c:if test="${hireboard.hide==1}">
		<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.color='#1DDB16', this.style.border='2px solid'" onmouseout="this.style.color=''">
			<td>
					${hireboard.company}			
			</td>
			<td>
					<a href="hiredetail.jsy?hireno=${hireboard.hireno}&pageNum=${pageNum}">${hireboard.subject}</a>
			</td>
				<td align="center">${hireboard.qualification}</td>
				<td align="center">${hireboard.career} <br>${hireboard.careerdate}</td>
				<td align="center">${hireboard.hirestatus}</td>
				<td align="left">
					<fmt:formatDate value="${hireboard.regdate}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="center">
				<fmt:formatDate value="${hireboard.deadline}" pattern="yyyy-MM-dd" var="end"/>
				${end}
				</td>
				<td>
					${datelist[status.index]} 일 전
				</td>
		</tr>
		</c:if>
		</c:forEach>
				<tr align="center" height="26">
			<td colspan="8">
				<c:if test="${pageNum >1}">
					<a href="javascript:hirelist(${pageNum -1})">PREV</a>
				</c:if> &nbsp;
				<c:if test="${pageNum <= 1}">PREV</c:if>&nbsp;
				<c:forEach var="a" begin="${startpage}" end = "${endpage}">
					<c:if test="${a == pageNum}">${a}</c:if>
					<c:if test="${a != pageNum}">
					<a href="javascript:hirelist(${a})">${a}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:hirelist(${pageNum + 1})">NEXT</a>
				</c:if> &nbsp;
				<c:if test="${pageNum >= maxpage}">NEXT
				</c:if> &nbsp;
			</td>
		</tr>
		
			<c:if test="${listcount==0}">
		<tr>
			<td colspan="8">등록된 채용공고 게시물이 없습니다.</td>
		</tr>
	</c:if>
		<tr>
		<td align="right" colspan="8">
			<a href="hirewrite.jsy">WRITE</a>
			<a href="companyDetailwrite.jsy">DETAIL WRITE</a>
		</td>
	</tr>
</table> --%>