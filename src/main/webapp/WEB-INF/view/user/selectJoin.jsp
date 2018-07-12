<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>잇썸 > 회원가입</title>
<style>
	#joinbtn{
		width:250px;
		height:100px;
	}
	ul{
   		list-style:none;
   	}
   	ul li{
   		color:gary;
   	}
   	#joinbtn {
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
	#joinbtn:hover {
	  background-color: pink;
	}
	
	#joinbtn span {
	  cursor: pointer;
	  display: inline-block;
	  position: relative;
	  transition: 0.5s;
	}
	
	#joinbtn span:after {
	  content: '\00bb';
	  position: absolute;
	  opacity: 0;
	  top: 0;
	  right: -20px;
	  transition: 0.5s;
	}
	
	#joinbtn:hover span {
	  padding-right: 25px;
	}
	
	#joinbtn:hover span:after {
	  opacity: 1;
	  right: 0;
	}
</style>
</head>
<body>
	<div class="w3-content w3-padding-64">
		<h1>회원가입</h1>
		<div>
			<p>
				<span class="w3-content w3-text-indigo w3-xxlarge" style="margin-left:10%;">가입유형선택</span>&nbsp;&nbsp;
				<span class="w3-content w3-text-gray w3-xlarge">회원정보입력</span>
			</p>
		</div>
		<hr>
		<div class="w3-content" style="margin-left:15%;">
			<div class="w3-content w3-half">
				<button id="joinbtn" onclick="location.href='joinForm.jsy?kind=1'">일반 사용자</button><br>
				<ul>
					<li><p>포트폴리오 작성</p></li>
					<li><p>스터디 매칭</p></li>
					<li><p>커뮤니티 이용</p></li>
					<li><p>채용공고 확인</p></li>
				</ul>
			</div>
			<div class="w3-content w3-half">
				<button id="joinbtn" onclick="location.href='joinForm.jsy?kind=2'">기업 관계자</button>
				<ul>
					<li><p>기업공고 신청</p></li>
					<li><p>포트폴리오 확인</p></li>
					<li><p>커뮤니티 이용</p></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>