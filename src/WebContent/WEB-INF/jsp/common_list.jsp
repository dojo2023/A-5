<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" type="text/css" href="/A-five/css/common.css">

		  <!-- タスク表示 -->

	   <div class="col-2 bg-warning">
		<div class="d-flex flex-column">
		  <div id="missTask">
		  	<h3>未達成タスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="todayTask">
		  	<h3>今日のタスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="trTask">
		  	<h3>明日のタスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="itemTask">
			<h3>今週の購入品</h3>
			<p>データが入るよ</p>
		  </div>
		</div>
	   </div>


		  <!-- タスク表示ここまで -->

		  <!-- JavaScript -->
		  <script>
		  date = new Date();
		  year = date.getFullYear();
		  month = date.getMonth() + 1;
		  day = date.getDate();
		  document.getElementById("current_date").innerHTML = year + "/" + month + "/" + day;
		  </script>
		  <!-- JavaScriptここまで -->
</html>