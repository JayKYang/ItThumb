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
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,basicWeek,basicDay'
			},
			editable: true,
			events: [
				<c:forEach var="listhire" items="${hirelist}" varStatus="status">
				{
					title: '${listhire.subject}',
					start: '${datelist[status.index]}',
					url:'hiredetail.jsy?hireno=${listhire.hireno}'
				},
				</c:forEach>
			]
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

</style>
</head>
<body>
<div id='calendar'>

</div>
</body>
</html>


