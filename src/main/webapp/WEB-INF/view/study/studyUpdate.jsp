<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%
	//FileInputStream fi = new FileInputStream("C:/Users/user/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt"); 
	FileInputStream fi = new FileInputStream("C:/Users/Winhyoni/Desktop/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");							
	//FileInputStream fi = new FileInputStream("C:/Users/dumby/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");
	BufferedReader br = new BufferedReader(new InputStreamReader(fi,"UTF-8"));
	String line = null;
	br.readLine();
	Map<String, Set<String>> sidomap = new TreeMap<String, Set<String>>();
	while ((line = br.readLine()) != null) {
		try {
			String[] sido = line.split("\t");
			String[] si = sido[1].split(" ");
			Set<String> silist = sidomap.get(si[0]);
			if (silist == null) {
				silist = new TreeSet<String>();
			}
			silist.add(si[1]);
			sidomap.put(si[0], silist);
		} catch (ArrayIndexOutOfBoundsException e) {
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>study update</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
sies = new Array(
<c:forEach items="<%=sidomap%>" var="si">
		new Option("${si.key}"),
</c:forEach>	
);
	gues = new Array();
	<c:forEach items="<%=sidomap%>" var="si" varStatus="stat1">
	     gues[${stat1.index}] = new Array();
	     <c:forEach items="${si.value}" var="gu" varStatus="stat2">
	     	gues[${stat1.index}][${stat2.index}] = new Option("${gu}"),
	     </c:forEach>	
	</c:forEach>	
	//html 시작시 호출되는 함수 설정
	window.onload = function() {
		document.f.si.options[0] = new Option("선택하세요");
		document.f.gu.options[0] = new Option("선택하세요");
		for (i = 1; i <= sies.length; i++) {
			document.f.si.options[i] = sies[i-1];
		}
	}
	//f : form 객체를 저장
	function selectgu(f) {
		var opcnt = f.gu.options.length
		for (i = opcnt-1; i >= 0; i--) {
			f.gu.options[i] = null; //기존 Option 객체 제거
		}
		
		siidx = f.si.selectedIndex;
		
		document.f.gu.options[0] = new Option("선택하세요");
		for (i = 0; i < gues[siidx].length; i++) {
			document.f.gu.options[i+1] = gues[siidx-1][i];
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function() {

	var selday="${param.day}";
	if(selday!=null && !selday==""){
		$("#day").val(selday);	
	}
	
	$('input[name="region"]').val(null)
	
	$("#si").change(function(){
		var si = $("#si option:selected").val();
		if(si=="선택하세요"){
			si = "";
		}
		$('input[name="region"]').val(si);
	});
	
	$("#gu").change(function(){
		var si = $("#si option:selected").val();
		var gu = $("#gu option:selected").val();
		$('input[name="region"]').val(si+" "+gu);
	});
	
	$('input[name="day"]').click(function(){
      	var week = [];
      	$('input[name="weekday"]').val(null);
        $('input[name="day"]:checked').each(function(){
        	 week.push($(this).val());            
      	$('input[name="weekday"]').val(week);
        });
        
	});
	
	var daySplit = $('input[name="weekday"]').val().split(",");
	for(var idx in daySplit){
		$("input[name=day][value=" + daySplit[idx] + "]").attr("checked", true);
	}

})
</script>
<style>
.button {
	width: 100px;
	height: 40px;
}

.button {
	border-radius: 4px;
	background-color: #DC143C;
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
</style>
</head>

<body>
	<div class="w3-bar w3-small w3-left w3-pink" style="width: 100%;">
		<div style="width:115.39px; height:102px;" class="w3-bar-item w3-padding-large">
		</div> 
	</div>
<br>
<div id="main" class="w3-content">
<div class="w3-center" style="width: 100%">
			<p>
				<span class="w3-content w3-text-pink w3-xxlarge">스터디 수정</span>
			</p>
</div>
<br>
<div class="w3-center" style="margin-left: 300px">
<form:form modelAttribute="study" action="studyUpdate.jsy" method="post" name="f">
	<spring:hasBindErrors name="study">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<input type="hidden" name="pageNum" value="${pageNum}">
	<form:hidden path="studyno"/>
	<form:hidden path="memberid"/>
	<table>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">제 목</b>&nbsp;<font color="red"><form:errors path="studyname"/></font></td>
		</tr>
		<tr>
			<td ><form:input class="w3-input w3-border" path="studyname" size="50"/><br></td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">지 역</b>&nbsp;<font color="red"><form:errors path="region"/></font></td>
		</tr>
		<tr>
			<td>
				<select class="w3-select" name="si" id="si" onchange="selectgu(this.form)">
				</select>
				<select class="w3-select" name="gu" id="gu">
				</select>
        		<form:hidden path="region"/>
        		<br><br>
        	</td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">인 원 선 택</b>&nbsp;<font color="red"><form:errors path="limitmember"/></font></td>
		</tr>
		<tr>
			<td >
				
				<form:select class="w3-select" path="limitmember">
					<form:option value="">선택하세요</form:option>
					<form:option value="2">2</form:option>
					<form:option value="3">3</form:option>
					<form:option value="4">4</form:option>
					<form:option value="5">5</form:option>
					<form:option value="6">6</form:option>
					<form:option value="7">7</form:option>
					<form:option value="8">8</form:option>
					<form:option value="9">9</form:option>
					<form:option value="10">10</form:option>
					<form:option value="100">10명이상</form:option>
				</form:select>
				
				<br><br>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">요 일 선 택</b>&nbsp;<font color="red"><form:errors path="weekday"/></font></td>
		</tr>
		<tr>
			<td >
				<input class="w3-check" type="checkbox" name="day" value="월"><label>월</label>
				<input class="w3-check" type="checkbox" name="day" value="화"><label>화</label>
				<input class="w3-check" type="checkbox" name="day" value="수"><label>수</label>
				<input class="w3-check" type="checkbox" name="day" value="목"><label>목</label>
				<input class="w3-check" type="checkbox" name="day" value="금"><label>금</label>
				<input class="w3-check" type="checkbox" name="day" value="토"><label>토</label>
				<input class="w3-check" type="checkbox" name="day" value="일"><label>일</label>
				<input class="w3-check" type="checkbox" name="day" value="주5일"><label>주5일</label>
				<input class="w3-check" type="checkbox" name="day" value="주말"><label>주말</label>
				
				<form:hidden path="weekday"/>
				<br><br>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">시 작 시 간</b>&nbsp;<font color="red"><form:errors path="starttime"/></font></td>
		</tr>
		<tr>
			<td >
			<form:select class="w3-select" path="starttime">
					<form:option value="">선택하세요</form:option>
					<form:option value="오전12시">오전12시</form:option>
					<form:option value="오전1시">오전1시</form:option>
					<form:option value="오전2시">오전2시</form:option>
					<form:option value="오전3시">오전3시</form:option>
					<form:option value="오전4시">오전4시</form:option>
					<form:option value="오전5시">오전5시</form:option>
					<form:option value="오전6시">오전6시</form:option>
					<form:option value="오전7시">오전7시</form:option>
					<form:option value="오전8시">오전8시</form:option>
					<form:option value="오전9시">오전9시</form:option>
					<form:option value="오전10시">오전10시</form:option>
					<form:option value="오전11시">오전11시</form:option>
					<form:option value="오후12시">오후12시</form:option>
					<form:option value="오후1시">오후1시</form:option>
					<form:option value="오후2시">오후2시</form:option>
					<form:option value="오후3시">오후3시</form:option>
					<form:option value="오후4시">오후4시</form:option>
					<form:option value="오후5시">오후5시</form:option>
					<form:option value="오후6시">오후6시</form:option>
					<form:option value="오후7시">오후7시</form:option>
					<form:option value="오후8시">오후8시</form:option>
					<form:option value="오후9시">오후9시</form:option>
					<form:option value="오후10시">오후10시</form:option>
					<form:option value="오후11시">오후11시</form:option>
			</form:select>
			
			<br><br>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">끝나는 시간</b>&nbsp;<font color="red"><form:errors path="endtime"/></font></td>
		</tr>
		<tr>
			<td >
				<form:select class="w3-select" path="endtime">
					<form:option value="">선택하세요</form:option>
					<form:option value="오전12시">오전12시</form:option>
					<form:option value="오전1시">오전1시</form:option>
					<form:option value="오전2시">오전2시</form:option>
					<form:option value="오전3시">오전3시</form:option>
					<form:option value="오전4시">오전4시</form:option>
					<form:option value="오전5시">오전5시</form:option>
					<form:option value="오전6시">오전6시</form:option>
					<form:option value="오전7시">오전7시</form:option>
					<form:option value="오전8시">오전8시</form:option>
					<form:option value="오전9시">오전9시</form:option>
					<form:option value="오전10시">오전10시</form:option>
					<form:option value="오전11시">오전11시</form:option>
					<form:option value="오후12시">오후12시</form:option>
					<form:option value="오후1시">오후1시</form:option>
					<form:option value="오후2시">오후2시</form:option>
					<form:option value="오후3시">오후3시</form:option>
					<form:option value="오후4시">오후4시</form:option>
					<form:option value="오후5시">오후5시</form:option>
					<form:option value="오후6시">오후6시</form:option>
					<form:option value="오후7시">오후7시</form:option>
					<form:option value="오후8시">오후8시</form:option>
					<form:option value="오후9시">오후9시</form:option>
					<form:option value="오후10시">오후10시</form:option>
					<form:option value="오후11시">오후11시</form:option>
			</form:select>
			
			<br><br>
			</td>
		</tr>
		<tr>
			<td style="text-align: left;"><b style="font-size:25px;">내 용</b>&nbsp;<font color="red"><form:errors path="content"/></font></td>
		</tr>
		<tr>
			<td >
				<form:textarea class="w3-input w3-border" path="content" rows="20" cols="50"/>
				<br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" class="button" onclick="location.href='studyInfo.jsy?pageNum=${pageNum}&studyno=${study.studyno}'" value="취소">&nbsp;&nbsp;
				<input type="submit" class="button" value="수 정 하 기">
			</td>
		</tr>
	</table>
</form:form>
</div>
</div>
</body>
</html>