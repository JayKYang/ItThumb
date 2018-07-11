<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 포트폴리오 검색</title>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<script>
	function allchkbox(chk){
	    if(chk.getAttribute("ckecked") == null){
	        var chks = document.getElementsByName("idchks");
	        for(var i=0; i<chks.length; i++){
	      	  chks[i].checked = chk.checked;
	        }
	    }
	 }
	function list(pageNum) {
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0){
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "portfoliolist.jsy?pageNum="+pageNum;
		}else{
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
</script>
</head>
<body>
	<div class="w3-container" id="main">
  <form action="messagedelete.jsy" method="post">
  <input type="hidden" name="pageNum" value="${pageNum}"> 
  <input type="hidden" name="sort" value="${sort }">	
  <table class="w3-table w3-bordered">
    <tr>
      	<th>이름</th>
        <th>스킬</th>
        <th>포트폴리오 명</th>
        <th>최종수정일</th>
    </tr>
	    <c:forEach items="${portfoliolist }" var="portfolio">
	    <c:if test="${portfolio.createpf == 1 }">
	    <tr>
	      <td align="center">${portfolio.name}</td>
	      <td align="center">
	      <c:forEach items="${portfolio.historyList }" var="skill" varStatus="index">
	      	<c:if test="${skill.kindno == 1 }">
	      		${skill.content}
	      		 <c:if test="${!index.last }">, </c:if>
	      	</c:if>
	      </c:forEach>
	      </td>
	      <td><a href="myportfolio.jsy?id=${portfolio.memberid}&pageNum=${pageNum}">${portfolio.slogun }</a></td>
	      <td><fmt:formatDate value="${portfolio.modifydate }" type="both" pattern="yyyy-MM-dd"/></td>
	    </tr>
		</c:if>
	    </c:forEach>
  </table>
  </form>
  <div class="w3-bar w3-center">
			<c:if test="${pageNum > 1 }">
				<a href="javascript:list(${pageNum - 1})">[이전]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum <=1 }">
					[이전]
			</c:if>
			&nbsp;
			<c:forEach var="a" begin="${startpage }" end="${endpage }">
				<c:if test="${a == pageNum }">[${a}]</c:if>
				<c:if test="${a != pageNum }">
					<a href="javascript:list(${a},)">[${a}]</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:list(${pageNum + 1 })">[다음]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum >= maxpage }">[다음]</c:if>
			&nbsp;
	</div>
	<br>
	<form  action="portfoliolist.jsy" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1"> 
		<span style="float:right">
		<select name="searchType" id="searchType">
			<option value="" disabled selected>선택하세요</option>
			<option value="2">자격증</option>
			<option value="1">스킬</option>
		</select>>&nbsp;
		<script type="text/javascript">
			if('${param.searchType}' != ''){
				document.getElementById("searchType").value = '${param.searchType}'
			}
		</script>
		
		<input type="text" name="searchContent" value="${param.searchContent }">
		<input type="submit" value="검색">
		</span>
	</form>
</div>
</body>
</html>