<%@page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<%
   FileReader fi = new FileReader("C:/Users/user/git/ItThumb/src/main/webapp/WEB-INF/법정동코드+전체자료.txt");

   BufferedReader br = new BufferedReader(fi);
   String line = null;
   br.readLine();
   Map<String, Set<String>> sidomap = new TreeMap<String, Set<String>>();
   while ((line = br.readLine()) != null) {
      try {
         String[] sido = line.split("\t");
         String[] si = sido[1].split(" ");
         Set<String> silist = sidomap.get(si[0]);
         if (silist == null) {
            silist = new TreeSet<String>();
         }
         silist.add(si[1]);
         sidomap.put(si[0], silist);
      } catch (ArrayIndexOutOfBoundsException e) {
      }
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>study write</title>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
sies = new Array(
<c:forEach items="<%=sidomap%>" var="si">
      new Option("${si.key}"),
</c:forEach>   
);
   gues = new Array();
   <c:forEach items="<%=sidomap%>" var="si" varStatus="stat1">
        gues[${stat1.index}] = new Array();
        <c:forEach items="${si.value}" var="gu" varStatus="stat2">
           gues[${stat1.index}][${stat2.index}] = new Option("${gu}"),
        </c:forEach>   
   </c:forEach>   
   //html 시작시 호출되는 함수 설정
   window.onload = function() {
      document.f.si.options[0] = new Option("선택하세요");
      document.f.gu.options[0] = new Option("선택하세요");
      for (i = 1; i <= sies.length; i++) {
         document.f.si.options[i] = sies[i-1];
      }
   }
   //f : form 객체를 저장
   function selectgu(f) {
      var opcnt = f.gu.options.length
      for (i = opcnt-1; i >= 0; i--) {
         f.gu.options[i] = null; //기존 Option 객체 제거
      }
      
      siidx = f.si.selectedIndex;
      
      document.f.gu.options[0] = new Option("선택하세요");
      for (i = 0; i < gues[siidx].length; i++) {
         document.f.gu.options[i+1] = gues[siidx-1][i];
      }
   }
</script>
<script type="text/javascript">
$(document).ready(function() {
   $("#si").change(function(){
      var si = $("#si option:selected").val();
      if(si=="선택하세요"){
         si = "";
      }
      $('input[name="region"]').val(si);
   })
   $("#gu").change(function(){
      var si = $("#si option:selected").val();
      var gu = $("#gu option:selected").val();
      $('input[name="region"]').val(si+" "+gu);
   })
})
</script>
</head>

<body>
<form:form modelAttribute="study" action="studyWrite.jsy" method="post" name="f">
   <spring:hasBindErrors name="study">
      <font color="red">
         <c:forEach items="${errors.globalErrors }" var="error">
            <spring:message code="${error.code }"></spring:message>
         </c:forEach>
      </font>
   </spring:hasBindErrors>
   <table>
      <tr>
         <td><b>제 목</b></td>
      </tr>
      <tr>
         <td ><form:input path="studyname" size="50"/><font color="red"><form:errors path="studyname"/></font></td>
      </tr>
      <tr>
         <td><b>지 역</b></td>
      </tr>
      <tr>
         <td>
            <select name="si" id="si" onchange="selectgu(this.form)">
            </select>
            <select name="gu" id="gu">
            </select>
              <form:hidden path="region"/><font color="red"><form:errors path="region"/></font>
           </td>
      </tr>
      <tr>
         <td ><b>인 원 선 택</b></td>
      </tr>
      <tr>
         <td >
            <form:select path="limitmember">
            <form:option value="1">1</form:option>
            <form:option value="2">2</form:option>
            <form:option value="3">3</form:option>
            <form:option value="4">4</form:option>
            <form:option value="5">5</form:option>
            <form:option value="6">6</form:option>
            <form:option value="7">7</form:option>
            <form:option value="8">8</form:option>
            <form:option value="9">9</form:option>
            <form:option value="10">10</form:option>
            <form:option value="100">10명이상</form:option>
            </form:select>
            <font color="red"><form:errors path="limitmember"/></font>
         </td>
      </tr>
      <tr>
         <td ><b>요 일 선 택</b></td>
      </tr>
      <tr>
         <td >
            <form:checkbox path="weekday" value="월"/>
            <form:checkbox path="weekday" value="화"/>
            <form:checkbox path="weekday" value="수"/>
            <form:checkbox path="weekday" value="목"/>
            <form:checkbox path="weekday" value="금"/>
            <form:checkbox path="weekday" value="토"/>
            <form:checkbox path="weekday" value="일"/>
            <form:checkbox path="weekday" value="평일5일"/>
            <form:checkbox path="weekday" value="주말"/>
            <font color="red"><form:errors path="weekday"/></font>
         </td>
      </tr>
      <tr>
         <td ><b>시 작 시 간</b></td>
      </tr>
      <tr>
         <td >
         <form:select path="starttime">
         <form:option value="00:00">00:00</form:option>
         <form:option value="01:00">01:00</form:option>
         <form:option value="02:00">02:00</form:option>
         <form:option value="03:00">03:00</form:option>
         <form:option value="04:00">04:00</form:option>
         <form:option value="05:00">05:00</form:option>
         <form:option value="06:00">06:00</form:option>
         <form:option value="07:00">07:00</form:option>
         <form:option value="08:00">08:00</form:option>
         <form:option value="09:00">09:00</form:option>
         <form:option value="10:00">10:00</form:option>
         <form:option value="11:00">11:00</form:option>
         <form:option value="12:00">12:00</form:option>
         <form:option value="13:00">13:00</form:option>
         <form:option value="14:00">14:00</form:option>
         <form:option value="15:00">15:00</form:option>
         <form:option value="16:00">16:00</form:option>
         <form:option value="17:00">17:00</form:option>
         <form:option value="18:00">18:00</form:option>
         <form:option value="19:00">19:00</form:option>
         <form:option value="20:00">20:00</form:option>
         <form:option value="21:00">21:00</form:option>
         <form:option value="22:00">22:00</form:option>
         <form:option value="23:00">23:00</form:option>
         </form:select>
         <font color="red"><form:errors path="starttime"/></font>
         </td>
      </tr>
      <tr>
         <td ><b>끝나는 시간</b></td>
      </tr>
      <tr>
         <td >
            <form:select path="endtime">
            <form:option value="00:00">00:00</form:option>
            <form:option value="01:00">01:00</form:option>
            <form:option value="02:00">02:00</form:option>
            <form:option value="03:00">03:00</form:option>
            <form:option value="04:00">04:00</form:option>
            <form:option value="05:00">05:00</form:option>
            <form:option value="06:00">06:00</form:option>
            <form:option value="07:00">07:00</form:option>
            <form:option value="08:00">08:00</form:option>
            <form:option value="09:00">09:00</form:option>
            <form:option value="10:00">10:00</form:option>
            <form:option value="11:00">11:00</form:option>
            <form:option value="12:00">12:00</form:option>
            <form:option value="13:00">13:00</form:option>
            <form:option value="14:00">14:00</form:option>
            <form:option value="15:00">15:00</form:option>
            <form:option value="16:00">16:00</form:option>
            <form:option value="17:00">17:00</form:option>
            <form:option value="18:00">18:00</form:option>
            <form:option value="19:00">19:00</form:option>
            <form:option value="20:00">20:00</form:option>
            <form:option value="21:00">21:00</form:option>
            <form:option value="22:00">22:00</form:option>
            <form:option value="23:00">23:00</form:option>
            </form:select>
            <font color="red"><form:errors path="endtime"/></font>
         </td>
      </tr>
      <tr>
         <td ><b>내 용</b></td>
      </tr>
      <tr>
         <td ><form:textarea path="content" rows="40" cols="50"/><font color="red"><form:errors path="content"/></font></td>
      </tr>
      <tr>
         <td><input type="submit" value="등 록 하 기"></td>
      </tr>
   </table>
</form:form>
</body>
</html>