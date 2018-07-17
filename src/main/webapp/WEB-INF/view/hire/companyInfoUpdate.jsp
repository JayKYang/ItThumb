<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	 //보험
	   $('input[name="chkinsurance"]').click(function(){
	      var a =[];
	      $('input[name="insurance"]').val(null);
	      $('input[name="chkinsurance"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="insurance"]').val(a);
	      })
	   })   
	   
	   //회사분위기
	   $('input[name="chkmood"]').click(function(){
	      var a =[];
	      $('input[name="mood"]').val(null);
	      $('input[name="chkmood"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="mood"]').val(a);
	      })
	   })
	   
	   //의료,건강
	   $('input[name="chkhealth"]').click(function(){
	      var a =[];
	      $('input[name="health"]').val(null);
	      $('input[name="chkhealth"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="health"]').val(a);
	      })
	   })
	   
	   //사무실환경
	   $('input[name="chkoffice"]').click(function(){
	      var a =[];
	      $('input[name="office"]').val(null);
	      $('input[name="chkoffice"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="office"]').val(a);
	      })
	   })

	   //의복관련
	   $('input[name="chkclothes"]').click(function(){
	      var a =[];
	      $('input[name="clothes"]').val(null);
	      $('input[name="chkclothes"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="clothes"]').val(a);
	      })
	   })
	   
	   //식사관련
	   $('input[name="chkmeal"]').click(function(){
	      var a =[];
	      $('input[name="meal"]').val(null);
	      $('input[name="chkmeal"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="meal"]').val(a);
	      })
	   })
	   
	   //지급품관련
	   $('input[name="chksupplies"]').click(function(){
	      var a =[];
	      $('input[name="supplies"]').val(null);
	      $('input[name="chksupplies"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="supplies"]').val(a);
	      })
	   })
	   
	   //출산/육아
	   $('input[name="chkcare"]').click(function(){
	      var a =[];
	      $('input[name="care"]').val(null);
	      $('input[name="chkcare"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="care"]').val(a);
	      })
	   })
	   
	   //지원금관련
	   $('input[name="chksupportfund"]').click(function(){
	      var a =[];
	      $('input[name="supportfund"]').val(null);
	      $('input[name="chksupportfund"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="supportfund"]').val(a);
	      })
	   })
	   
	   //교육관련
	   $('input[name="chkeducation"]').click(function(){
	      var a =[];
	      $('input[name="education"]').val(null);
	      $('input[name="chkeducation"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="education"]').val(a);
	      })
	   })
	   
	   //회사행사
	   $('input[name="chkcompanyevent"]').click(function(){
	      var a =[];
	      $('input[name="companyevent"]').val(null);
	      $('input[name="chkcompanyevent"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="companyevent"]').val(a);
	      })
	   })
	   
	   //교통관련
	   $('input[name="chktraffic"]').click(function(){
	      var a =[];
	      $('input[name="traffic"]').val(null);
	      $('input[name="chktraffic"]:checked').each(function(){
	         a.push($(this).val());
	         $('input[name="traffic"]').val(a);
	      })
	   })
	   
	   
});
</script>
<style>
.button {
	width: 80px;
	height: 40px;
}

.button {
	border-radius: 4px;
	background-color: blue;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 5px;
	transition: all 0.5s;
	cursor: pointer;
}

.button:hover {
	background-color: skyblue;
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

	<div class="w3-bar w3-small w3-left w3-indigo" style="width: 100%;">
		<div style="width: 115.39px; height: 102px;"
			class="w3-bar-item w3-padding-large"></div>
	</div>
	<div class="w3-center" style="width: 100%;">
		<p>
			<span class="w3-content w3-text-indigo w3-xxlarge">기업 세부 정보 수정</span>
		</p>
	</div>
	<div class="w3-content">
		<form:form modelAttribute="companyInfo" action="companyInfoUpdate.jsy"
			method="post" name="f">
			<input type="hidden" name="infono" value="${companyInfo.infono}">
			<input type="hidden" name="hireno" value="${hireno}">
			<table style="width: 100%;" class="board_view">
				<tr>

					<td style="font-size: 20px;">대표자명</td>
					<td><form:input path="ceoname" class="w3-input w3-border" /> <font
						color="red"><form:errors path="ceoname" /></font></td>
				</tr>
				<tr>
					<td style="font-size: 20px;">사원수</td>
					<td><form:input path="worker" class="w3-input w3-border" /> <font
						color="red"><form:errors path="worker" /></font></td>
					<td style="font-size: 20px;">자본금</td>
					<td><form:input path="capital" class="w3-input w3-border" /> <font
						color="red"><form:errors path="capital" /></font></td>
				</tr>
				<tr>
					<td style="font-size: 20px;">매출액</td>
					<td><form:input path="sales" class="w3-input w3-border" /> <font
						color="red"><form:errors path="sales" /></font></td>
					<td style="font-size: 20px;">영업이익</td>
					<td><form:input path="profit" class="w3-input w3-border" /><font
						color="red"> <form:errors path="profit" /></font></td>
				</tr>
			</table>
			<br>
			<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-xlarge">근무조건(선택사항)</span>
				</p>
			</div>
			<table style="width: 100%;" class="board_view">
				<tr>
					<td style="font-size: 20px; width: 20%;">연금보험</td>
					<td><input class="w3-check" name="chkinsurance"
						type="checkbox" value="국민연금(4대보험)">국민연금(4대보험) <input
						class="w3-check" name="chkinsurance" type="checkbox"
						value="고용보험(4대보험)">고용보험(4대보험) <input class="w3-check"
						name="chkinsurance" type="checkbox" value="산재보험(4대보험)">산재보험(4대보험)
						<input class="w3-check" name="chkinsurance" type="checkbox"
						value="건강보험(4대보험)">건강보험(4대보험) <input type="hidden"
						name="insurance"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">급여제도</td>
					<td><input name="salsystem" type="text"
						class="w3-input w3-border"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">수당제도</td>
					<td><input name="benefit" type="text"
						class="w3-input w3-border"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">회사분위기</td>
					<td><input class="w3-check" name="chkmood" type="checkbox"
						value="회식 강요 안함">회식 강요 안함 <input class="w3-check"
						name="chkmood" type="checkbox" value="인재육성 중시">인재육성 중시 <input
						class="w3-check" name="chkmood" type="checkbox" value="초고속 승진 가능">초고속
						승진 가능 <input class="w3-check" name="chkmood" type="checkbox"
						value="호칭/서열 파괴">호칭/서열 파괴 <input class="w3-check"
						name="chkmood" type="checkbox" value="가족같은 분위기">가족같은 분위기 <input
						class="w3-check" name="chkmood" type="checkbox" value="야근 강요 안함">야근
						강요 안함 <input type="hidden" name="mood"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">명절/기념일</td>
					<td><input name="anniversary" type="text"
						class="w3-input w3-border"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">의료/건강</td>
					<td><input class="w3-check" name="chkhealth" type="checkbox"
						value="헬스장 구비">헬스장 구비 <input class="w3-check"
						name="chkhealth" type="checkbox" value="건강검진">건강검진 <input
						class="w3-check" name="chkhealth" type="checkbox" value="가족 건강 검진">가족
						건강 검진 <input type="hidden" name="health"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">사무실 환경</td>
					<td><input class="w3-check" name="chkoffice" type="checkbox"
						value="회의실(PT가능)">회의실(PT가능) <input class="w3-check"
						name="chkoffice" type="checkbox" value="무선인터넷">무선인터넷 <input
						class="w3-check" name="chkoffice" type="checkbox" value="화장실 비데">화장실
						비데 <input class="w3-check" name="chkoffice" type="checkbox"
						value="사내 정원">사내 정원 <input class="w3-check"
						name="chkoffice" type="checkbox" value="샤워실,취침실">샤워실,취침실 <input
						class="w3-check" name="chkoffice" type="checkbox" value="여성전용 휴게실">여성전용
						휴게실 <input class="w3-check" name="chkoffice" type="checkbox"
						value="공기청정기">공기청정기 <input class="w3-check"
						name="chkoffice" type="checkbox" value="카페테리아">카페테리아 <input
						class="w3-check" name="chkoffice" type="checkbox" value="건물 내 흡연실">건물
						내 흡연실 <input type="hidden" name="office"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">의복관련</td>
					<td><input class="w3-check" name="chkclothes" type="checkbox"
						value="자유복장">자유복장 <input class="w3-check"
						name="chkclothes" type="checkbox" value="정장">정장 <input
						type="hidden" name="clothes"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">식사관련</td>
					<td><input class="w3-check" name="chkmeal" type="checkbox"
						value="저녁식사 제공">저녁식사 제공 <input class="w3-check"
						name="chkmeal" type="checkbox" value="냉장고 있음">냉장고 있음 <input
						class="w3-check" name="chkmeal" type="checkbox" value="전자레인지 있음">전자레인지
						있음 <input class="w3-check" name="chkmeal" type="checkbox"
						value="음료제공(차,커피)">음료제공(차,커피) <input class="w3-check"
						name="chkmeal" type="checkbox" value="간식지급">간식지급 <input
						class="w3-check" name="chkmeal" type="checkbox" value="구내식당">구내식당
						<input type="hidden" name="meal"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">지급품</td>
					<td><input class="w3-check" name="chksupplies" type="checkbox"
						value="개인 직통전화">개인 직통전화 <input class="w3-check"
						name="chksupplies" type="checkbox" value="회사 뺏지">회사뺏지 <input
						class="w3-check" name="chksupplies" type="checkbox"
						value="회사 다이어리">회사다이어리 <input class="w3-check"
						name="chksupplies" type="checkbox" value="회사 캘린더">회사캘린더 <input
						class="w3-check" name="chksupplies" type="checkbox" value="회사 필기구">회사필기구
						<input class="w3-check" name="chksupplies" type="checkbox"
						value="사원증(멤버쉽카드)">사원증(멤버쉽카드) <input class="w3-check"
						name="chksupplies" type="checkbox" value="사원증">사원증 <input
						class="w3-check" name="chksupplies" type="checkbox" value="노트북">노트북
						<input class="w3-check" name="chksupplies" type="checkbox"
						value="듀얼모니터">듀얼모니터 <input class="w3-check"
						name="chksupplies" type="checkbox" value="자회사 제품 할인">자회사
						제품 할인 <input type="hidden" name="supplies"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">출산/육아</td>
					<td><input class="w3-check" name="chkcare" type="checkbox"
						value="산전 후 휴가">산전 후 휴가 <input class="w3-check"
						name="chkcare" type="checkbox" value="육아 휴직">육아 휴직 <input
						class="w3-check" name="chkcare" type="checkbox" value="남성 출산휴가">남성
						출산휴가 <input type="hidden" name="care"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">지원금/대출</td>
					<td><input class="w3-check" name="chksupportfund"
						type="checkbox" value="자녀학자금(일반)">자녀학자금(일반) <input
						class="w3-check" name="chksupportfund" type="checkbox"
						value="자녀학자금(유치원)">자녀학자금(유치원) <input class="w3-check"
						name="chksupportfund" type="checkbox" value="자녀학자금(초등)">자녀학자금(초등)
						<input class="w3-check" name="chksupportfund" type="checkbox"
						value="자녀학자금(중등)">자녀학자금(중등) <input class="w3-check"
						name="chksupportfund" type="checkbox" value="자녀학자금(고등)">자녀학자금(고등)
						<input class="w3-check" name="chksupportfund" type="checkbox"
						value="자녀학자금(대학)">자녀학자금(대학) <input class="w3-check"
						name="chksupportfund" type="checkbox" value="직원대출제도">직원대출제도
						<input class="w3-check" name="chksupportfund" type="checkbox"
						value="각종 경조사 지원">각종 경조사 지원 <input class="w3-check"
						name="chksupportfund" type="checkbox" value="통신비 지원">통신비
						지원 <input type="hidden" name="supportfund"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">교육/훈련</td>
					<td><input class="w3-check" name="chkeducation"
						type="checkbox" value="신입 사원교육">신입 사원교육 <input
						class="w3-check" name="chkeducation" type="checkbox"
						value="직무 능력향상교육">직무 능력향상교육 <input class="w3-check"
						name="chkeducation" type="checkbox" value="리더쉽 강화교육">리더쉽
						강화교육 <input class="w3-check" name="chkeducation" type="checkbox"
						value="도서구입비 지원">도서구입비 지원 <input class="w3-check"
						name="chkeducation" type="checkbox" value="멘토링제도">멘토링제도 <input
						class="w3-check" name="chkeducation" type="checkbox"
						value="사이버연수원 운영">사이버연수원 운영 <input class="w3-check"
						name="chkeducation" type="checkbox" value="교육비 지원">교육비 지원
						<input class="w3-check" name="chkeducation" type="checkbox"
						value="자기계발비 지원">자기계발비 지원 <input type="hidden"
						name="education"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">회사행사</td>
					<td><input class="w3-check" name="chkcompanyevent"
						type="checkbox" value="우수사원 시상식">우수사원 시상식 <input
						class="w3-check" name="chkcompanyevent" type="checkbox"
						value="워크샵">워크샵 <input class="w3-check"
						name="chkcompanyevent" type="checkbox" value="신입사원OT">신입사원OT
						<input class="w3-check" name="chkcompanyevent" type="checkbox"
						value="체육대회">체육대회 <input class="w3-check"
						name="chkcompanyevent" type="checkbox" value="야유회">야유회 <input
						class="w3-check" name="chkcompanyevent" type="checkbox"
						value="단합대회/MT">단합대회/MT <input type="hidden"
						name="companyevent"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">교통/출퇴근</td>
					<td><input class="w3-check" name="chktraffic" type="checkbox"
						value="야간교통비 지급">야간교통비 지급 <input class="w3-check"
						name="chktraffic" type="checkbox" value="회사 차량있음">회사 차량있음
						<input type="hidden" name="traffic"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
				<tr>
					<td style="font-size: 20px; width: 20%;">동호회/조직</td>
					<td><input name="society" type="text"
						class="w3-input w3-border"></td>
				</tr>
				<tr>
					<td><br></td>
				</tr>
			</table>
			<div style="text-align: right">
				<br>
				<br> <input type="button" class="button"
					onclick="location.href='hirelist.jsy'" value="목 록">&nbsp;&nbsp;
				<input type="submit" class="button" value="수정하기">&nbsp;&nbsp;
			</div>
		</form:form>
	</div>
</body>
</html>