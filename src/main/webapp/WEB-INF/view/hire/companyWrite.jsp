<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>연혁 및 실적 작성</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
var count = 1;
$(document).ready(function(){
	 var array = []
     var month = new Date();
        month = ${birth}; // 1990 - 설립일
     
     var now = new Date(); // 현재날짜 20180713..
     now = now.getFullYear(); 
     
     for(var i=month; i<=now; i++){ // 설립일 1990~2018
        array.push(i);
     }
     
     var a = array.join(",");
     var b = a.split(",");
        console.log(a);
     
     var html = "";
        html += '<select class="w3-select" style="width:20%;" id="selectCareerYear_0" name="selectCareerYear">'
        html += '<option>선택해주세요</option>';
        for(var i=0; i<array.length;i++){
           html+= '<option name="year" value="'+array[i]+'">'+array[i]+'년</option>';
        }
        html+='</select>';

     array=[]
     for(var i=1; i<13; i++){
        array.push(i);
     };
        html += '<select class="w3-select" style="width:20%;" id="selectCareerMonth_0" name="selectCareerMonth">'
        html += '<option>선택해주세요</option>';
     for(var i=0; i<array.length; i++){
        html+= '<option name="month" value="'+array[i]+'">'+array[i]+'월</option>';
     }
        html+='</select>';
     
        console.log(html);
        $('#click_0').append(html);  


        
       $('#selectCareerYear_0').change(function(){
    		if($(this).val()=='선택해주세요'){
       		      alert("년도를 선택해주세요");
    	         $("#careerYear_0").val('');
    	}else{
 		$("#careerYear_0").val($(this).val());
 		var i = $("#careerYear_0").val()
 		
 		$("#Date_0").val(i+"-"+$("#careerMonth_0").val())
 		
 		}
	})
		$('#selectCareerMonth_0').change(function(){
 		if($(this).val()=='선택해주세요'){
  			  alert("달을 선택해주세요");
  			  $("#careerMonth_0").val('');
 			}else{
 			$("#careerMonth_0").val($(this).val());
 			var i = $("#careerMonth_0").val()
 	 		
 	 		$("#Date_0").val($("#careerYear_0").val()+"-"+i)
 			
 			}
			})
			
	

	
	$('#historyPlus').click(function(){
		
		event.preventDefault();
		  var html = "";
		   
		   	html += '<div class="w3-container_'+count+'" id="addTable_'+count+'">'
		    html += '<h6 class="w3-text-teal" id="click_'+count+'"><i class="fa fa-calendar fa-fw w3-margin-right"></i></h6>'
		   	html +=	 '<input type="hidden" id="careerYear_'+count+'">'
			html +=  '<input type="hidden" id="careerMonth_'+count+'">'
			html +=  '<input type="hidden" name="historydate" id="Date_'+count+'">'
		    html += '<input type="text" style="width: 30%;" name="content" placeholder="내용을 입력해주세요"><br><br>'
		    html += '<input type="button" style="width:40px;height:30px;" id="divDelete_'+count+'" class="button" value="삭제">'
		    html += '</div>'

		     
		    $('#addTable').append(html)
		    
		    
		    datePlus(count);
		    /* href="javascript:divDelete('+count+')" */
		    
			$('#divDelete_'+count).click(function(){
				event.preventDefault();
				$(this).parent().remove();
				
			})		
		    
		   	count = count+1;
	})

	
	
}); //document.ready 끝

function divDelete(count){
	alert("asfasf")
	$('input[name="addTable_'+count+'"]').parent().remove();
}


function datePlus(count){
	var array = []
    var month = new Date();
       month = ${birth}; // 1990 - 설립일
    
    var now = new Date(); // 현재날짜 20180713..
    now = now.getFullYear(); 
    
    for(var i=month; i<=now; i++){ // 설립일 1990~2018
       array.push(i);
    }
    
    var a = array.join(",");
    var b = a.split(",");
       console.log(a);
    
    var html = "";
       html += '<select class="w3-select" style="width:20%;" id="selectCareerYear_'+count+'" name="selectCareerYear">'
       html += '<option>선택해주세요</option>';
       for(var i=0; i<array.length;i++){
          html+= '<option name="year" value="'+array[i]+'">'+array[i]+'년</option>';
       }
       html+='</select>';

    array=[]
    for(var i=1; i<13; i++){
       array.push(i);
    };
       html += '<select class="w3-select" style="width:20%;" id="selectCareerMonth_'+count+'" name="selectCareerMonth">'
       html += '<option>선택해주세요</option>';
    for(var i=0; i<array.length; i++){
       html+= '<option name="month" value="'+array[i]+'">'+array[i]+'월</option>';
    }
       html+='</select>';

       console.log(html);
       $('#click_'+count).append(html);  
	   
	
       $("#selectCareerYear_"+count).change(function(){
   		if($(this).val()=='선택해주세요'){
      		      alert("년도를 선택해주세요");
   	         $("#careerYear_"+count).val('');
   	}else{
		$("#careerYear_"+count).val($(this).val());
		var i = $("#careerYear_"+count).val()
		
		$("#Date_"+count).val(i+"-"+$("#careerMonth_"+count).val())
		
		}
	})
		$("#selectCareerMonth_"+count).change(function(){
		if($(this).val()=='선택해주세요'){
 			  alert("달을 선택해주세요");
 			  $("#careerMonth_"+count).val('');
			}else{
			$("#careerMonth_"+count).val($(this).val());
			var i = $("#careerMonth_"+count).val()
	 		
	 		$("#Date_"+count).val($("#careerYear_"+count).val()+"-"+i)
			
			}
			})
  
}
</script>
<style type="text/css">
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
			<span class="w3-content w3-text-indigo w3-xxlarge">연혁 및 실적 작성</span>
		</p>
	</div>
	
	<div class="w3-content w3-center">
    	

		<form action="companyWrite.jsy" method="post" name="f">

			<div class="w3-container_0" id="addTable">
				<h6 class="w3-text-teal" id="click_0">
					<i class="fa fa-calendar fa-fw w3-margin-right"></i>
				</h6>
				<input type="hidden" id="careerYear_0"> 
				<input type="hidden" id="careerMonth_0"> 
				<input type="hidden" name="historydate" id="Date_0">
				<input type="text" style="width: 30%;" name="content" placeholder="내용을 입력해주세요">
			</div>
			<div class="w3-right">
				<input type="button" id="historyPlus" class="button" value="추가하기">
				<input type="submit" class="button" value="입력">
			</div>
		</form>
	</div>
</body>
</html>