<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt2" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<title>잇썸 > 채용공고 > 채용달력</title>
<head>
<link rel='stylesheet' type='text/css' href='http://www.blueb.co.kr/data/201010/IJ12872423858253/fullcalendar.css' />
<script type='text/javascript' src='http://www.blueb.co.kr/data/201010/IJ12872423858253/jquery.js'></script>
<script type='text/javascript' src='http://www.blueb.co.kr/data/201010/IJ12872423858253/jquery-ui-custom.js'></script>
<script type='text/javascript' src='http://www.blueb.co.kr/data/201010/IJ12872423858253/fullcalendar.min.js'></script>
<script type='text/javascript'>

	$(document).ready(function() {
	
		
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		$('#calendar').fullCalendar({
			defaultView: 'basicWeek',
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek,basicDay'
			},
			editable: true,
			events: [
				<c:forEach var="listhire" items="${hirelist}" varStatus="status">
				{
					title: '${deadlinelist[status.index]} ${listhire.subject}',
					start: '${datelist[status.index]}',
					url:'hiredetail.jsy?hireno=${listhire.hireno}&pageNum=${param.pageNum}'
				},
				</c:forEach>	 
			],
			 eventColor: '#FF0000'
		});
		
	});


	function getFormatDate(date){

		var year = date.getFullYear();                                 //yyyy

		var month = (1 + date.getMonth());                     //M

		month = month >= 10 ? month : '0' + month;     // month 두자리로 저장

		var day = date.getDate();                                        //d

		day = day >= 10 ? day : '0' + day;                            //day 두자리로 저장

		return  year + '-' + month + '-' + day;

	}
</script>
<style type='text/css'>

	body {
		margin-top: 40px;
		text-align: center;
		font-size: 14px;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		}

	#calendar {
		width: 900px;
		margin: 0 auto;
		}

button {
  border-radius: 4px;
  background-color: blue;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 15px;
  padding: 6px;
  width: 90px;
  height:30px;
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

#calenderlabel{
	font-size : 12pt;
	align : right;
	text-align : right;
}

#labelDiv{

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
	<label id="calenderlabel">게시글 : 마감날짜 공고제목형식</label>
<div id='calendar'>

<button class="w3-right" onclick="location.href='hirelist.jsy?pageNum=${param.pageNum}'">목록</button>
</div>
</div>
</body>
</html>


