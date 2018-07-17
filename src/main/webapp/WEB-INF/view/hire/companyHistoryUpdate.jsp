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
	 var num = ${maxNum};
	var listcount = ${comhislistcount}

	for(var i=1; i<=listcount; i++){
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
        html += '<select id="selectCareerYear_'+i+'" name="selectCareerYear">'
        html += '<option>선택해주세요</option>';
        for(var i=0; i<array.length;i++){
           html+= '<option name="year" value="'+array[i]+'">'+array[i]+'</option>';
        }
        html+='</select>';

     array=[]
     for(var i=1; i<13; i++){
        array.push(i);
     };
        html += '<select id="selectCareerMonth_'+i+'" name="selectCareerMonth">'
        html += '<option>선택해주세요</option>';
     for(var i=0; i<array.length; i++){
        html+= '<option name="month" value="'+array[i]+'">'+array[i]+'</option>';
     }
        html+='</select>';
     
        console.log(html);
        $('#click_'+i).append(html);  
	}
	
	


        
       $('#selectCareerYear_'+i).change(function(){
    		if($(this).val()=='선택해주세요'){
       		      alert("년도를 선택해주세요");
    	         $("#careerYear_"+i).val('');
    	}else{
 		$("#careerYear_"+i).val($(this).val());
 		var a = $("#careerYear_"+i).val()
 		
 		$("#Date_"+i).val(a+"-"+$("#careerMonth_"+i).val())
 		
 		}
	})
		$('#selectCareerMonth_'+i).change(function(){
 		if($(this).val()=='선택해주세요'){
  			  alert("달을 선택해주세요");
  			  $("#careerMonth_"+i).val('');
 			}else{
 			$("#careerMonth_"+i).val($(this).val());
 			var a = $("#careerMonth_"+i).val()
 	 		
 	 		$("#Date_"+i).val($("#careerYear_"+i).val()+"-"+a)
 			
 			}
			})
	
	$('#historyPlus').click(function(){
		  // 4
		
		event.preventDefault();
		  var html = "";
		  
		  console.log(num);
		   
		/*    html += '<tr name="insertTr">'
		   html +=   '<td>' */
		   html += '<div class="w3-container_'+num+'">'
		    html += '<h6 class="w3-text-teal" name="career" id="click_'+num+'"><i class="fa fa-calendar fa-fw w3-margin-right"></i></h6>'
		   	html +=	 '<input type="hidden" id="careerYear_'+num+'">'
			html +=  '<input type="hidden" id="careerMonth_'+num+'">'
			html +=  '<input type="text" name="historydate" id="Date_'+num+'">'
		    html += '<h5 class="w3-opacity">내용<input type="text" name="content"></h5>'
		    html += '<hr>'
		    html += '</div>'
		 /*    html += '</td>'
		    html += '</tr>' */
		     
		    $('#addTable').append(html)
		    
		    datePlus(num);
	
		    num = num+1;

	})
	
	
}); //document.ready 끝

function datePlus(num){
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
       html += '<select id="selectCareerYear_'+num+'" name="selectCareerYear">'
       html += '<option>선택해주세요</option>';
       for(var i=0; i<array.length;i++){
          html+= '<option name="year" value="'+array[i]+'">'+array[i]+'</option>';
       }
       html+='</select>';

    array=[]
    for(var i=1; i<13; i++){
       array.push(i);
    };
       html += '<select id="selectCareerMonth_'+num+'" name="selectCareerMonth">'
       html += '<option>선택해주세요</option>';
    for(var i=0; i<array.length; i++){
       html+= '<option name="month" value="'+array[i]+'">'+array[i]+'</option>';
    }
       html+='</select>';

       console.log(html);
       $('#click_'+num).append(html);  
	   
		
       $("#selectCareerYear_"+num).change(function(){
   		if($(this).val()=='선택해주세요'){
      		      alert("년도를 선택해주세요");
   	         $("#careerYear_"+num).val('');
   	}else{
		$("#careerYear_"+num).val($(this).val());
		var i = $("#careerYear_"+count).val()
		
		$("#Date_"+num).val(i+"-"+$("#careerMonth_"+num).val())
		
		}
	})
		$("#selectCareerMonth_"+num).change(function(){
		if($(this).val()=='선택해주세요'){
 			  alert("달을 선택해주세요");
 			  $("#careerMonth_"+num).val('');
			}else{
			$("#careerMonth_"+num).val($(this).val());
			var i = $("#careerMonth_"+count).val()
	 		
	 		$("#Date_"+num).val($("#careerYear_"+num).val()+"-"+i)
			
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
         <tr id="insertTr">
         	<td>         
        <c:forEach items="${comHislist}" var="comHistorylist">
               <div class="w3-container_0" id="addTable">
                  <h6 class="w3-text-teal" name="career" id="click_${comHistorylist.historyno}"><i class="fa fa-calendar fa-fw w3-margin-right"></i>
				  </h6>
				  <input type="hidden" id="careerYear_${comHistorylist.historyno}">
				  <input type="hidden" id="careerMonth_${comHistorylist.historyno}">
				  <input type="text" name="historydate" id="Date_${comHistorylist.historyno}" value="${comHistorylist.historydate}">
                  <h5 class="w3-opacity">내용<input type="text" name="content" value="${comHistorylist.content}"></h5>
                	<a>삭제</a>
                <hr>
              </div>
		</c:forEach>
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