<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 포트폴리오 검색</title>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<!-- <style>
.skillhover {
	cursor: pointer;
}

.popupLayer {
	position: absolute;
	display: none;
	background-color: #ffffff;
	border: solid 2px #d0d0d0;
	width: 350px;
	height: 150px;
	padding: 10px;
}
.popupLayer div {
	position: absolute;
	top: 5px;
	right: 5px
}
</style>
<script>
function closeLayer( obj ) {
	$(obj).parent().parent().hide();
}

$(function(){

	/* 클릭 클릭시 클릭을 클릭한 위치 근처에 레이어가 나타난다. */
	$('.skillhover').hover(function(e)
	{
		var sWidth = window.innerWidth;
		var sHeight = window.innerHeight;

		var oWidth = $('.popupLayer').width();
		var oHeight = $('.popupLayer').height();

		// 레이어가 나타날 위치를 셋팅한다.
		var divLeft = e.clientX + 10;
		var divTop = e.clientY + 5;

		// 레이어가 화면 크기를 벗어나면 위치를 바꾸어 배치한다.
		if( divLeft + oWidth > sWidth ) divLeft -= oWidth;
		if( divTop + oHeight > sHeight ) divTop -= oHeight;

		// 레이어 위치를 바꾸었더니 상단기준점(0,0) 밖으로 벗어난다면 상단기준점(0,0)에 배치하자.
		if( divLeft < 0 ) divLeft = 0;
		if( divTop < 0 ) divTop = 0;

		$('.popupLayer').css({
			"top": divTop,
			"left": divLeft,
			"position": "absolute"
		}).show();
	});

</script> -->
</head>
<body>
	<div class="w3-content w3-padding-64">
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
	      <c:set var="skillcnt" value="0"/>
	      <c:forEach items="${portfolio.historyList }" var="skill" varStatus="index">
	      	<c:if test="${skill.kindno == 1 && skillcnt <= 2}">
	      		<c:set var="skillcnt" value="${skillcnt+1 }"/>
	      		${skill.content}
	      		 <c:if test="${!index.last && skillcnt <= 2}">, </c:if>
	      	</c:if>
	      	<%-- <c:if test="${skill.kindno == 1 && index.last}">
	      		<a class="skillhover">...</a>
	      	</c:if>
	      	<div class="popupLayer">
	      		 	<ul>
	      		 		<li>
	      		 			<c:if test="${skill.kindno == 1}">
				      		${skill.content}
				      		</c:if>
				      	</li>
	      		 	</ul>
	      		 </div> --%>
	      </c:forEach>
	      </td>
	      <td><a href="myportfolio.jsy?id=${portfolio.memberid}&pageNum=${pageNum}">${portfolio.slogun }</a></td>
	      <td><fmt:formatDate value="${portfolio.modifydate }" type="both" pattern="yyyy-MM-dd"/></td>
	    </tr>
		</c:if>
	    </c:forEach>
	    <c:if test="${empty portfoliolist }">
	    	<tr><td colspan="4">포트폴리오가 없습니다.</td></tr>
	    </c:if>
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

<%-- <div class="w3-container" id="main">
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
</div> --%>