<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%
   FileInputStream fi = new FileInputStream("C:/Users/user/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");
  BufferedReader br = new BufferedReader(new InputStreamReader(fi,"UTF-8"));
   String line = null;
   br.readLine();
   Map<String, Set<String>> sidomap = new TreeMap<String, Set<String>>();
   while ((line = br.readLine()) != null) {
      try {
         String[] sido = line.split("\t");
         String[] si = sido[1].split(" ");
         Set<String> silist = sidomap.get(si[0]);
         if (silist == null) {
            silist = new TreeSet<String>();
         }
         silist.add(si[1]);
         sidomap.put(si[0], silist);
      } catch (ArrayIndexOutOfBoundsException e) {
      }
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ITThumb 채용 공고</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
var divchkarr = new Array();
var idx = 0;
$(document).ready(function(){
	var a = ['서울','인천','대전','광주','대구','울산','부산','세종','경기','강원','충북','충남','전북','전남','경북','경남','제주'];
	var html ="";
	html += "<br>";
	for(var i=0; i<a.length; i++){
		html += '<input type="checkbox" name="bbb" id="bbb'+i+'" value="\''+a[i]+'\'">'+a[i];
	}
	$(".region").append(html);	
	
	var b = ['고등학교 졸업 이상','대학교(2,3년) 졸업 이상', '대학교(4년) 졸업 이상', '석사 졸업 이상', '박사 졸업 이상']
	var html2 = "";
	html2+="<br>";
	html2 +="<option>선택하세요</option>";
	for(var i=0; i<b.length; i++){
		html2 += '<option>'+b[i]+'</option>';
	}
	$("#levelofedu").append(html2);
	
	var c =['정규직','파견직','인턴직','계약직','위촉직','프리랜서','기타']
	var html3 = "";
	html3 += "<br>";
	for(var i=0; i<c.length; i++){
		html3 += '<input type="checkbox" name="ccc" id="ccc'+i+'" value="\''+c[i]+'\'">'+c[i]
	}
	$("#fff").append(html3);	
	
	
	
	var fa="";
	
	
	$('input[name="bbb"]').click(function(i){
		divchkarr.
		$('input[name="searchRegion"]').val(null);	
		
		$('input[name="bbb"]:checked').each(function(){

			$("#divchk").children('a[name="atag"]').remove();
			a.push($(this).val());
			$('input[name="searchRegion"]').val(a);
			htmla="";
		 	divchkarr[idx++] = b;
		 	divchkdisp();
		})
		})
		
		
	$("#levelofedu").change(function(){
	 	var htmlb = "";
		
		var b = $("#levelofedu option:selected").val();
	 	if(b == '선택하세요'){
	 		b="";
	 		alert("학력을 선택해 주세요.");
	 	}
	 	$('input[name="searchEdu"]').val(b);
	 	
	 	divchkarr[idx++] = b;
	 	divchkdisp();
	})
	
	$('input[name="ccc"]').click(function(){
		var c = [];	
		$('input[name="searchCarr"]').val(null);			
		$('input[name="ccc"]:checked').each(function(){
			c.push($(this).val());				

 $('input[name="searchCarr"]').val(c);

			});
	})
	
})

function divchkdisp() {
	for(var i =0; i<idx-1; i++){
		htmla+='<a href="#" name="atag" value="'+a[i]+'">'+a[i]+'</a> ';	
	}
	$("#divchk").html(htmla);	

}

</script>
<script type="text/javascript">
function hirelist(pageNum){
	var searchRegion = document.searchform.searchRegion.value;
	var searchEdu = document.searchform.searchEdu.value;
	var searchCarr = document.searchform.searchCarr.value;
	
	if(searchRegion==null&&searchEdu==null&&searchCarr==null|| searchRegion.length==0&&searchEdu.length==0&&searchCarr.length==0){
		document.searchform.pageNum.value = "1";
		location.href = "hirelist.jsy?pageNum=" + pageNum;
	} else{
		document.searchform.pageNum.value = pageNum;
		document.searchform.submit();
		return true;
	}
	return false;
	}	
	
function removeDuplArrays(a){
	var a2 =[];
	for (var i = 0; i < a.length; i++) {
        if (a2.length == 0) {
        	a2.push(a[i]);
        } else {
            var duplicatesFlag = true;
            for (var j = 0; j < a2.length; j++) {
                if (a2[j] == a[i]) {
                    duplicatesFlag = false;
                    break;
                }
            }
            if (duplicatesFlag) {
            	a2.push(a[i]);
            }
        }
    }
    return a2;

}
	

</script>
<script type="text/javascript">
sies = new Array(
<c:forEach items="<%=sidomap%>" var="si">
      new Option("${si.key}"),
</c:forEach>   
);
   gues = new Array();
   <c:forEach items="<%=sidomap%>" var="si" varStatus="stat1">
        gues[${stat1.index}] = new Array();
        <c:forEach items="${si.value}" var="gu" varStatus="stat2">
           gues[${stat1.index}][${stat2.index}] = new Option("${gu}"),
        </c:forEach>   
   </c:forEach>   
   //html 시작시 호출되는 함수 설정
   window.onload = function() {
      document.f.si.options[0] = new Option("선택하세요");
      document.f.gu.options[0] = new Option("선택하세요");
      for (i = 1; i <= sies.length; i++) {
         document.f.si.options[i] = sies[i-1];
      }
   }
   //f : form 객체를 저장
   function selectgu(f) {
      var opcnt = f.gu.options.length
      for (i = opcnt-1; i >= 0; i--) {
         f.gu.options[i] = null; //기존 Option 객체 제거
      }
      
      siidx = f.si.selectedIndex;
      
      document.f.gu.options[0] = new Option("선택하세요");
      for (i = 0; i < gues[siidx].length; i++) {
         document.f.gu.options[i+1] = gues[siidx-1][i];
      }
   }
</script>


<style type="text/css">
#aa, #bb,#cc {
	border: 1px solid #000000;
	width: 250px;
	height : 400px;	
}
</style>
</head>
<body>

<div name="aa">
<h6 class="region">지역</h6>
<form name="f">
 <select name="si" id="si" onchange="selectgu(this.form)">
            </select>
            <select name="gu" id="gu">
            </select>
 <div id="sichk" name="sichk">
 
 </div>
 <div id="guchk" name="guchk">
 
 </div>
</form>
</div>
<div name="bb">
<h6>학력</h6>
<select name="levelofedu" id="levelofedu">
</select>
</div>
<div name="cc">
<h6 id="fff">고용형태</h6>

</div>
<br>
<table width="90%" border="1" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="5" align="center">
	<form action="hirelist.jsy" method="post" name="searchform" onsubmit="return hirelist(1)">
		<input type="hidden" name="pageNum" value="1">
			<input type="text" name="searchRegion" id="searchRegion" value="${param.searchRegion}">
			<input type="text" name="searchEdu" value="${param.searchEdu}">
			<input type="text" name="searchCarr" value="${param.searchCarr}">
			
			
			
			<input type="submit" value="Search">
	</form>	
		</td>
	</tr>
	<tr>
		<td colspan="5" width="90%" height="100px" id="allchk">
				<div id="divchk">
				
				</div>
		</td>
	</tr>
	<tr align="center" valign="middle" bordercolor="#212121">
			<th width="10%" height="26">기업명</th>
			<th width="50%" height="26">제목</th>
			<th width="14%" height="26">지원자격</th>
			<th width="6%" height="26">근무조건</th>
			<th width="20 %" height="26">공고기간</th>
		</tr>
		
		<c:forEach var="hireboard" items="${boardlist}">
		<tr align="center" valign="middle" bordercolor="#333333" onmouseover="this.style.backgroundColor='#5CD1E5'" onmouseout="this.style.backgroundColor=''">
			<td>
					${hireboard.company}			
			</td>
			<td>
					<a href="hiredetail.jsy?hireno=${hireboard.hireno}&pageNum=${pageNum}">${hireboard.subject}</a>
			</td>
				<td align="left">${hireboard.qualification}</td>
				<td align="center">${hireboard.hirestatus}</td>
				<td align="left">
					<fmt:formatDate value="${hireboard.deadline}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
		</tr>
		</c:forEach>
				<tr align="center" height="26">
			<td colspan="5">
				<c:if test="${pageNum >1}">
					<a href="javascript:hirelist(${pageNum -1})">BACK</a>
				</c:if> &nbsp;
				<c:if test="${pageNum <= 1}">BACK</c:if>&nbsp;
				<c:forEach var="a" begin="${startpage}" end = "${endpage}">
					<c:if test="${a == pageNum}">${a}</c:if>
					<c:if test="${a != pageNum}">
					<a href="javascript:hirelist(${a})">${a}</a>
					</c:if>
				</c:forEach>
				<c:if test="${pageNum < maxpage}">
					<a href="javascript:hirelist(${pageNum + 1})">NEXT</a>
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