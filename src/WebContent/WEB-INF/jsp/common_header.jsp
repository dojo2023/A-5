<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<!-- headerここから -->
		<meta charset="UTF-8">
		<link rel="stylesheet" href="css/common.css">

 <div class="row">
  <div class="col-2 bg-warning">
   <div class="d-flex flex-column">
		  <!-- ロゴ -->
		  <div id="logo">
		 <h1><img src='../img/logo.jpg'  width="100" height="100" alt='ロゴ'></h1>
		  </div>

		  <!-- メニュー -->
		  <nav id="gNav">
		  <ul id="gNavList">
			<li><a href="HomeServlet">カレンダー</a></li>
			<li><a href="ListServlet">一覧</a></li>
			<li><a href="AnalysisServlet">分析</a></li>
		  </ul>
		  </nav>
		  <!-- メニューここまで -->

		  <!-- ログアウト -->
		  <div id="logout"><a href="LogoutServlet">ログアウト</a></div>
		  <!-- 日付表示 -->
		  <div id="currentDate"></div>
    </div>
  </div>
 </div>
<!-- headerここまで -->

</html>