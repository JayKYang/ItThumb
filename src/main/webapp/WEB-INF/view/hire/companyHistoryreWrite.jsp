<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
        html += '<select id="selectCareerYear_0" name="selectCareerYear">'
        html += '<option>선택해주세요</option>';
        for(var i=0; i<array.length;i++){
           html+= '<option name="year" value="'+array[i]+'">'+array[i]+'</option>';
        }
        html+='</select>';

     array=[]
     for(var i=1; i<13; i++){
        array.push(i);
     };
        html += '<select id="selectCareerMonth_0" name="selectCareerMonth">'
        html += '<option>선택해주세요</option>';
     for(var i=0; i<array.length; i++){
        html+= '<option name="month" value="'+array[i]+'">'+array[i]+'</option>';
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
		   
		/*    html += '<tr name="insertTr">'
		   html +=   '<td>' */
		   html += '<div class="w3-container_'+count+'" id="addTable_'+count+'">'
		    html += '<h6 class="w3-text-teal" name="career" id="click_'+count+'"><i class="fa fa-calendar fa-fw w3-margin-right"></i></h6>'
		   	html +=	 '<input type="hidden" id="careerYear_'+count+'">'
			html +=  '<input type="hidden" id="careerMonth_'+count+'">'
			html +=  '<input type="text" name="historydate" id="Date_'+count+'">'
		    html += '<h5 class="w3-opacity">내용<input type="text" name="content"></h5>'
		    html += '<hr>'
		    html += '<a id="divDelete_'+count+'">삭제</a>'
		    html += '</div>'
		 /*    html += '</td>'
		    html += '</tr>' */
		     
		    $('#addTable').append(html)
		    
		    
		    datePlus(count);
		   	
		    
			$('#divDelete_'+count).click(function(){
				event.preventDefault();
				alert("asfasf");
				$("#addTable_"+count).remove();
			})		
		    
		    
		    
		    
		   	count = count+1;

	})

	
	
}); //document.ready 끝

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
       html += '<select id="selectCareerYear_'+count+'" name="selectCareerYear">'
       html += '<option>선택해주세요</option>';
       for(var i=0; i<array.length;i++){
          html+= '<option name="year" value="'+array[i]+'">'+array[i]+'</option>';
       }
       html+='</select>';

    array=[]
    for(var i=1; i<13; i++){
       array.push(i);
    };
       html += '<select id="selectCareerMonth_'+count+'" name="selectCareerMonth">'
       html += '<option>선택해주세요</option>';
    for(var i=0; i<array.length; i++){
       html+= '<option name="month" value="'+array[i]+'">'+array[i]+'</option>';
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
</head>
<body>
    <div class="w3-twothird">
    
      <div class="w3-container w3-card w3-white w3-margin-bottom">
      
        <h2 class="w3-text-grey w3-padding-16"><i class="fa fa-suitcase fa-fw w3-margin-right w3-xxlarge w3-text-teal" name="companyHistory"></i>연혁 및 실적</h2>
      </div>
        <a id="historyPlus">추가하기</a>
    </div>
   <form modelAttribute="companyhistory" action="companyWrite.jsy" method="post" name="f">
   <table width="100%" border="1">
         <tr class="insertTr">
         	<td>         
               <div class="w3-container_0" id="addTable">
                  <h6 class="w3-text-teal" name="career" id="click_0"><i class="fa fa-calendar fa-fw w3-margin-right"></i>
				  </h6>
				  <input type="text" id="careerYear_0">
				  <input type="text" id="careerMonth_0">
				  <input type="text" name="historydate" id="Date_0">
                  <h5 class="w3-opacity">내용<input type="text" name="content"></h5>
            	  <a id="divDelete_0">삭제</a>
                   <hr>
              </div>
          	</td>
         </tr>
         <tr>
         	<td>
         	<input type="submit" value="입력">
         	</td>
         </tr>
    </table>
   </form>
</body>
</html>