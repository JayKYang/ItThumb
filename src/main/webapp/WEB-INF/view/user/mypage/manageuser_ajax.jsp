<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<input type="hidden" name="membergrade" value="${membergrade }">
<input type="hidden" name="pageNum" value="${pageNum }">
<table class="w3-table w3-bordered">
	<tr>
		<th>번호</th>
		<th>아이디</th>
		<th>이름</th>
		<th>강제탈퇴</th>
		<th>승인</th>
	</tr>
	<c:forEach items="${userlist }" var="user" varStatus="status">
		<tr>
			<td>${status.count }</td>
			<td>${user.memberid }</td>
			<td>${user.name }</td>
			<td><button onclick="location.href='../delete.jsy?id=${user.memberid}'">강제탈퇴</button></td>
			<td><c:if test="${user.locking == 0 }">
					<button
						onclick="location.href='confirmuser.jsy?id=${user.memberid}'">승인</button>
				</c:if></td>
		</tr>
	</c:forEach>
</table>
<div class="w3-bar w3-center">
	<c:if test="${pageNum > 1 }">
		<a href="javascript:managemem(${sessionScope.login.membergrade},${pageNum - 1})">[이전]</a>
	</c:if>
	&nbsp;
	<c:if test="${pageNum <=1 }">
		[이전]
	</c:if>
	&nbsp;
	<c:forEach var="a" begin="${startpage }" end="${endpage }">
		<c:if test="${a == pageNum }">[${a}]</c:if>
		<c:if test="${a != pageNum }">
			<a
				href="javascript:managemem(${sessionScope.login.membergrade},${a})">[${a}]</a>
		</c:if>
	</c:forEach>
	<c:if test="${pageNum < maxpage}">
		<a
			href="javascript:managemem(${sessionScope.login.membergrade},${pageNum + 1 })">[다음]</a>
	</c:if>
	&nbsp;
	<c:if test="${pageNum >= maxpage }">[다음]</c:if>
	&nbsp; <br>
</div>
<div class="wA3-bar w3-center">
	<form action="manageuser.jsy" method="post" name="searchform">
		<input type="hidden" name="pageNum" value="1"> <span
			style="float: right"> <select name="searchType"
			id="searchType">
				<option value="" disabled selected>선택하세요</option>
				<option value="memberid">아이디</option>
				<option value="name">이름</option>
		</select>&nbsp; <script type="text/javascript">
			if ('${param.searchType}' != '') {
				document.getElementById("searchType").value = '${param.searchType}'
			}
		</script> <input type="text" name="searchContent"
			value="${param.searchContent }"> <input type="submit"
			value="검색">
		</span>
	</form>
</div>
</html>
