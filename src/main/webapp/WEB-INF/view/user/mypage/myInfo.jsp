<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>IT Thumb > 마이 페이지</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	
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
</head>
<body>
	<div class="w3-container w3-padding-32" style="width:70%; margin-left:15%;">
		<div id="info" class="myInfo" style="display:block;">
			<form:form modelAttribute="user" method="post" action="myInfo.jsy" enctype="multipart/form-data">
				<form:hidden path="imageUrl" />
				<spring:hasBindErrors name="user">
					<font color="red">
						<c:forEach items="${errors.globalErrors }" var="error">
							<spring:message code="${error.code }"/>
						</c:forEach>
					</font>
				</spring:hasBindErrors>
				<table class="w3-table">
					<tr>
						<td align="center">사진</td>
						<td>
							<div id="profile">
								<c:if test="${empty sessionScope.login.imageUrl }">
									<img class="w3-button" id="profilephoto" src="../../photo/defaultphoto.png"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
								</c:if>
								<c:if test="${!empty sessionScope.login.imageUrl }" >
									<img class="w3-button" id="profilephoto" src="../../photo/${sessionScope.login.imageUrl }"  style="width:15%;" alt="이미지 파일이 아닙니다." onclick="fileUpload()">
								</c:if>
								<input type="file" name="image" id="image" style="display:none"/>
							</div>
						</td>
					</tr>
					<tr>
						<td>아이디</td><td><form:input path="memberid" class="w3-input" readonly="true"/><font color="red"><form:errors path="memberid" readonly="true"/></font></td>
					</tr>
					<tr>
						<td>이름</td><td><form:input path="name" class="w3-input" /><font color="red"><form:errors path="name" id="name"/></font></td>
					</tr>
					<tr>
						<td>패스워드</td><td><form:password path="password" class="w3-input"/><font color="red"><form:errors path="password"/></font></td>
					</tr>
					<tr>
						<td class="w3-center"><input class="w3-button" type="button" value="회원탈퇴" onclick="location.href='../delete.jsy?id=${login.memberid}'"></td>
						<td class="w3-center"><input class="w3-button" type="submit" value="수정"></td>
					</tr>
				</table>
			</form:form>
		</div>
	</div>
</body>
</html>