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
$(document).ready(function(){
	
	$("#recognize").click(function(){
		$.ajax({
			url:"recognizeHire.jsy",
			type : "POST",
			data : {"hirelist":'${hirelist}'},
			success : function(data){
				if(data.success == 'success'){
					alert("승인이 완료되었습니다.");
				} else{
					alert("승인이 실패하였습니다.");
				}
			}
		});
	})
})

</script>
</head>
<body>
			<form modelAttribute="Hire" action="recognizeHire.jsy" method="post" name="f">
	<table border="1" width="90%">
		<tr>
			<th>회사명</th>
			<th>아이디</th>
			<th>제목</th>
			<th>내용</th>
			<th>승인여부</th>
			<th>승인하기</th>
		</tr>
		<c:forEach var="hirelist" items="${hirelist}">
		
	
			<tr>
					<td>
						${hirelist.company}
					</td>
				
				<td>
						${hirelist. memberid}
				</td>
				<td>
				<a href="../hire/hiredetail.jsy?hireno=${hirelist.hireno}&pageNum=${pageNum}" >${hirelist.subject}</a>
				</td>
				<td>
					${hirelist.content}
				</td>
				<td>
					<c:if test="${hirelist.hide==0}">
						<h6 style="color:#FF0000;">미승인</h6>
					</c:if>
					<c:if test="${hirelist.hide==1}">
						<h6 style="color:#0000FF;">승인 완료</h6>
					</c:if>
				</td>
				<td>
				<a id="recognize" class="w3-button w3-large" >승인</a>
				</td>
			</tr>
		</c:forEach>
	</table>
			</form>
</body>
</html>