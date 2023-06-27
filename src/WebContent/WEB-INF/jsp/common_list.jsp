<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="/A-five/css/common.css">
<!-- //今日の日付をセット -->
<c:set var="newToday" value="<%= new Date() %>"/>
<% Date currentDate = new Date(); %>

		  <!-- タスク表示 -->

	   <div class="tasklistWrapper bg-warning">
		<div class="d-flex flex-column">
		  <div id="missTask" class="tasklist">
		  	<h3>未達成タスク</h3>

		  		 <%-- <c:forEach var="g" items="${hwList}">

					<!-- <script type="text/javascript">
						console.log("${g.hwName}");
						console.log("${g.hwDue}");
					</script> -->

		  			<c:if test="${g.hwDue.before(today)}">
			  			<!-- <script type="text/javascript">
							console.log("${g.hwName}");
						</script> -->
		  			<p>${g.hwName}</p>
		  			</c:if>
		  		</c:forEach> --%>
		  </div>

		   <div id="todayTask" class="tasklist">
		  	<h3>今日のタスク</h3>
		  		<c:forEach var="s" items="${hwList}">
		  			<c:if test="${s.hwDue.equals(today)}">
		  			<p>${s.hwName}</p>
		  			</c:if>
		  		</c:forEach>
		  </div>

		  <div id="trTask" class="tasklist">
		  	<h3>明日のタスク</h3>
		  		<c:forEach var="v" items="${hwList}">
		  			<c:if test="${v.hwDue.equals(tom)}">
		  			<p>${v.hwName}</p>
		  			</c:if>
		  		</c:forEach>
		  </div>

		  <div id="itemTask" class="tasklist">
			<h3>今週の購入品</h3>
			<p>データが入るよ</p>
		  </div>
		</div>
	   	</div>
	   	<div class="plusBtnWrapper">
	   		<button class="plusBtn" data-izimodal-open="#formWrapper">+</button>
	   	</div>

		<!-- <input type="text" id="current_date"> -->

		  <!-- タスク表示ここまで -->

		  <!-- JavaScript -->
		  <script>
		  date = new Date();
		  year = date.getFullYear();
		  month = date.getMonth() + 1;
		  day = date.getDate();
		  document.getElementById("current_date").value = year + "/" + month + "/" + day;
		  today = document.getElementById("current_date").value;
		  </script>
		  <!-- JavaScriptここまで -->
</html>