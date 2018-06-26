<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<c:set var="path" value="${pageContact.request.contextPath }"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>일반유저가입</title>
 <script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
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
                    $('#aa').attr('src', e.target.result);
                }

              reader.readAsDataURL(input.files[0]);
            }
        }


    </script>
</head>
<body>
<form:form modelAttribute="user" action="normalJoinForm.jsy" method="post" enctype="multipart/form-data">
	<spring:hasBindErrors name="user">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
	<table border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td align="center">사진</td>
			<td>
				<div id="profile">
					
						<img id="aa" src="../photo/defaultphoto.png"  style="height:400px; width:350px;"alt="your image">
				</div>
				<input type="file" name="image" id="image"/>
			</td>
		</tr>
		<tr>
			<td align="center">이메일</td>
			<td>
				<form:input path="memberid" />
				<font color="red"><form:errors path="memberid"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">비밀번호</td>
			<td>
				<form:password path="password" />
				<font color="red"><form:errors path="password"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">비밀번호확인</td>
			<td>
				<input type="password" name="passconfirm">
			</td>
		</tr>
		<tr>
			<td align="center">이름</td>
			<td>
				<form:input path="name"/>
				<font color="red"><form:errors path="name"/></font>
			</td>
		</tr>
		<tr>
			<td align="center">연락처</td>
			<td>
				<form:input path="tel"/>
				<font color="red"><form:errors path="tel"/></font>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<input type="submit" value="JOIN">
			</td>
		</tr>
	</table>
</form:form>
</body>
</html>