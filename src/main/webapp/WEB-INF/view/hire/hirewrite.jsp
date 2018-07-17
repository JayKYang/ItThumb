<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%

	//FileInputStream fi = new FileInputStream("C:/Users/user/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt"); 
	FileInputStream fi = new FileInputStream("C:/Users/Winhyoni/Desktop/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");									
	//FileInputStream fi = new FileInputStream("C:/Users/dumby/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");
	
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
  	
        	$('select[name="careerdate"]').attr('disabled',true);
        	
        	
        var si ="";
        $("#si").change(function(){
        	si = $("#si option:selected").val();
        	$('input[name="region"]').val(si)
        })
        var gu ="";
        $("#gu").change(function(){
        	//siconvert();
        	gu = $("#gu option:selected").val();

        	$('input[name="regiongu"]').val(gu)
        })
        
        var careerdate ="";
        $('select[name="career"]').change(function(){
        	if($('select[name="career"]').val()=='경력'){
        	$('select[name="careerdate"]').attr('disabled',false);
        	} else if($('select[name="career"]').val()==null || $('select[name="career"]').val()==''){
        		$('select[name="careerdate"]').attr('disabled',true);
        	}
        })
 })
 
    function convertString(deadlinetime){
    	
	var d = deadlinetime.toString();
   	
   	console.log(d);
   	$('input[name="deadline"]').val(d);
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


<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script> $(function() { $("#postcodify_search_button").postcodifyPopUp(); }); </script>
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
					<form:select path="qualification">
					<form:option value="">선택하세요</form:option>
					<form:option value="고등학교 졸업 이상">고등학교 졸업 이상</form:option>
					<form:option value="대학교(2,3년) 졸업 이상">대학교(2,3년) 졸업 이상</form:option>
					<form:option value="대학교(4년) 졸업 이상">대학교(4년) 졸업 이상</form:option>
					<form:option value="석사 졸업 이상">석사 졸업 이상</form:option>
					<form:option value="박사 졸업 이상">박사 졸업 이상</form:option>
					</form:select>
					<font color="orange"><form:errors path="qualification" /></font>
				</td>
			</tr>
			<tr>
				<td colspan="2"><h5>기업정보</h5></td>
				<td colspan="2"><h5>근무조건</h5></td>
			</tr>
			<tr>
				<td><h6>마감일</h6></td>
				<td>
				<form:input path="deadline" /><font color="orange"><form:errors path="deadline" /></font>
				</td>
				<td><h6>근무지역</h6></td>
				<td>
	 <select name="si" id="si" onchange="selectgu(this.form)">
            </select>
            <select name="gu" id="gu">
            </select>
	 <div id="sichk" name="sichk">
 
 	</div>
 	<div id="guchk" name="guchk">
 </div>
					<form:input path="region"/><font color="orange"><form:errors path="region" /></font>
					<form:input path="regiongu"/><font color="orange"><form:errors path="regiongu"/></font>
					<form:input path="regionetc"/><font color="orange"><form:errors path="regionetc"/></font>
					<br>
					<label style="font-size:8pt;">세부주소를 같이 입력해주세요.</label>
				</td>
			</tr>
			<tr>
				<td><h6>경력</h6></td>
				<td>
				
					<form:select path="career">
					<form:option value="">선택하세요</form:option>
					<form:option value="신입">신입</form:option>
					<form:option value="경력">경력</form:option>
					</form:select>
					<font color="orange"><form:errors path="career" /></font>
				</td>
				<td><h6>고용형태</h6></td>
				<td>
				<form:select path="hirestatus">
					<form:option value="">선택하세요</form:option>
					<form:option value="정규직">정규직</form:option>
					<form:option value="파견직">파견직</form:option>
					<form:option value="인턴직">인턴직</form:option>
					<form:option value="계약직">계약직</form:option>
					<form:option value="위촉직">위촉직</form:option>
					<form:option value="프리랜서">프리랜서</form:option>
					<form:option value="기타">기타</form:option>
				</form:select>
					
				<font color="orange"><form:errors path="hirestatus" /></font>
				</td>
			</tr>
			<tr>
				<td><h6>추가입력(경력)</h6></td>
				<td>
					<select id="careerdate" name="careerdate">
						<option>선택해주세요</option>
						<option>6개월 이하</option>
						<option>1년 이하</option>
						<option>3년 이하</option>
						<option>5년 이하</option>
					</select>
				</td>
				<td><h6>연봉</h6></td>
				<td>
				<form:select path="salary">
					<form:option value="">선택하세요</form:option>
					<form:option value="2200">2200만원 이상</form:option>
					<form:option value="2400">2400만원 이상</form:option>
					<form:option value="2600">2600만원 이상</form:option>
					<form:option value="2800">2800만원 이상</form:option>
					<form:option value="3000">3000만원 이상</form:option>
				</form:select>
				<font color="orange"><form:errors path="salary" /></font>
				</td>
			</tr>
			<tr>
				<td><h6>사이트</h6></td>
				<td>
					<a href="${user.site}">${user.site}</a>
				</td>
				<td><h6>근무일</h6></td>
				<td>

					<form:select path="workday">
					<form:option value="">선택하세요</form:option>
					<form:option value="주5일(월~금)">주5일(월~금)</form:option>
					<form:option value="토요일 격주휴무(월~토)">토요일 격주휴무(월~토)</form:option>
					<form:option value="주6일(월~토)">주6일(월~토)</form:option>
					<form:option value="주3일(격일제)">주3일(격일제)</form:option>
					<form:option value="탄력근무제">탄력근무제</form:option>
				</form:select>
					<font color="orange"><form:errors path="workday" /></font>
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
	
<!-- 	<table>
	<tr>
				<td>
			<input type="text" name="" class="postcodify_postcode5" value="" />
				</td>
				<td>
				<button id="postcodify_search_button">검색</button><br />
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="" class="postcodify_address" value="" /><br />
<input type="text" name="" class="postcodify_details" value="" /><br />
<input type="text" name="" class="postcodify_extra_info" value="" /><br />
				
				
				</td>
			</tr>
	</table> -->
	
</body>
</html>