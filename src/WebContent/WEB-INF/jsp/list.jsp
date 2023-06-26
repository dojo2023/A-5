<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.0.min.js"></script>

<link href="/A-five/css/iziModal.css" rel="stylesheet" type="text/css">
<link href="/A-five/css/list.css" rel="stylesheet" type="text/css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/js/iziModal.min.js"></script>

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


			<c:forEach var="g" items="${itemlist}" varStatus ="status">

			<form method="GET" action="/A-five/ListServlet">
			<c:if test="${!g.itemFlag}">

				<tr>
					<td>${g.dailyName}<br>${g.itemName}</td>
					<td><button type="button" data-izimodal-open="#itemModal${g.itemHisId}">詳細</button></td>
					<td>${g.itemDue}</td>
					<td>あと日</td>
					<td><input id= "itemCheck${status.index}" type="checkbox" onchange="toggleItemFlag(${status.index})"></td>
					<td><input type="checkbox">
						<input type="hidden" id="itemHisId${status.index}" value="${g.itemHisId}">
						<input type="hidden" id="itemId${status.index}" value="${g.itemId}">
						<button id="itemRestockButton${status.index}" data-izimodal-open="#itemModalRestock${g.itemHisId}" style="display: none;"></button>

					<div id="itemModalRestock${g.itemHisId}" class="iziModal" >

					<button type="button" class="batsu" data-izimodal-close="#itemModalRestock${g.itemHisId }">×</button>
					<h4>この日用品を使い続けますか？</h4>
					<hr>
					<p>項目名:${g.dailyName}</p>
					<p>商品名：${g.itemName}</p>
					<p>	容量:${g.itemVolume}${g.dailyUnit}</p>
					<p>使用開始日:${g.itemStart}</p>
					<p>使用終了日:${g.itemDue}</p>
					<p>備考:${g.itemMemo}</p>

					<button id="itemRestockYes${g.itemHisId }" type="button" class="editButton" data-izimodal-close="#itemModalRestock${g.itemHisId }">はい</button>
					<button id="itemRestockNo${g.itemHisId }" type="button" class="deleteButton" data-izimodal-open="#itemModalStock${g.itemHisId}">いいえ</button>

					</div>

					<div id="itemModalStock${g.itemHisId}" class="iziModal">
					<button id="itemStockBatsu${g.itemHisId}" type="button" class="batsu" data-izimodal-close="#itemModalStock${g.itemHisId }">×</button>
					<div id="itemModalStockContent${g.itemHisId}" class="itemModalStockContent"></div>
					<button id="itemStockYes${g.itemHisId}" type="button" class="editButton">はい</button>
					<button type="button" class="deleteButton">いいえ</button>
					</div>


					<!-- 日用品のモーダル -->
				<div id="itemModal${g.itemHisId}" class="iziModal" >
					<button type="button" class="batsu" data-izimodal-close="#itemModal${g.itemHisId }">×</button>
					<h4>項目名:${g.dailyName}</h4>
					<hr>
					<p>商品名：${g.itemName}</p>
					<p>	容量:${g.itemVolume}${g.dailyUnit}</p>
					<p>使用開始日:${g.itemStart}</p>
					<p>使用終了日:${g.itemDue}</p>
					<p>備考:${g.itemMemo}</p>
					<h2>履歴</h2>

				<c:forEach var="h" items="${itemlist}" varStatus ="status">
				<c:if test="${h.itemId == g.itemId}">
					<p>商品名：${h.itemName}</p>
					<p>	容量:${h.itemVolume}${h.dailyUnit}</p>
					<p>使用開始日:${h.itemStart}</p>
					<p>使用終了日:${h.itemFin}</p>
					<p>備考:${h.itemMemo}</p>
					<br>
				</c:if>
				</c:forEach>


						<button type="button" class="editButton">編集</button>
						<button type="button" class="deleteButton">削除</button>
				</div>

					</td>

				</tr>

			</c:if>

			</form>
		    </c:forEach>

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





			<c:forEach var="e" items="${hwList}" varStatus ="status">



			<form method="GET" action="/A-five/ListServlet">
			<c:if test="${!e.hwFlag}">
				<tr>
					<td>${e.hwName}</td>
					<td><button type="submit" data-izimodal-open="#HWModal${e.hwHisId}" >詳細</button></td>
					<td>${e.hwFreq}日</td>
					<td>${e.hwDue}</td>
					<td><input type="checkbox" id="hwCheck${status.index}" onchange="toggleHwFlag(${status.index})">
					<input type="hidden" id="hwHisId${status.index}" value="${e.hwHisId}">
					<input type="hidden" id="hwId${status.index}" value="${e.hwId}">

			<div id="HWModal${e.hwHisId}" class="iziModal" >


			<button type="button" class="batsu" data-izimodal-close="#HWModal${e.hwHisId}">×</button>
			<h4>${e.hwName}</h4>
			<hr>

			<p>目標頻度:${e.hwFreq}日に一回</p>
			<p>次回実施日：${e.hwDue}</p>
			<p>備考:${e.hwMemo}</p>

			<h2>履歴</h2>

			<c:forEach var="f" items="${hwList}">

			<c:if test="${f.hwId == e.hwId}">

			<p>${f.hwDate}</p>


			</c:if>
			</c:forEach>

			<br>
			<br>

				<button type="button" class="editButton">編集</button>
				<button type="button" class="deleteButton">削除</button>

			</div>

					</td>

				</tr>

			</c:if>


			</form>

			</c:forEach>




			</table>
		</div>
	</div>
</div>

<!--  日用品のモーダル
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
 -->
<!-- 家事のモーダル -->
<!-- <div id="HWModal" class="iziModal" >

	<form method="GET" action="/A-five/ListServlet">

	<button type="button" class="batsu" data-izimodal-close="#HWModal">×</button>
	<h4>シンク掃除</h4>
	<hr>
	<p>目標頻度：1週間に1回</p>
	<h2>履歴</h2>
	<br>
	<br>
	</form>
		<button type="button" class="editButton">編集</button>
		<button type="button" class="deleteButton">削除</button>
</div> -->

<script type="text/javascript" src="/A-five/js/List.js"></script>
</body>
</html>
