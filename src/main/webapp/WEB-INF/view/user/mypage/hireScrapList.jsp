<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 마이페이지 > 스크랩 채용공고</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var checkarr = []
		var str = "";
		$('#selDelete').click(function(i) {
			event.preventDefault();
			checkarr = []
			$('input:checkbox[name="scrapchk"]:checked').each(function() {
				checkarr.push($(this).val());
			})

			str = checkarr.join(',');

			$.ajax({
				url : "../../hire/hireCheckScrapDelete.jsy",
				type : "POST",
				data : {
					"checkhireno" : str
				},
				success : function(data) {
					if (data.success == 'success') {
						alert("스크랩 해제를 성공하였습니다.");
						location.reload();
					}
				}
			})

		});
	})

	function hirelist(pageNum) {
		var searchType = document.searchform.searchType.value;

		if (searchType == null || searchType.length == 0) {
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "myhirelist.jsy?pageNum=" + pageNum;

		} else {
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
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
				<span class="w3-content w3-text-blue w3-xxlarge">스크랩 채용공고</span>
			</p>
		</div>
		<table class="w3-table w3-bordered">
			<tr>
				<th style="text-align:center">공고번호</th>
				<th style="text-align:center">회사명</th>
				<th style="text-align:center">제목</th>
				<th style="text-align:center">지원조건</th>
				<th style="text-align:center">고용상태</th>
				<th style="text-align:center">마감일</th>
				<th style="text-align:center">마감상태</th>
				<th style="text-align:center">항목체크</th>
			</tr>
			<c:if test="${scraphirecount >0 }">
				<c:forEach var="scraphire" items="${scraphirelist}"
					varStatus="status">
					<tr>
						<td style="text-align:center">${scraphire.hireno}</td>
						<td style="text-align:center">${scraphire.company}</td>
						<td style="text-align:left"><a
							href="../../hire/hiredetail.jsy?hireno=${scraphire.hireno}&pageNum=${pageNum}">${scraphire.subject}</a>
						</td>
						<td style="text-align:center">${scraphire.qualification}</td>
						<td style="text-align:center">${scraphire.hirestatus}</td>
						<td style="text-align:center"><fmt:formatDate value="${scraphire.deadline}"
								pattern="yyyy-MM-dd" /></td>
						<td style="text-align:center">${ datelist[status.index]}일 전</td>
						<td style="text-align:center"><input type="checkbox" class="scrchk"
							name="scrapchk" value="${scraphire.hireno}"></td>
						<td style="text-align:center"><a class="button" href="javascript:selectDelete(scrapchk)"
						id="selDelete">스크랩 해제</a></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${scraphirecount ==0 }">
				<tr>
					<td colspan="8" style="text-align: center">
						<p>해당 목록이 비어있습니다.</p>
					</td>
				</tr>
			</c:if>
			</table>
			<div class="w3-bar w3-center">
				<br>
				<c:if test="${pageNum > 1 }">
					<a href="javascript:hirelist(${pageNum -1})">[이전]</a>
				</c:if>
				&nbsp;
				<c:if test="${pageNum <=1 }">
						[이전]
				</c:if>
				&nbsp;
				<c:forEach var="a" begin="${startpage }" end="${endpage }">
					<c:if test="${a == pageNum }">[${a}]</c:if>
					<c:if test="${a != pageNum }">
						<a href="javascript:hirelist(${a})">[${a}]</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:hirelist(${pageNum + 1})">[다음]</a>
				</c:if>
				&nbsp;
				<c:if test="${pageNum >= maxpage }">[다음]</c:if>
				&nbsp;
			</div>
			<br>
			<form action="hireScrapList.jsy" method="post" name="searchform">
				<input type="hidden" name="pageNum" value="1"> 
				<input type="hidden" name="smkind" value="${smkind}"> 
				<span style="float: right"> 
					<select name="searchType" id="searchType">
						<option value="" disabled selected>선택하세요</option>
						<option value="company">기업명</option>
						<option value="subject">제목</option>
						<option value="memberid">아이디</option>
						<option value="region">지역</option>
					</select>&nbsp; 
					<script type="text/javascript">
						if ('${param.searchType}' != '') {
							document.getElementById("searchType").value = '${param.searchType}'
						}
					</script> 
					<input type="text" name="searchContent" value="${param.searchContent }"> 
					<input type="submit" class="button" value="검색">
				</span>
			</form>
	</div>
</body>
</html>