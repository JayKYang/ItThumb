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
	

	
	
	
		
	if($('input[name="searchRegion"]').val() != null){
		var str = $('input[name="searchRegion"]').val()
		var array = []
		array = str.split(",");
		
		for(var i=0; i<array.length; i++){
			
			$('input:checkbox[value="'+array[i]+'"]').prop("checked", true);
			$('input:checkbox[value="'+array[i]+'"]').attr('checked', 'checked');

			
		}
		
		
	}
	
	if($('input[name="searchEdu"]').val() != null){
		var str = $('input[name="searchEdu"]').val()
		$('input:radio[value="'+str+'"]').prop("checked", true);
		$('input:radio[value="'+str+'"]').attr('checked', 'checked');
		
	}
	
	if($('input[name="searchCarr"]').val() != null){
		var str = $('input[name="searchCarr"]').val()
		var array = []
		array = str.split(",");
		
		for(var i=0; i<array.length; i++){
			
			$('input:checkbox[value="'+array[i]+'"]').prop("checked", true);
			$('input:checkbox[value="'+array[i]+'"]').attr('checked', 'checked');
			
		}
	}
	
	if($('input[name="searchCareer"]').val() != null){
		var str = $('input[name="searchCareer"]').val()
		var array = []
		array = str.split(",");
		
		for(var i=0; i<array.length; i++){
			
			$('input:checkbox[value="'+array[i]+'"]').prop("checked", true);
			$('input:checkbox[value="'+array[i]+'"]').attr('checked', 'checked');
			
		}
	}

	if($('input[name="searchCareerDate"]').val() != null){
		var str = $('input[name="searchCareerDate"]').val()
		$('select[name=inputCareerDate]').val(str).prop("selected", true);
		$("select[name=inputCareerDate]").attr("disabled",false);
		
	} else {
		$("select[name=inputCareerDate]").attr("disabled",true);
	}
	
	
	
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
	}) 
	
	
	
	$("#radiochkdelete").click(function(){
		event.preventDefault();
		var str = $('input[name="searchEdu"]').val();
		$('input:radio[value="'+str+'"]').prop("checked", false);
		$('input:radio[value="'+str+'"]').attr('checked', 'unchecked');
		$('input[name="searchEdu"]').val(null);
		 var i =0;
	       for(i=0;i<idx;i++) {
			         if($(this).val() == divchkarr[i]) {
			        
				         divchkarr.splice(i,1);
				         idx--;
				         break;
					}
				}
	})

	
	
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
	
	
	console.log(searchRegion);
	console.log(searchEdu);
	console.log(searchCareer);
	console.log(searchCareerDate);
	
	
	 
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
<script>

function companyDetail(url){
	var h = screen.height*(3/4);
	var w = screen.width*(1.9/3);
	window.open(url,"Company Infomation","width="+w+", height="+h+", left=100, top=100");
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
<div class="w3-bar w3-small w3-left w3-indigo" style="width: 100%;">
		<div style="width:115.39px; height:102px;" class="w3-bar-item w3-padding-large">
		</div> 
</div>
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
						<input type="hidden" name="searchCareer" value="${param.searchCareer}">
						<input type="hidden" name="searchCareerDate" value="${param.searchCareerDate}">
					</td>
				</tr>
				<tr>
					<td colspan="8" width="90%" height="100px" id="allchk">
							<div id="divchk"></div>
					</td>
				</tr>
				<tr><td><button class="w3-right" onclick="javascript:document.searchform.submit()" >조회하기</button></td></tr>
			</table>
		</form>	
	</div>
	<table class="w3-table">
		<tr>
			<td colspan="8">
				<p>
					<span class="w3-content w3-text-indigo w3-xlarge">인기공고</span>
				</p>
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<jsp:useBean id="now" class="java.util.Date" />
		<fmt:formatDate value="${now}" var="now" pattern="yyyyMMdd" />
		<div class="w3-row-padding">
			<c:if test="${!empty popBoardlist}">
				<c:forEach var="popBoard" items="${popBoardlist}" varStatus="status">
					<div
						class="w3-quarter w3-container w3-card w3-center w3-padding-16"
						style="width:25%; height: 350px;">
						<div style="height:100px;">
							<img src="../photo/${popBoard.user.imageUrl }" style="width: 60%; height:100%;">
						</div>
						<div>
							<h4>
								<a href="javascript:companyDetail('companyDetail.jsy?hireno=${popBoard.hireno}&pageNum=1')" style="text-decoration:none; font-size:20px;"><b>${popBoard.company }</b></a>
							</h4>
						</div>
						<div>
							<h6><a href="hiredetail.jsy?hireno=${popBoard.hireno }" style="text-decoration:none; font-size:12px;">${popBoard.subject }</a></h6>
						</div>
						<div>
							<div>
							<fmt:formatDate value="${popBoard.deadline}" var="date"	pattern="yyyyMMdd" />
							<c:if test="${popDatelist[status.index] >= 0 }">
								<p>마감 ${popDatelist[status.index]} 일 전</p>
								<c:if test="${popDatelist[status.index] < 3 }">
									<a class="w3-text-red w3-tag">마감 임박</a>
								</c:if>
							</c:if>
							<c:if test="${popDatelist[status.index] <= 0 }">
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
					<a href="calender.jsy?pageNum=${param.pageNum}">달력</a>
				</p>
			</td>
		</tr>
		
		<tr align="center" valign="middle" bordercolor="#212121">
				<th width="12%" height="26">기업명</th>
				<th width="39%" height="26">제목</th>
				<th width="9%" height="26">지원자격</th>
				<th width="8%">경력</th>
				<th width="9%" height="26">근무조건</th>
				<th width="9%" height="26">마감일</th>
				<th width="9%" height="26">마감상태</th>
			</tr>
			<c:if test="${empty boardlist}">
				<tr>
					<td colspan="8" style="text-align: center">등록된 채용공고 게시물이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="hireboard" items="${boardlist}" varStatus="status">
			<c:if test="${hireboard.hide==1}">
			<tr>
				<td>
					<a href="javascript:companyDetail('companyDetail.jsy?hireno=${hireboard.hireno}&pageNum=1')" style="text-decoration:none;">${hireboard.company }</a>
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
	</table>
	<table class="w3-center" style="width:100%">
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
	</table>
</div>
</body>
</html>