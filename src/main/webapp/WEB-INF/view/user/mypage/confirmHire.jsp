<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지 > 채용공고 승인</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
	button{
		width:60px;
		height:30px;
	}
   	button {
	  border-radius: 4px;
	  background-color: skyblue;
	  border: none;
	  color: #FFFFFF;
	  text-align: center;
	  font-size: 18px;
	  padding: 5px;
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
				<span class="w3-content w3-text-purple w3-xxlarge">채용공고 승인</span>
			</p>
		</div>
		<div class="w3-container w3-padding-32">
			<div id="confirmhirelist" class="mypage" style="width:90%">
				<table class="w3-table w3-bordered">
					<tr>
						<td><a href="confirmHire.jsy">전체</a>&nbsp;&nbsp; <a
							href="confirmHire.jsy?hide=0">미승인처리</a></td>
					</tr>
				</table>
				<div id="hirediv">
					<input type="hidden" name="pageNum" value="${pageNum}">

					<table>
						<tr>
							<th>글번호</th>
							<th>아이디</th>
							<th>기업명</th>
							<th>채용글</th>
							<th>등록일</th>
							<th>마감일</th>
							<th></th>
						</tr>
						<c:if test="${empty hirelist }">
							<tr>
								<td colspan="7">목록이 존재하지 않습니다.</td>
							</tr>
						</c:if>
						<c:forEach items="${hirelist }" var="hire" varStatus="status">
							<tr>
								<td>${hire.hireno }</td>
								<td>${hire.memberid }</td>
								<td>${hire.company }</td>
								<td><a
									href="../../hire/hiredetail.jsy?hireno=${hire.hireno}">${hire.subject }</a></td>
								<td>${hire.regdate }</td>
								<td>${hire.deadline }</td>
								<c:if test="${hire.hide == 0}">
								<td><div class="w3-tag w3-round w3-red" style="padding:3px; width:75px;">
									<div class="w3-tag w3-round w3-red w3-border w3-border-white" style="width:70px;">
										<font style="color: white;">승인대기</font>
									</div>
								</div></td>
								<td><button	onclick="location.href='recognizeHire.jsy?hireno=${hire.hireno}'">승인</button></td>
								</c:if>
								<c:if test="${hire.hide != 0 }">
								<td>
								<div class="w3-tag w3-round w3-indigo" style="padding:3px; width:75px;">
									<div class="w3-tag w3-round w3-indigo w3-border w3-border-white" style="width:70px;">
										<font style="color: white;">승인완료</font>
									</div>
								</div>
								</td>
								<td></td>
								</c:if>
							</tr>
						</c:forEach>
					</table>
					<div class="w3-bar w3-center">
						<c:if test="${pageNum > 1 }">
							<a href="javascript:managemem(${membergrade},${pageNum - 1})">[이전]</a>
						</c:if>
						&nbsp;
						<c:if test="${pageNum <=1 }">
							[이전]
					</c:if>
						&nbsp;
						<c:forEach var="a" begin="${startpage }" end="${endpage }">
							<c:if test="${a == pageNum }">[${a}]</c:if>
							<c:if test="${a != pageNum }">
								<a href="javascript:managemem(${membergrade},${a})">[${a}]</a>
							</c:if>
						</c:forEach>
						<c:if test="${pageNum < maxpage}">
							<a href="javascript:managemem(${membergrade},${pageNum + 1 })">[다음]</a>
						</c:if>
						&nbsp;
						<c:if test="${pageNum >= maxpage }">[다음]</c:if>
						&nbsp; <br>

					</div>
				</div>
				<div class="wA3-bar w3-center">
					<form action="confirmHire.jsy" method="post" name="searchform">
						<input type="hidden" name="pageNum" value="1"> <span
							style="float: right"> <select name="searchType"
							id="searchType">
								<option value="" disabled selected>선택하세요</option>
								<option value="company">기업명</option>
								<option value="memberid">아이디</option>
						</select>&nbsp; <script type="text/javascript">
							if ('${param.searchType}' != '') {
								document.getElementById("searchType").value = '${param.searchType}'
							}
						</script> <input type="text" name="searchContent"
							value="${param.searchContent}"> <input type="submit"
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