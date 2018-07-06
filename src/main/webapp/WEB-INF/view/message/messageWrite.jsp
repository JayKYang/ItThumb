<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>messagewrite</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
   $(document).ready(function() {
      $(".listbox").hide();
      $("#memberid").keyup(function() {
      var uid = $("#memberid").val(); //입력된 아이디
      var data = "memberid="+uid;//파라미터값 설정
      $.ajax({
         type : "POST",
         url : "./autoIdComplete.jsy",
         data : data,
         success : function(html) {
            $(".listbox").show();
            $(".namelist").html(html);
            $("li").hover(function() {
               $(this).addClass("hover");
            }, function() {
               $(this).removeClass("hover");
            });
            $("li").click(function() {
               $("#receiver").val($("#receiver").val()+$(this).text()+","); // this : li테그
               $(".listbox").hide();
            })
         }
      })
   })
   })
   
</script>
<style>
.w3-sidebar {width: 120px;background: #222;}
#main {margin-left: 120px}
</style>
<body>

<nav class="w3-sidebar w3-bar-block w3-small w3-center">
  <a href="messageList.jsy?sort=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">받은 쪽지함</p>
  </a>
  <a href="messageList.jsy?sort=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">보낸 쪽지함</p>
  </a>
  <a href="messageWrite.jsy" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
    <p class="w3-text-light-grey">쪽지 보내기</p>
  </a>
</nav>


<div class="w3-container" id="main">
	<form:form modelAttribute="message" action="messageWrite.jsy" method="post">
	<spring:hasBindErrors name="message">
		<font color="red">
			<c:forEach items="${errors.globalErrors }" var="error">
				<spring:message code="${error.code }"></spring:message>
			</c:forEach>
		</font>
	</spring:hasBindErrors>
		<p>
			<label> <b>아이디 검색</b></label><br>
			<input type="text" id="memberid"><br>
			<div class="listbox">
				<div class="namelist"></div>
			</div>
			<label> <b>받는 사람</b></label><br>
			<c:if test="${memberid!=null}">
				<form:input path="receiver" id="receiver" value="${memberid},"/><font color="red"><form:errors path="receiver"/></font>
			</c:if>
			<c:if test="${memberid==null}">
				<form:input path="receiver" id="receiver"/><font color="red"><form:errors path="receiver"/></font>
			</c:if>
			
		</p>
		<p>
			<label> <b>제 목</b></label><br>
			<form:input path="subject" /><font color="red"><form:errors path="subject"/></font>
		</p>
		<p>
			<label> <b>내 용</b></label><br>
			<form:textarea path="content" rows="20" cols="40"/><font color="red"><form:errors path="content"/></font>
		</p>
		
		<input type="submit" value="보내기">
		
	
	</form:form>
  	
</div>

</body>
</html>
