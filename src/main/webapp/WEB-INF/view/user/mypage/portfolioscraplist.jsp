<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 마이페이지 > 스크랩 포트폴리오</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<style>
	.button{
		width:50px;
		height:30px;
	}
   	.button {
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
	<div class="w3-content">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-blue w3-xxlarge">스크랩 포트폴리오</span>
			</p>
		</div>
		<input type="hidden" name="pageNum" value="${pageNum}">
		<table class="w3-table w3-bordered" style="margin: auto;">
			<tr>
				<th width="15%" style="text-align: center">사진</th>
				<th width="15%" style="text-align: center">아이디</th>
				<th width="15%" style="text-align: center">이름</th>
				<th width="15%" style="text-align: center">포트폴리오명</th>
				<th width="5%" style="text-align: center">지역</th>
				<th width="10%" style="text-align: center">최종수정일</th>
				<th width="15%"></th>
			</tr>
			<c:if test="${empty scrapmemberlist }">
				<tr>
					<td colspan="7" style="text-align: center">스크랩 목록이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${scrapmemberlist}" var="scrap">
				<tr>
					<td style="text-align:center;"><c:if test="${!empty scrap.imageUrl }">
							<img src="../../photo/${scrap.imageUrl }" style="width:50px;height:50px;">
						</c:if> <c:if test="${empty scrap.imageUrl }" >
							<img src="../../photo/defaultphoto.png" style="width:50px;height:50px;">
						</c:if></td>
					
					<td style="text-align:center; "><p>${scrap.memberid }</p></td>
					
					<td style="text-align:center;"><p>${scrap.name }</p></td>
					<td style="text-align:center; "><p>${scrap.slogun }</p></td>
					<td style="text-align:center; "><p>${scrap.address }</</td>
					<td style="text-align:center; "><p><fmt:formatDate value="${scrap.modifydate}" type="both"
							pattern="yyyy-MM-dd" /></p></td>
					<td style="text-align:center; "><a
						href="../portfolio/myportfolio.jsy?id=${scrap.memberid}"><i	class="fa fa-eye w3-button w3-xlarge"></i></a> <a
						onclick="javascript:message_open('../../message/messageWrite.jsy?memberid=${scrap.memberid}')">
							<i class="fa fa-commenting w3-button w3-xlarge"></i>
					</a></td>
				</tr>
			</c:forEach>
		</table>
		
		<div class="w3-bar w3-center">
			<br>
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
		<div class="w3-bar w3-center">
			<form action="portfolioscraplist.jsy" method="post" name="searchform">
				<input type="hidden" name="pageNum" value="1"> <span
					style="float: right"> <select name="searchType"
					id="searchType">
						<option value="" disabled selected>선택하세요</option>
						<option value="a.memberid">아이디</option>
						<option value="name">이름</option>
						<option value="address">지역</option>
						<option value="slogun">포트폴리오명</option>
				</select>&nbsp; <script type="text/javascript">
					if ('${param.searchType}' != '') {
						document.getElementById("searchType").value = '${param.searchType}';
					}
				</script> <input type="text" name="searchContent"
					value="${param.searchContent }"> <input type="submit" class="button"
					value="검색">
				</span>
			</form>
		</div>
	</div>
</body>
</html>