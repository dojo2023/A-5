<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- headerここから -->
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/common.css">

 <div class="row">
   <div class="d-flex flex-row">
		  <!-- ロゴ -->
		  <div id="logo">
		 <h1><img src='../img/HW_icon.png.jpg'  width="100" height="100" alt='ロゴ'></h1>
		  </div>

		  <!-- メニュー -->
		  <nav id="gNav">
		  <ul id="gNavList">
			<li><a href="/A-five/HomeServlet">カレンダー</a></li>
			<li><a href="/A-five/ListServlet">一覧</a></li>
			<li><a href="/A-five/AnalysisServlet">分析</a></li>
			<li><a href="/A-five/LogoutServlet">ログアウト</a></li>
			<!-- <li> 日付表示
		  			<div id="currentDate"></div></li> -->
		  </ul>
		  </nav>
		  <!-- メニューここまで -->

		  <!-- ログアウト -->
		  <!-- <div id="logout"><a href="LogoutServlet">ログアウト</a></div> -->
		  <!-- 日付表示 -->
		  <!-- <div id="currentDate"></div> -->
    </div>
  </div>
<!-- headerここまで -->

</html>