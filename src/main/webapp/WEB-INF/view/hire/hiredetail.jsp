<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 채용공고 > [${user.name}] ${hire.subject }</title>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=qDOuw0wNL1zXEzspRGUC&submodules=geocoder"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
    $('#scrap').click(function() {
        $.ajax({
           url : "hireScrap.jsy",
           type : "POST",
           data : {"hireno":'${hire.hireno}',"memberid":'${hire.memberid}'},
           success : function(data) {
              if(data.success == 'success'){
                 $("#scrap2").attr("class","fa fa-heart");
                 alert("스크랩 되었습니다.");
              }else{
                 $("#scrap2").attr("class","fa fa-heart-o");
                 alert("스크랩이 해제 되었습니다.");
              }
           }
        });
     });


})
</script>
<script>

					function companyDetail(url){
						var h = screen.height*(3/4);
						var w = screen.width*(1.9/3);
						window.open(url,"Company Infomation","width="+w+", height="+h+", left=100, top=100");
					}
					
					</script>
</head>
<body>
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" var="now" pattern="yyyyMMdd" />
	<div class="w3-content" style="margin-top:10%">
		<div class="w3-border" style="padding:2%;">
			<table>
				<tr>
					<td rowspan="4" style="width:20%;"><img src="../photo/${user.imageUrl}" width="210" height="130"></td>
					<td style="padding-left:5%;">
						<a class="w3-xlarge" href="javascript:companyDetail('companyDetail.jsy?hireno=${hire.hireno}&pageNum=1')" name="company" id="company">${user.name}</a>
						<c:if test="${scrapComfirm==0}">
							<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart-o"></i> SCRAP</a>
						</c:if>
						<c:if test="${scrapComfirm==1}">
							<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart"></i> SCRAP</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td style="padding-left:5%;">
						<fmt:formatDate value="${hire.regdate}"	var="regdate" pattern="yyyy.MM.dd HH:MM" />
						<fmt:formatDate value="${hire.deadline}" var="date" pattern="yyyy.MM.dd HH:MM" />
						${regdate } ~ ${date }
						<fmt:formatDate value="${hire.deadline}" var="date"	pattern="yyyyMMdd" />
						<c:if test="${diffDays >= 0 }">
							(<a class="w3-text-red">${diffDays} 일</a> 남음)
							<c:if test="${date-now < 3 }">
								<a class="w3-text-red w3-tag">마감 임박</a>
							</c:if>
						</c:if>
						<c:if test="${diffDays <= 0 }">
							<a class="w3-text-red">마감 공고입니다.</a>
						</c:if>
					</td>
				</tr>
				<tr>
					<td style="padding-left:5%;">
						<div class="w3-border" style="padding:2%; width:135px;">
							<a class="w3-button" href="${user.site}" target="_blank">당사 홈페이지</a>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="w3-border">
			<table class="w3-table">
			<tr>
				<td colspan="4">
				<h6><b>기업정보</b></h6>
				</td>
			</tr>
			<tr>
				<td><h6>설립일</h6></td>
				<td>
					<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>사업</h6></td>
				<td>
						${user.industy}
				</td>
			</tr>
			<tr>
				<td><h6>지역</h6></td>
				<td>
					${user.address}
				</td>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
			</tr>
			</table>
		</div>
		<div class="w3-border">
		<table class="w3-table">
			<tr>
				<td colspan="4">
					<h6><b>근무조건</b></h6>
				</td>
			</tr>
			<tr>
				<td><h5>지원자격</h5></td>
				<td>
					${hire.qualification}
				</td>
			</tr>
			<tr>
				<td><h6>근무지역</h6></td>
				<td>
					${hire.region} ${hire.regiongu} ${hire.regionetc }
				</td>
				<td><h6>고용형태</h6></td>
				<td>
					${hire.hirestatus}
				</td>
			</tr>
			<tr>
				<td><h6>연봉</h6></td>
				<td>
				   <c:choose>
     	  <c:when test="${hire.salary==0}">
      	    협상 후 연봉결정
      		 </c:when>
       		  <c:when test="${hire.salary=='2200'}">
           2200만원 이상
       </c:when>
        <c:when test="${hire.salary=='2400'}">
           2400만원 이상
       </c:when>
           <c:when test="${hire.salary==2600}">
            2600만원 이상
       </c:when>
           <c:when test="${hire.salary==2800}">
            2800만원 이상
       </c:when>
           <c:when test="${hire.salary==3000}">
            3000만원 이상
       </c:when>
       <c:otherwise>
           ${hire.salary}
       </c:otherwise>
   </c:choose>			
				
				</td>
				<td><h6>근무일</h6></td>
				<td>
					${hire.workday}
				</td>
			</tr>
			<tr>
				<td><h6>마감일</h6></td>
				<td>
					<fmt:formatDate value="${hire.deadline}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>경력</h6></td>
				<td>
					${hire.career} ${hire.careerdate}
				</td>
			</tr>
		</table>
		</div>
		<div class="w3-border">
			<table class="w3-table">
			<tr>
				<td colspan="4">
					<span class="w3-xlarge">${hire.subject}</span>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="../hireimg/${hire.imageUrl}" style="width:100%;">
				</td>
			</tr>
			<c:if test="${sessionScope.login.membergrade == '0' }">
			<tr>
				<td colspan="4">
					<h6>내용</h6>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				${hire.content}
				</td>
			</tr>
			</c:if>
			</table>
		</div>
		<div class="w3-right">
			<table>
			<tr>
				<td colspan="4">
				<c:if test="${scrapComfirm==0}">
					<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart-o"></i> SCRAP</a>
				</c:if>
				<c:if test="${scrapComfirm==1}">
					<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart"></i> SCRAP</a>
				</c:if>
						<a href="hirelist.jsy?pageNum=${param.pageNum}">목록</a>					
				<c:if test="${sessionScope.login.membergrade ==0 }">
						<a href="../admin/superviseHire.jsy">채용관리</a>
					</c:if>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>

<%-- 
<table border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td>
					<h5>제목</h5>
				</td>
				<td colspan="3">
					${hire.subject}
				</td>
			</tr>
			<tr>
				<td rowspan="2" colspan="2">
					<img src="../photo/${user.imageUrl}" width="210" height="130">
				</td>
				<td colspan="2"><h5>지원자격</h5></td>
			</tr>
			<tr>
				<td colspan="2">
					${hire.qualification}
				</td>
			</tr>
			<tr>			
				<td colspan="2"><h5>기업명</h5></td>
		
				<td colspan="2">
					<a href="javascript:companyDetail('companyDetail.jsy?hireno=${hire.hireno}&pageNum=1')" name="company" id="company">${user.name}</a>
					<script>

					function companyDetail(url){
						var h = screen.height*(3/4);
						var w = screen.width*(1.9/3);
						window.open(url,"Company Infomation","width="+w+", height="+h+", left=100, top=100");
					}
					
					</script>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<h6>기업정보</h6>
				</td>
			</tr>
			<tr>
				<td><h6>설립일</h6></td>
				<td>
					<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>사업</h6></td>
				<td>
						${user.industy}
				</td>
			</tr>
			<tr>
				<td><h6>지역</h6></td>
				<td>
					${user.address}
				</td>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<h6>근무조건</h6>
				</td>
			</tr>
			<tr>
				<td><h6>근무지역</h6></td>
				<td>
					${hire.region} ${hire.regiongu} ${hire.regionetc }
				</td>
				<td><h6>고용형태</h6></td>
				<td>
					${hire.hirestatus}
				</td>
			</tr>
			<tr>
				<td><h6>연봉</h6></td>
				<td>
				   <c:choose>
     	  <c:when test="${hire.salary==0}">
      	    협상 후 연봉결정
      		 </c:when>
       		  <c:when test="${hire.salary=='2200'}">
           2200만원 이상
       </c:when>
        <c:when test="${hire.salary=='2400'}">
           2400만원 이상
       </c:when>
           <c:when test="${hire.salary==2600}">
            2600만원 이상
       </c:when>
           <c:when test="${hire.salary==2800}">
            2800만원 이상
       </c:when>
           <c:when test="${hire.salary==3000}">
            3000만원 이상
       </c:when>
       <c:otherwise>
           ${hire.salary}
       </c:otherwise>
   </c:choose>			
				
				</td>
				<td><h6>근무일</h6></td>
				<td>
					${hire.workday}
				</td>
			</tr>
			<tr>
				<td><h6>마감일</h6></td>
				<td>
					<fmt:formatDate value="${hire.deadline}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>경력</h6></td>
				<td>
					${hire.career} ${hire.careerdate}
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<img src="../hireimg/${hire.imageUrl}" style="width:80%;">
				</td>
			</tr>
			<c:if test="${sessionScope.login.memberid == 'admin@admin' }">
			<tr>
				<td colspan="4">
					<h6>내용</h6>
				</td>
			</tr>
			<tr>
				<td colspan="4">
				${hire.content}
				</td>
			</tr>
			</c:if>
			<tr>
				<td colspan="4" align="center">
			
			<c:if test="${scrapComfirm==0}">
				<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart-o"></i> SCRAP</a>
			</c:if>
			<c:if test="${scrapComfirm==1}">
				<a id="scrap" class="w3-button w3-large" style="border:1px solid black; border-radius:15px; "><i id="scrap2" class="fa fa-heart"></i> SCRAP</a>
			</c:if>
					<a href="hirelist.jsy?pageNum=${param.pageNum}">LIST</a>					
			<c:if test="${sessionScope.login.membergrade ==0 }">
					<a href="../admin/superviseHire.jsy">채용관리</a>
				</c:if>
				</td>
			</tr>
		</table>
	 --%>