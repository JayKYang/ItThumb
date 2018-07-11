<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
function confirm(hireno){
	 var hireNum = hireno;
	 $.ajax({
			url : "recognizeHire.jsy",
			type : "POST",
			data : {"hireno": hireNum},
			success : function(data) {
				if(data.success=='success'){
				alert("승인이 처리되었습니다.");	
				$("#confirm_"+hireno).html('<h6 style="color:#0000FF;">승인 완료</h6>');
				$('button[value="'+hireno+'"]').hide();
				}
			}
		});
}

function deleteHire(hireno){
	
	var hireNum = hireno;
	$.ajax({
		url : "deleteHire.jsy",
		type : "POST",
		data : {"hireno" : hireNum},
		success : function(data){
			if(data.success=='success'){
			alert("삭제가 처리되었습니다.");
			var tr = $(hireno).parent().parent();
			tr.remove();
			 location.reload();
			}
		}
	})
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
</head>
<body>
	<table border="1" width="90%" align="center" >
		<tr>
			<th>회사명</th>
			<th>아이디</th>
			<th>제목</th>
			<th>신청일</th>
			<th>마감일</th>
			<th>승인여부</th>
			<th></th>
			<th>승인하기</th>
		</tr>
		<c:forEach var="hirelist" items="${hirelist}" varStatus="status">
			<tr id=" tr_${hirelist.hireno}">
					<td id="td_${hirelist.hireno}">
						${hirelist.company}
					</td>	
				<td>
						${hirelist. memberid}
				</td>
				<td>
				<a href="../hire/hiredetail.jsy?hireno=${hirelist.hireno}&pageNum=${pageNum}" >${hirelist.subject}</a>
				</td>
				<td>
				<fmt:formatDate value="${hirelist.regdate}" pattern="yyyy-MM-dd HH:mm:ss" /> 
				</td>
				<td>
					<fmt:formatDate value="${hirelist.deadline}" pattern="yyyy-MM-dd" /> 
				</td>
				
				<td id="confirm_${hirelist.hireno }">
					<c:if test="${hirelist.hide==0}">
						<h6 style="color:#FF0000;" >미승인</h6>
					</c:if>
					<c:if test="${hirelist.hide==1}">
						<h6 style="color:#0000FF;">승인 완료</h6>
					</c:if>
				</td>
				<td>
					<input type="checkbox" name="hirechks" value="${hirelist.memberid}">
				</td>
				<td>
				<c:if test="${hirelist.hide==0 }">
				<button value="${hirelist.hireno}"	class="hireBtn"  onclick="confirm('${hirelist.hireno}')">승인</button>
				</c:if>
				<button value="${hirelist.hireno}" onclick="deleteHire('${hirelist.hireno}')">삭제</button>
				</td>
			</tr>
		</c:forEach>
		
		<%-- 페이지 --%>
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
		
		
	</table>

</body>
</html>