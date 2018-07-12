<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ taglib prefix="fmt2" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<script type="text/javascript">
function myhirelist(pageNum){
	var searchType = document.searchform.searchType.value;
	
	if(searchType == null || searchType.length == 0){
		document.searchform.searchContent.value = "";
		document.searchform.pageNum.value = "1";
		location.href = "myhirelist.jsy?pageNum=" + pageNum;
		
	} else{
		document.searchform.pageNum.value = pageNum;
		document.searchform.submit();
		return true;
	}
	return false;
}

function hireDeleteAction(hireno){
	var hireNum = hireno;
	var conf;
	conf = confirm("해당 채용공고를 삭제하시겠습니까?");
	
	
	if(conf){
	
	$.ajax({
		url : "deleteAction.jsy",
		type : "POST",
		data : {"hireno":hireNum},
		success : function(data){
			if(data.success=='success'){
				alert("해당 채용공고를 삭제하였습니다.");
				location.reload();
			}
		}
	})
	} else {
		return;
	}
}
</script>
</head>
<body>
<h2>내가 쓴 채용공고 관리</h2>
	<table border="1" width="90%">
	<c:if test="${myhirecount >0 }">
		<tr>
			<th>공고번호</th>
			<th>회사명</th>
			<th>제목</th>
			<th>지원조건</th>
			<th>고용상태</th>
			<th>마감일</th>
			<th>마감상태</th>
			<th>공고상태</th>
			<th>항목체크</th>
			
		</tr>
		<c:forEach var="myhire"  items="${myhirelist}" varStatus ="status">	
		<tr>
			<td align="center">
				${myhire.hireno}
			</td>
			<td>
				${myhire.company}
			</td>
			<td>
			<a href="hiredetail.jsy?hireno=${myhire.hireno}&pageNum=${pageNum}">${myhire.subject}</a>
			</td>
			<td>
				${myhire.qualification}
			</td>
			<td>
				${myhire.hirestatus}
			</td>
			<td>
			<fmt:formatDate value="${myhire.deadline}" pattern="yyyy-MM-dd" /> 
			</td>
			<td align="center">
				${ datelist[status.index]}일 전
			</td>
			<td align="center">
				<c:if test="${myhire.hide==0}">
					<h6 style="color:#FF0000;">미승인</h6>
				</c:if>
				<c:if test="${myhire.hide==1}">
					<h6 style="color:#0000FF;">승인 완료</h6>
				</c:if>
			</td>
			<td align="center">
			<a href="supUpdateHireForm.jsy?hireno=${myhire.hireno}&pageNum=${pageNum}" id="updateBtn">수정</a>
			<a href="javascript:hireDeleteAction('${myhire.hireno}')" name="deleteBtn" value="${myhire.hireno}">삭제</a>
			</td> 
		</tr>			
		</c:forEach>
				<tr>
			<td colspan="9" align="right">
			<form action="myhirelist.jsy" method="post" name="searchform">
				<input type="hidden" name="pageNum" value="1">  
				<select name="searchType" id="searchType">
					<option value="" disabled selected>선택하세요</option>
					<option value="company">기업명</option>
					<option value="subject">제목</option>
					<option value="memberid">아이디</option>
					<option value="region">지역</option>
				</select>
				<script type="text/javascript">
				if ('${param.searchType}' != '') {
					document.getElementById("searchType").value = '${param.searchType}'
				}
				</script>
				<input type="text" name="searchContent" value="${param.searchContent}">
				<input type="submit" value="찾기">
			</form>
			</td>
		</tr>
					<tr align="center" height="26">
			<td colspan="9">
				<c:if test="${pageNum >1}">
					<a href="javascript:myhirelist(${pageNum -1})">PREV</a>
				</c:if> &nbsp;
				<c:if test="${pageNum <= 1}">PREV</c:if>&nbsp;
				<c:forEach var="a" begin="${startpage}" end = "${endpage}">
					<c:if test="${a == pageNum}">${a}</c:if>
					<c:if test="${a != pageNum}">
					<a href="javascript:myhirelist(${a})">${a}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:myhirelist(${pageNum + 1})">NEXT</a>
				</c:if> &nbsp;
				<c:if test="${pageNum >= maxpage}">NEXT
				</c:if> &nbsp;
			</td>
		</tr>
	</c:if>
			<c:if test="${myhirecount ==0 }">
				<tr>
					<td>
						<h2>해당 목록이 비어있습니다.</h2>
					</td>
				</tr>
			</c:if>
</table>
</body>
</html>