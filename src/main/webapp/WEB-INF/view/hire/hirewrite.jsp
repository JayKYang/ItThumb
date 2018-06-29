<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>채용공고</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
        $(function() {
            $("#image").on('change', function(){
                readURL(this);
            });
        });

        function readURL(input) {
            if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                    $('#profilephoto').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }
        $(document).ready(function(){
        var area ="";
        $("#area").change(function(){
        	area = $("#area option:selected").val();
        	$('input[name="region"]').val(area)
        })        
        var qualification = "";
        $("#qaulification").change(function(){
        	qualification = $("#qaulification option:selected").val();
        	$('input[name="qualification"]').val(qualification)
        })
        var hirestatus="";
        $("#hirestatus").change(function(){
        	hirestatus = $("#hirestatus option:selected").val();
        	$('input[name="hirestatus"]').val(hirestatus)
        })
        var workday="";
        $("#workday").change(function(){
        	workday = $("#workday option:selected").val();
        	$('input[name="workday"]').val(workday)
        })
        var salary="";
        aa = "self";
        $("#salary").change(function(){
        	salary = $("#salary option:selected").val();
        	$('input[name="salary"]').val(salary)        
        })
   })
    </script>
</head>
<body>
	<form:form modelAttribute="hire" action="hirewrite.jsy" method="post" enctype="multipart/form-data" name="f">	
		<table border="1" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td>
					<h5>제목</h5>
				</td>
				<td colspan="3">
					<form:input path="subject" /><font color="orange"><form:errors path="subject" /></font>
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
					<select id="qaulification">
						<option value="">선택하세요</option>
						<option>고등학교 졸업 이상</option>
						<option>대학교(2,3년) 졸업 이상</option>
						<option>대학교(4년) 졸업 이상</option>
						<option>석사 졸업 이상</option>
						<option>박사 졸업 이상</option>
					</select>
					<form:input path="qualification" /><font color="orange"><form:errors path="qualification" /></font>
				</td>
			</tr>
			<tr>
				<td colspan="2"><h5>기업정보</h5></td>
				<td colspan="2"><h5>근무조건</h5></td>
			</tr>
			<tr>
				<td><h6>설립일</h6></td>
				<td>
					<fmt:formatDate value="${user.birth}" pattern="yyyy-MM-dd" /> 
				</td>
				<td><h6>근무지역</h6></td>
				<td>
					<select id="area" name="area">
						<option>선택하세요</option>
						<option value="서울 ">서울특별시</option>
						<option value="인천 ">인천광역시</option>
						<option value="대전 ">대전광역시</option>
						<option value="광주 ">광주광역시</option>
						<option value="대구 ">대구광역시</option>
						<option value="울산 ">울산광역시</option>
						<option value="부산 ">부산광역시</option>
						<option value="세종 ">세종특별자치시</option>
						<option value="경기 ">경기도</option>
						<option value="강원 ">강원도</option>
						<option value="충북 ">충청북도</option>
						<option value="충남 ">충청남도</option>
						<option value="전북 ">전라북도</option>
						<option value="전남 ">전라남도</option>
						<option value="경북 ">경상북도</option>
						<option value="경남 ">경상남도</option>
						<option value="제주 ">제주특별자치도</option>
					</select>
					<form:input path="region"/><font color="orange"><form:errors path="region" /></font>
					<br>
					<label style="font-size:8pt;">세부주소를 같이 입력해주세요.</label>
				</td>
			</tr>
			<tr>
				<td><h6>사업</h6></td>
				<td>
					${user.industy}
				</td>
				<td><h6>고용형태</h6></td>
				<td>
					<select id="hirestatus">
						<option value="">선택하세요</option>
						<option>정규직</option>
						<option>파견직</option>
						<option>인턴직</option>
						<option>계약직</option>
						<option>위촉직</option>
						<option>프리랜서</option>
						<option>기타</option>
					</select>
					<form:input path="hirestatus" /><font color="orange"><form:errors path="hirestatus" /></font>
				</td>
			</tr>
			<tr>
				<td><h6>지역</h6></td>
				<td>
					${user.address}
				</td>
				<td><h6>연봉</h6></td>
				<td>
				<select id="salary">
						<option value="">선택하세요</option>
						<option value="0">협상 후 연봉결정</option>
						<option value="2200">2200만원 이상</option>
						<option value="2400">2400만원 이상</option>
						<option value="2600">2600만원 이상</option>
						<option value="2800">2800만원 이상</option>
						<option value="3000">3000만원 이상</option>
						<option value="숫자를입력해주세요">직접입력</option>
					</select>
					<form:input path="salary" /><font color="orange"><form:errors path="salary" /></font>
				</td>
			</tr>
			<tr>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
				<td><h6>근무일</h6></td>
				<td>
				<select id="workday">
						<option value="">선택하세요</option>
						<option value="주5일(월~금)">주5일(월~금)</option>
						<option value="토요일 격주휴무(월~토)">토요일 격주휴무(월~토)</option>
						<option value="주6일(월~토)">주6일(월~토)</option>
						<option value="주3일(격일제)">주3일(격일제)</option>
						<option value="탄력근무제">탄력근무제</option>
					</select>
					<form:input path="workday" /><font color="orange"><form:errors path="workday" /></font>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<div id="profile">
					<img id="profilephoto" src="../photo/defaultphoto.png"  style="height:200px; width:150px;" alt="이미지 파일이 아닙니다.">
				</div>
				<input type="file" name="image" id="image"/>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<h6>내용</h6>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<form:textarea rows="15" cols="80" path="content" />
					<font color="orange"><form:errors path="content" /></font>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
					<a href="javascript:document.f.submit()">신청하기</a>
					<a href="hirelist.jsy">LIST</a>
				</td>
			</tr>
		</table>
	</form:form>
</body>
</html>