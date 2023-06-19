<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.0.min.js"></script>

<link href="/A-five/css/iziModal.css" rel="stylesheet" type="text/css">
<link href="/A-five/css/list.css" rel="stylesheet" type="text/css">
<script src="/A-five/js/iziModal.min.js"></script>

</head>
<body>
<div class="tabWrap">
	<input id="itemTab" type="radio" name="tab_btn" checked>
    <input id="HWTab" type="radio" name="tab_btn">

	<div class="tabArea">
        <label class="itemTabLabel" for="itemTab">日用品</label>
        <label class="HWTabLabel" for="HWTab">家事</label>
    </div>

	<div class="panelArea">

		<div id="itemPanel" class="tabPanel">

			<table class="table">
				<tr>
					<th>日用品項目</th>
					<th></th>
					<th>予測終了日</th>
					<th>日数</th>
					<th>補充</th>
					<th>使用終了</th>
				</tr>

				<tr>
					<td>シャンプー<br>メリット</td>
					<td><button type="button" data-izimodal-open="#itemModal">詳細</button></td>
					<td>06/14</td>
					<td>あと５日</td>
					<td><input type="checkbox"></td>
					<td><input type="checkbox"></td>
				</tr>
			</table>
		</div>

		<div id="HWPanel" class="tabPanel">
			<table class="table">
				<tr>
					<th>家事項目</th>
					<th></th>
					<th>目標頻度</th>
					<th>期限</th>
					<th>完了</th>
				</tr>
				<tr>
					<td>シンク掃除</td>
					<td><button type="button" data-izimodal-open="#HWModal">詳細</button></td>
					<td>週一回</td>
					<td>あと四日</td>
					<td><input type="checkbox"></td>
				</tr>
			</table>
		</div>
	</div>
</div>

<!-- 日用品のモーダル -->
<div id="itemModal" class="iziModal" >
	<button type="button" class="batsu" data-izimodal-close="#itemModal">×</button>
	<h4>項目名:シャンプー</h4>
	<hr>
	<p>商品名：メリット</p>
	<p>	容量:300ml</p>
	<p>使用開始日:2023/04/16</p>
	<p>使用終了日:2023/06/26</p>
	<p>備考:特売セール</p>

	<h2>履歴</h2>
	<p>商品名：メリット</p>
	<p>	容量:300ml</p>
	<p>使用開始日:2023/04/16</p>
	<p>使用終了日:2023/06/26</p>
	<p>備考:特売セール</p>
	<br>
	<p>商品名：メリット</p>
	<p>	容量:300ml</p>
	<p>使用開始日:2023/04/16</p>
	<p>使用終了日:2023/06/26</p>
	<p>備考:特売セール</p>
	<br>
	<br>



		<button type="button" class="editButton">編集</button>
		<button type="button" class="deleteButton">削除</button>
</div>

<!-- 家事のモーダル -->
<div id="HWModal" class="iziModal" >
	<button type="button" class="batsu" data-izimodal-close="#HWModal">×</button>
	<h4>シンク掃除</h4>
	<hr>
	<p>目標頻度：1週間に1回</p>
	<h2>履歴</h2>
	<br>
	<br>

		<button type="button" class="editButton">編集</button>
		<button type="button" class="deleteButton">削除</button>
</div>

<script type="text/javascript">
	$(function(){
		$(".iziModal").iziModal();
	});

</script>
</body>
</html>
