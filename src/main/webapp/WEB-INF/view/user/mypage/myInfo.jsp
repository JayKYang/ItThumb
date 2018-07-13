<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지 > 회원 정보</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
<script type="text/javascript">
		$(document).ready(function(){
			<spring:hasBindErrors name="user">
				<c:forEach items="${errors.globalErrors }" var="error">
					alert('<spring:message code="${error.code }"></spring:message>');
				</c:forEach>
			</spring:hasBindErrors>
		});
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
       function eventOccur(evEle, evType){
    	   if (evEle.fireEvent) {
    	   evEle.fireEvent('on' + evType);
    	   } else {
    	   //MouseEvents가 포인트 그냥 Events는 안됨~ ??
    	   var mouseEvent = document.createEvent('MouseEvents');
    	   /* API문서 initEvent(type,bubbles,cancelable) */
    	   mouseEvent.initEvent(evType, true, false);
    	   var transCheck = evEle.dispatchEvent(mouseEvent);
    	   if (!transCheck) {
	    	   //만약 이벤트에 실패했다면
	    	   console.log("클릭 이벤트 발생 실패!");
	    	  }
    	   }
    	  }
    	  /** 대체버튼 클릭시 강제 이벤트 발생**/
    	  function fileUpload(){
    	   eventOccur(document.getElementById('image'),'click');
    	   /* alert(orgFile.value); 이벤트 처리가 끝나지 않은 타이밍이라 값 확인 안됨! 시간차 문제 */
    	  }
</script>
<style>
	.button{
		width:150px;
		height:60px;
	}
   	.button {
	  border-radius: 4px;
	  background-color: skyblue;
	  border: none;
	  color: #FFFFFF;
	  text-align: center;
	  font-size: 18px;
	  padding: 20px;
	  transition: all 0.5s;
	  cursor: pointer;
	}
	.button:hover {
	  background-color: pink;
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
	<div class="w3-content">
		<div class="w3-center">
			<p>
				<span class="w3-content w3-text-purple w3-xxlarge">회원 정보</span>
			</p>
		</div>
		<div class="w3-content w3-container w3-padding-32">
			<div id="info" class="w3-content" style="display:block;">
				<form:form style="container" modelAttribute="user" action="myInfo.jsy" name="f" method="post" enctype="multipart/form-data">
					<form:hidden path="imageUrl" />
					<div id="profile">
						<c:if test="${empty sessionScope.login.imageUrl }">
							<img class="w3-button" id="profilephoto" src="../../photo/defaultphoto.png"  style="width:30%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
						</c:if>
						<c:if test="${!empty sessionScope.login.imageUrl }" >
							<img class="w3-button" id="profilephoto" src="../../photo/${sessionScope.login.imageUrl }"  style="width:30%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
						</c:if>
						<input type="file" name="image" id="image" style="display:none"/>
					</div>
					<p>
					<label>이메일</label>
					<form:input class="w3-input" path="memberid" />
					<font color="red"><form:errors path="memberid"/></font>
					</p>
					<p>
					<label>이름</label>
					<form:input class="w3-input" path="name"/>
					<font color="red"><form:errors path="name"/></font>
					</p>
					<c:if test="${sessionScope.login.membergrade==2 }">
					<p>
					<label>사이트</label>
					<form:input class="w3-input" path="site"/>
					<font color="red"><form:errors path="site"/></font>
					</p>
					<p>
					<label>업종</label>
					<form:input class="w3-input" path="industy"/>
					<font color="red"><form:errors path="industy"/></font>
					</p>
					<p>
					<label>지역</label>
					<form:input class="w3-input" path="address"/>
					<font color="red"><form:errors path="address"/></font>		
					</p>
					<p>
					<label>연락처</label>
					<form:input class="w3-input" path="tel"/>
					<font color="red"><form:errors path="tel"/></font>
					</p>			
					<p>
					<label>설립일</label>
					<fmt:formatDate value="${user.birth }" pattern="yyyy-MM-dd" var="builddate"/>
					<form:input class="w3-input" path="birth" value="${builddate}"/>
					<font color="red"><form:errors path="birth"/></font>
					</p>
					<p>		
					<label>사업자번호</label>
					<form:input class="w3-input" path="companyserial"/>
					<font color="red"><form:errors path="companyserial"/></font>
					</p>
					</c:if>
					<p>
					<label>비밀번호</label>
					<form:password class="w3-input" path="password" />
					<font color="red"><form:errors path="password"/></font>
					</p>
					<div class="w3-container">
						<input type="button" id="btn1" class="button w3-left" onclick="location.href='../delete.jsy?id=${login.memberid}'" value="회원탈퇴">
						<input type="submit" id="btn2" class="button w3-right" value="수정">
					</div>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>