<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%

	FileInputStream fi = new FileInputStream("C:/Users/user/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt"); 
	/* FileInputStream fi = new FileInputStream("C:/Users/Winhyoni/Desktop/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");	 */									
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
<title>study write</title>
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
	
	/* $("#limitmember").change(function(){
		
		var limitmember = $("#limitmember option:selected").val();
		$('input[name="limitmember"]').val(limitmember);
	})
	$("#starttime").change(function(){
		
		var starttime = $("#starttime option:selected").val();
		$('input[name="starttime"]').val(starttime);
	})
	$("#endtime").change(function(){
		
		var endtime = $("#endtime option:selected").val();
		$('input[name="endtime"]').val(endtime);
	}) */
	
})
</script>
</head>

<body>
<form:form modelAttribute="study" action="studyWrite.jsy" method="post" name="f">
	<spring:hasBindErrors name="study">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table>
		<tr>
			<td><b>제 목</b></td>
		</tr>
		<tr>
			<td ><form:input path="studyname" size="50"/><font color="red"><form:errors path="studyname"/></font></td>
		</tr>
		<tr>
			<td><b>지 역</b></td>
		</tr>
		<tr>
			<td>
				<select name="si" id="si" onchange="selectgu(this.form)">
				</select>
				<select name="gu" id="gu">
				</select>
        		<form:hidden path="region"/><font color="red"><form:errors path="region"/></font>
        	</td>
		</tr>
		<tr>
			<td ><b>인 원 선 택</b></td>
		</tr>
		<tr>
			<td >
				
				<form:select path="limitmember">
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
				<font color="red"><form:errors path="limitmember"/></font>
			</td>
		</tr>
		<tr>
			<td ><b>요 일 선 택</b></td>
		</tr>
		<tr>
			<td >
				<input type="checkbox" name="day" value="월">월
				<input type="checkbox" name="day" value="화">화
				<input type="checkbox" name="day" value="수">수
				<input type="checkbox" name="day" value="목">목
				<input type="checkbox" name="day" value="금">금
				<input type="checkbox" name="day" value="토">토
				<input type="checkbox" name="day" value="일">일
				<input type="checkbox" name="day" value="주5일">주5일
				<input type="checkbox" name="day" value="주말">주말
				
				<form:hidden path="weekday"/><font color="red"><form:errors path="weekday"/></font>
			</td>
		</tr>
		<tr>
			<td ><b>시 작 시 간</b></td>
		</tr>
		<tr>
			<td >
			<form:select path="starttime">
					<form:option value="">선택하세요</form:option>
					<form:option value="오후12시">오후12시</form:option>
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
					<form:option value="오전12시">오전12시</form:option>
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
			<font color="red"><form:errors path="starttime"/></font>
			</td>
		</tr>
		<tr>
			<td ><b>끝나는 시간</b></td>
		</tr>
		<tr>
			<td >
				<form:select path="endtime">
					<form:option value="">선택하세요</form:option>
					<form:option value="오후12시">오후12시</form:option>
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
					<form:option value="오전12시">오전12시</form:option>
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
			<font color="red"><form:errors path="endtime"/></font>
			</td>
		</tr>
		<tr>
			<td ><b>내 용</b></td>
		</tr>
		<tr>
			<td >
				<form:textarea path="content" rows="20" cols="50"/><font color="red"><form:errors path="content"/></font>
			</td>
		</tr>
		<tr>
			<td><input type="submit" value="등 록 하 기"></td>
		</tr>
	</table>
</form:form>
</body>
</html>