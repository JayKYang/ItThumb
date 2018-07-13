<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지 > 회원 관리</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
	function managemem(membergrade, pageNum) {
		$.ajax({
			url : "manageuser_ajax.jsy",
			type : "POST",
			data : {
				"membergrade" : membergrade,
				"id" : '${sessionScope.login.memberid}',
				"pageNum" : pageNum
			},
			success : function(html) {
				//console.log(html);
				$("#managememberdiv").html(html);
			},
			error : function(request, status, error) {
			}
		});
	}
</script>
<style>
	button{
		width:100px;
		height:5px;
	}
   	button {
	  border-radius: 4px;
	  background-color: skyblue;
	  border: none;
	  color: #FFFFFF;
	  text-align: center;
	  font-size: 15px;
	  padding: 20px;
	  transition: all 0.5s;
	  cursor: pointer;
	}
	button:hover {
	  background-color: pink;
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
</head>
<body>
	<div class="w3-content">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-purple w3-xxlarge">회원 관리</span>
			</p>
		</div>
		<table class="w3-table w3-bordered">
			<tr>
				<td>
					<a href="javascript:managemem(0,1)">전체</a>&nbsp;&nbsp; 
					<a href="javascript:managemem(1,1)">일반 사용자</a>&nbsp;&nbsp; 
					<a href="javascript:managemem(2,1)">기업 사용자</a>
				</td>
			</tr>
		</table>
		<div id="managememberdiv">
			<input type="hidden" name="pageNum" value="${pageNum}"> 
			<input type="hidden" name="membergrade" value="${membergrade}">
			<table class="w3-table w3-bordered">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>강제탈퇴</th>
					<th>승인</th>
				</tr>
				<c:if test="${empty userlist }">
					<tr>
						<td colspan="4">목록이 존재하지 않습니다.</td>
					</tr>
				</c:if>
				<c:forEach items="${userlist }" var="user" varStatus="status">
					<tr>
						<td>${status.count }</td>
						<td>${user.memberid }</td>
						<td>${user.name }</td>
						<td><button onclick="location.href='../delete.jsy?id=${user.memberid}'">강제탈퇴</button></td>
						<td><c:if test="${user.locking == 0 }">
								<button	onclick="location.href='confirmuser.jsy?id=${user.memberid}'">승인</button>
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
						<a href="javascript:managemem(${sessionScope.login.membergrade},${a})">[${a}]</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:managemem(${sessionScope.login.membergrade},${pageNum + 1 })">[다음]</a>
				</c:if>
				&nbsp;
				<c:if test="${pageNum >= maxpage }">[다음]</c:if>
				&nbsp; <br>
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
				<br>
			</div>
		</div>
	</div>
</body>
</html>