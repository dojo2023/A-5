<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>共通画面｜A5アプリ</title>
		<link rel="stylesheet" href="css/common.css">
	</head>
	<body>
		<div class="wrapper">
		  <!-- ロゴ -->
		  <div id="logo">
		 <h1><img src='/img/logo.jpg' alt='ロゴ'></h1>
		  </div>
		  <!-- メニュー -->
		  <nav id="g-nav">
		  <ul id="g-nav-list">
			<li><a href="HomeServlet">カレンダー</a></li>
			<li><a href="ListServlet">一覧</a></li>
			<li><a href="AnalysisServlet">分析</a></li>
		  </ul>
		  </nav>
		  <!-- メニューここまで -->

		  <!-- ログアウト -->
		  <div id="logout"><a href="LogoutServlet">ログアウト</a></div>
		  <!-- 日付表示 -->
		  <div id="current_date"></div>

		  <!-- タスク表示 -->
		  <div id="miss_task">
		  	<h3>未達成タスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="today_task">
		  	<h3>今日のタスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="tr_task">
		  	<h3>明日のタスク</h3>
		  	<p>データが入るよ</p>
		  </div>
		  <div id="item_task">
			<h3>今週の購入品</h3>
			<p>データが入るよ</p>
		  </div>
		  <!-- タスク表示ここまで -->

		</div>

		  <!-- JavaScript -->
		  <script>
		  date = new Date();
		  year = date.getFullYear();
		  month = date.getMonth() + 1;
		  day = date.getDate();
		  document.getElementById("current_date").innerHTML = year + "/" + month + "/" + day;
		  </script>
		  <!-- JavaScriptここまで -->
	</body>
</html>