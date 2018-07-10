<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function allchkbox(chk){
			var chks = document.getElementsByName("idchks");
			for(var i=0; i<chks.length; i++){
				chks[i].checked = chk.checked;
		}
	}
</script>
</head>
<body>
<form action="mailForm.shop" method="post">
	<table border="1" cellspacing="0" cellpadding ="0" width="100%">
		<tr>
			<td colspan="7" align="center">
				회원목록
			</td>
		</tr>
		<tr>
			<td>
					<a href="admin.jsy">전체</a>
					<a href="admin.jsy?membergrade=1">일반 사용자</a>&nbsp;&nbsp;
					<a href="admin.jsy?membergrade=2">기업 사용자</a>
			</td>
		</tr>
		<tr>
			<td>E-mail</td><td>Name</td><td>Tel</td><td>Birthday</td><td>Address</td> 
			<td>&nbsp;</td><!--<td><input type="checkbox" name="allchk" onchange="allchkbox(this)"></td>  -->
		</tr>
		<c:forEach items="${userlist}" var="userlist">
			<tr>
				<td>
				${userlist.memberid}
				</td>
				<td>${userlist.name}</td><td>${userlist.tel}</td>
				<td><fmt:formatDate value="${userlist.birth}" pattern="yyyy-MM-dd" /></td><td>${userlist.address}</td>
				<td><a href="../user/update.shop?id=${userlist.memberid}">수정</a>
					<c:if test="${userlist.memberid != 'admin@admin.com' }">
						<a href="../user/delete.shop?id=${userlist.memberid}">삭제</a>
					</c:if>
						<a href="../user/mypage.shop?id=${userlist.memberid}">회원정보</a></td><%-- 
				<td><input type="checkbox" name="idchks" value="${userlist.memberid}"></td> --%>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="7" align="center">
			<a class="w3-bar-item w3-button w3-hover-gray" href="superviseHire.jsy">채용신청관리</a>
			</td>
		</tr>
	</table>
</form>
</body>
</html>