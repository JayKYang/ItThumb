<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<title>communityBoard</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-2.1.0.min.js"></script>
<script type="text/javascript">
       
</script>
<script type="text/javascript">
        var g_count = 0;
        $(document).ready(function(){
        	
            $("a[id='delete']").on("click",function(e){
                e.preventDefault();
                fn_fileDelete($(this));
            })
            $("#add").on("click",function(e){
                e.preventDefault();
                fn_fileAdd();
            })
        });
         
        function fn_fileDelete(obj){
   
        	obj.parent().remove();
        }
        
        function fn_fileAdd(){
            var str = "<p><input type='file' name='fileList' id='file_"+(g_count)+"'/><img id='preimg_"+(g_count)+"' style='height:50px; width:50px;' alt='NO IMAGE'>&nbsp;&nbsp;<a href='#this' id='delete' class='btn'>삭제하기</a></p> ";
            
            $("#fileDiv").append(str);
            $("a[id='delete']").on("click",function(e){
                e.preventDefault();
                fn_fileDelete($(this));
                
            })
            $(function() {
            	var count = g_count;
    			$('#file_'+count).change(function(){
    		        readURL(this,count);
    		    });
    		});
            g_count+=1;
            
        }

		$(function() {
			$('#file_0').change(function(){
		        readURL(this,0);
		    });
		});
		
		
		function readURL(input, i) {
			var num = i;
	        if (input.files && input.files[0]) {
	        	var reader = new FileReader();
	            reader.onload = function (e) {
	              	$('#preimg_'+num).attr('src', e.target.result);
	            }
	            reader.readAsDataURL(input.files[0]);
	        }
	    }
</script>
</head>

<style>
body, h1,h2,h3,h4,h5,h6 {font-family: "Montserrat", sans-serif}
.w3-row-padding img {margin-bottom: 12px}
@media only screen and (max-width: 600px) {#main {margin-left: 0}}
</style>

<body class="w3-black">
	<nav class="w3-sidebar w3-bar-block w3-small w3-hide-small w3-center w3-black">
		<a href="comList.jsy?communitykind=1" class="w3-bar-item w3-button w3-padding-large w3-hover-gray">
		<i class="fa fa-clipboard w3-xxlarge"></i>
			<p>자유 게시판</p>
		</a> 
		<a href="comList.jsy?communitykind=2" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
		<i class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>Q & A</p>
		</a>
		<c:if test="${!empty sessionScope.login}"> 
			<a href="comList.jsy?communitykind=3" class="w3-bar-item w3-button w3-padding-large w3-hover-gray"> 
			<i class=" fa fa-edit w3-xxlarge"></i>
				<p>내가 쓴 글</p>
			</a>
		</c:if>
	</nav>
<div id="main">
	<form:form modelAttribute="community" action="communityUpdate.jsy" method="post" enctype="multipart/form-data">
		 <input type="hidden" value="${communitykind}" name="communitykind">
		 <input type="hidden" value="${pageNum}" name="pageNum">
		 <input type="hidden" value="${communityno}" name="communityno">
		 <input type="hidden" value="${memberid}" name="memberid">
		 
		 <table class="board_view">
		 	<c:if test="${communitykind==1}">
            	<caption>자유게시판 수정</caption>
            </c:if>
            <c:if test="${communitykind==2}">
            	<caption>Q & A 수정</caption>
            </c:if>
            <tbody>
                <tr>
                    <th scope="row">제목</th>
                    <td><form:input path="subject" /><font color="red"><form:errors path="subject"/></font></td>
                </tr>
                <tr>
                    <th scope="row">내용</th>
                    <td><form:textarea path="content" rows="20" cols="40"/><font color="red"><form:errors path="content"/></font></td>
                </tr>
            </tbody>
        </table>
        <div id="fileDiv">
            	<c:forEach items="${fileList}" varStatus="status" var="fl">
            		<p>
            		<input type="hidden" name="files" value="${fl.fname}"/>
            		[ ${fl.fname} ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<img src="../comfiles/${fl.fname}" style="height:50px; width:50px;" alt="NO IMAGE">&nbsp;&nbsp;
					<a href="#this" id="delete" class="btn">삭제하기</a>
            		</p>
            	</c:forEach>
        </div>
        <br/><br/>
        <a href="#this" id="add" class="w3-button">파일 추가하기</a>
        <a href="comInfo.jsy?communitykind=${communitykind}&pageNum=${pageNum}&communityno=${community.communityno}" class="w3-button">취소</a>
        <input type="submit" class="w3-button" value="수 정"> 
	</form:form>
</div>
</body>
</html>