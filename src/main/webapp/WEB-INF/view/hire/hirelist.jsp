<%@ page language="java" contentType="text/html; charset=UTF-8
"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>ITThumb 채용 공고</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>

$(document).ready(function(){
var a=[];	
var b = "";
var c = "";
	$('input[name="bbb"]').click(function(i){
		a=[]
		$('input[name="bbb"]:checked').each(function(){
			
			a.push($(this).val());
			$('input[name="searchRegion"]').val(a)
		})
	})
	
	$("#levelofedu").change(function(){
		b = $("#levelofedu option:selected").val();

		$('input[name="searchEdu"]').val(b);
	})
	
	$('input[name="ccc"]').click(function(){
		var c = $('input[name="ccc"]:checked').val();
		$('input[name=searchCarr]').val(c)
	})
	
})
</script>
<style type="text/css">
#aa, #bb {
	border: 1px solid #000000;
	width: 250px;
	height : 400px;	
}
</style></head>
<body>

<div id="aa">
<h6>지역</h6>
<input type="checkbox"  name="bbb" id="bbb1" value="서울">서울
<input type="checkbox"  name="bbb" id="bbb2" value="경기">경기
<input type="checkbox"  name="bbb" id="bbb3" value="충청">충청도
<input type="checkbox"  name="bbb" id="bbb4" value="강원">강원도
<input type="checkbox"  name="bbb" id="bbb5" value="경상">경상도
</div>
<div>
<h6>학력</h6>
<select name="levelofedu" id="levelofedu">
	<option>고등학교 졸업</option>
	<option>대학 졸업(2,3년) 이상</option>
	<option>대학 졸업(4년)이상</option>
	<option>석사 졸업</option>
	<option>박사 졸업</option>
</select>
</div>
<div>
<input type="checkbox" name="ccc" id="ccc1" value="new">신입
<input type="checkbox" name="ccc" id="ccc2" value="career">경력

</div>
<br>
<table width="90%" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" align="center">
	<form action="hirelist.jsy" method="post" name="searchform" onsubmit="return list(1)">
		<input type="hidden" name="pageNum" value="1">
			<input type="text" name="searchRegion" value="${param.searchRegion}">
			<input type="text" name="searchEdu" value="${param.searchEdu}">
			<input type="text" name="searchCarr" value="${param.searchCarr}">
			
			<input type="submit" value="Search">
	</form>
		</td>
	</tr>
	<tr align="center" valign="middle" bordercolor="#212121">
			<th width="8%" height="26">기업명</th>
			<th width="50%" height="26">제목</th>
			<th width="14%" height="26">지원자격</th>
			<th width="11%" height="26">근무조건</th>
			<th width="17 %" height="26">공고기간</th>
		</tr>
		
		<c:forEach var="hireboard" items="${boardlist}">
		<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.backgroundColor='#5CD1E5'" onmouseout="this.style.backgroundColor=''">
			<td>
					${hireboard.memberid}			
			</td>
			<td>
					<a href="detail.jsy?hireno=${hireboard.hireno}&pageNum=${pageNum}">${hireboard.subject}</a>
			</td>
				<td align="left">${hireboard.qualification}</td>
				<td align="center">${hireboard.hirestatus}</td>
				<td align="left">${hireboard.deadline}</td>
		</tr>
		</c:forEach>
				<tr align="center" height="26">
			<td colspan="5">
				<c:if test="${pageNum >1}">
					<a href="javascript:list(${pageNum -1})">BACK</a>
				</c:if> &nbsp;
				<c:if test="${pageNum <= 1}">BACK</c:if>&nbsp;
				<c:forEach var="a" begin="${startpage}" end = "${endpage}">
					<c:if test="${a == pageNum}">${a}</c:if>
					<c:if test="${a != pageNum}">
					<a href="javascript:list(${a})">${a}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:list(${pageNum + 1})">NEXT</a>
				</c:if> &nbsp;
				<c:if test="${pageNum >= maxpage}">NEXT
				</c:if> &nbsp;
			</td>
		</tr>
		
			<c:if test="${listcount==0}">
		<tr>
			<td colspan="5">등록된 채용공고 게시물이 없습니다.</td>
		</tr>
	</c:if>
		<tr>
		<td align="right" colspan="5">
			<a href="hirewrite.jsy">WRITE</a>
		</td>
	</tr>
		
</table>
</body>
</html>