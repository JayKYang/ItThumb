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
            var str = "<p><input type='file' name='fileList' id='file_"+(g_count)+"'/><img id='preimg_"+(g_count)+"' style='height:50px; width:50px;' alt='NO IMAGE'>&nbsp;&nbsp;<a href='#this' id='delete' class='button'>삭제하기</a></p> ";
            
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
<style>
.button {
	width: 60px;
	height: 30px;
}

.button {
	border-radius: 4px;
	background-color: orange;
	border: none;
	color: #FFFFFF;
	text-align: center;
	font-size: 18px;
	padding: 5px;
	transition: all 0.5s;
	cursor: pointer;
}

.button:hover {
	background-color: #FFE4B5;
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
	<div class="w3-bar w3-small w3-left w3-amber" style="width: 100%;">
		<a href="comList.jsy?communitykind=1" style="width:10%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-yellow"> <i
			class="fa fa-clipboard w3-xxlarge"></i>
			<p>자유 게시판</p>
		</a> <a href="comList.jsy?communitykind=2" style="width:10%;"
			class="w3-bar-item w3-button w3-padding-large w3-hover-yellow"> <i
			class="fa fa-question-circle-o w3-xxlarge"></i>
			<p>Q & A</p>
		</a>
		<c:if test="${!empty sessionScope.login}">
			<a href="comList.jsy?communitykind=3" style="width:10%;"
				class="w3-bar-item w3-button w3-padding-large w3-hover-yellow">
				<i class=" fa fa-edit w3-xxlarge"></i>
				<p>내가 쓴 글</p>
			</a>
		</c:if>
	</div>

	<div id="main" class="w3-content w3-container">
		<c:if test="${communitykind==1}">
			<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-text-amber w3-xxlarge">자유게시판 수정</span>
				</p>
			</div>
		</c:if>
		<c:if test="${communitykind==2}">
			<div class="w3-center" style="width: 100%;">
				<p>
					<span class="w3-content w3-text-amber w3-xxlarge">Q & A 수정</span>
				</p>
			</div>
		</c:if>
		<div class="w3-center">
			<form:form modelAttribute="community" action="communityUpdate.jsy"
				method="post" enctype="multipart/form-data">
				<input type="hidden" value="${communitykind}" name="communitykind">
				<input type="hidden" value="${pageNum}" name="pageNum">
				<input type="hidden" value="${communityno}" name="communityno">
				<input type="hidden" value="${memberid}" name="memberid">

				<table class="board_view" style="width: 100%;">
					<tr>
						<th style="text-align: center;"><b style="font-size: 30px">제목</b>&nbsp;<font
							color="red"><form:errors path="subject" /></font></th>
					</tr>
					<tr>
						<td><form:input path="subject" class="w3-input w3-border" /></td>
					</tr>
					<tr>
						<th style="text-align: center;"><b style="font-size: 30px;">내용</b>&nbsp;<font
							color="red"><form:errors path="content" /></font></th>
					</tr>
					<tr>
						<td><form:textarea path="content" class="w3-input w3-border"
								rows="20" cols="40" /></td>
					</tr>
				</table>
				<div id="fileDiv">
					<c:forEach items="${fileList}" varStatus="status" var="fl">
						<p>
							<input type="hidden" name="files" value="${fl.fname}" /> [
							${fl.fname} ]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img
								src="../comfiles/${fl.fname}" style="height: 50px; width: 50px;"
								alt="NO IMAGE">&nbsp;&nbsp; <a href="#this" id="delete"
								class="button">삭제하기</a>
						</p>
					</c:forEach>
				</div>
				<br />
				<br />
				<div class="w3-right">
					<input type="button" style="width: 100px;" id="add" class="button"
						onclick="location.href='#this'" value="파일 추가하기">&nbsp;&nbsp;
					<input type="button" class="button"
						onclick="location.href='comInfo.jsy?communitykind=${communitykind}&pageNum=${pageNum}&communityno=${community.communityno}'"
						value="취소">&nbsp;&nbsp; <input type="submit"
						class="button" value="수 정">
				</div>
			</form:form>
		</div>
	</div>
</body>
</html>