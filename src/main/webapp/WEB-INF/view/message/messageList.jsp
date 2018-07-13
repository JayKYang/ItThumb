<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>message</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.w3-sidebar {width: 120px;background: #222;}
#main {margin-left: 120px}
</style>
<body>
<script type="text/javascript">
	function list(pageNum,sort) {
		var searchType = document.searchform.searchType.value;
		if(searchType == null || searchType.length == 0){
			document.searchform.searchContent.value = "";
			document.searchform.pageNum.value = "1";
			location.href = "messageList.jsy?pageNum="+pageNum+"&sort="+sort;
		}else{
			document.searchform.pageNum.value = pageNum;
			document.searchform.submit();
			return true;
		}
		return false;
	}
	function allchkbox(chk){
	      if(chk.getAttribute("ckecked") == null){
	          var chks = document.getElementsByName("idchks");
	          for(var i=0; i<chks.length; i++){
	        	  chks[i].checked = chk.checked;
	          }
	      }
	   }
</script>
<!-- Icon Bar (Sidebar - hidden on small screens) -->
<nav class="w3-sidebar w3-bar-block w3-small w3-center">
  <a href="messageList.jsy?sort=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">받은 쪽지함</p>
  </a>
  <a href="messageList.jsy?sort=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">보낸 쪽지함</p>
  </a>
  <a href="messageWrite.jsy" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">쪽지 보내기</p>
  </a>
</nav>
<div class="w3-container" id="main">

  	<c:if test="${sort.equals('1')}">
		<h2>받은 쪽지함</h2>
	</c:if>
	<c:if test="${sort.equals('2')}">
		<h2>보낸 쪽지함</h2>
	</c:if>  
	
  <form action="messagedelete.jsy" method="post">
  <input type="hidden" name="pageNum" value="${pageNum}"> 
  <input type="hidden" name="sort" value="${sort }">
  
  <table class="w3-table w3-bordered">
    <tr>
      	<th>순서</th>
        <th>제목</th>
        <th>날짜</th>
        <th>열람여부</th>
        <th><input type="checkbox" name="allchk" onchange="allchkbox(this)">&nbsp;<input type="submit" value="삭제"></th>
    </tr>
    <c:if test="${empty messagelist}">
 	   <tr>
			<td colspan="5">
			
					<c:if test="${sort==1}">
						받은 쪽지가 없습니다.
					</c:if>
					<c:if test="${sort==2}">
						보낸 쪽지가 없습니다.
					</c:if>
			</td>
		</tr>
	</c:if>
    <c:forEach var="mes" items="${messagelist }">
    <c:if test="${sort==1}">
    	 <c:set var="receiver" value="${mes.receiver}"></c:set>
    </c:if>
    <c:if test="${sort==2}">
    	 <c:set var="sender" value="${mes.sender}"></c:set>
    </c:if>
    <tr>
      <td align="center">${sendmesnum}</td>
      <c:set var="sendmesnum" value="${sendmesnum - 1 }"></c:set>
      <c:set var="subjectText" value="${mes.subject}"/>
      <td align="center"><a href="messageInfo.jsy?sort=${sort}&messageno=${mes.messageno}&pageNum=${pageNum}">${fn:substring(subjectText, 0, 10)}<c:if test="${fn:length(subjectText)>10}">...</c:if></a></td>
      <fmt:formatDate value="${mes.senddate}" pattern="yyyy-MM-dd" var="regnow"/>
      <td align="center">${regnow}</td>
      <c:if test="${mes.confirm==0}">
      		<td align="center">X</td>
      </c:if>
      <c:if test="${mes.confirm==1}">
      		<td align="center">O</td>
      </c:if>
      <td><input type="checkbox" name="idchks" value="${mes.messageno}"></td>
    </tr>
    </c:forEach>
  </table>
  
  <c:if test="${sort==1}">
  	<input type="hidden" name="id" value="${receiver}">
  </c:if>
  <c:if test="${sort==2}">
    <input type="hidden" name="id" value="${sender}">
  </c:if>
  
  </form>
  
  <div class="w3-bar w3-center">
			<c:if test="${pageNum > 1 }">
				<a href="javascript:list(${pageNum - 1},${sort })">[이전]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum <=1 }">
					[이전]
			</c:if>
			&nbsp;
			<c:forEach var="a" begin="${startpage }" end="${endpage }">
				<c:if test="${a == pageNum }">[${a}]</c:if>
				<c:if test="${a != pageNum }">
					<a href="javascript:list(${a},${sort })">[${a}]</a>
				</c:if>
			</c:forEach>
			<c:if test="${pageNum < maxpage}">
				<a href="javascript:list(${pageNum + 1 },${sort })">[다음]</a>
			</c:if>
			&nbsp;
			<c:if test="${pageNum >= maxpage }">[다음]</c:if>
			&nbsp;
	</div>
	<br>
	<form  action="messageList.jsy" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1"> 
		<input type="hidden" name="sort" value="${sort }">
		<span style="float:right">
		<select name="searchType" id="searchType">
			<option value="" disabled selected>선택하세요</option>
			<option value="subject">제목</option>
			<option value="content">내용</option>
			<c:if test="${sort.equals('1')}">
				<option value="sender">보낸 사람</option>
			</c:if>
			<c:if test="${sort.equals('2')}">
				<option value="receiver">받은 사람</option>
			</c:if>
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
