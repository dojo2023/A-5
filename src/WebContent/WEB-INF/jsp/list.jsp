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
					<button type="button" class="batsu" data-izimodal-close="#itemModalStock${g.itemHisId }">×</button>
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

<script type="text/javascript">
	$(function(){
		$(".iziModal").iziModal();
	});

	function toggleHwFlag(index) {
		alert('非同期');
	    const hwHisId = document.getElementById('hwHisId'+index).value;
	    const hwId = document.getElementById('hwId'+index).value;
	    alert('hwHisId'+index+":"+document.getElementById('hwHisId'+index).value);
	    const hwFlag = document.getElementById('hwCheck'+index);
	    alert(hwFlag.checked);
	    let hwFlagValue = hwFlag.checked ? 1 : 0;
	    alert(hwFlagValue);

	    const data = {
	        hwFlag: hwFlagValue,
	        hwHisId: hwHisId,
	        hwId: hwId
	    }
	  //非同期通信始めるよ
	    $.ajaxSetup({scriptCharset:'utf-8'});
	    $.ajax({
	        //どのサーブレットに送るか
	        //ajaxSampleのところは自分のプロジェクト名に変更する必要あり。
	        url: '/A-five/AjaxServlet',
	        //どのメソッドを使用するか
	        type:"POST",
	        //受け取るデータのタイプ
	        dataType:"json",
	        //何をサーブレットに飛ばすか（変数を記述）
	        data: data,
	        //この下の２行はとりあえず書いてる（書かなくても大丈夫？）
	        processDate:false,
	        timeStamp: new Date().getTime()
	       //非同期通信が成功したときの処理
	    }).done(function(data) {
	        alert("成功1");
	    })
	       //非同期通信が失敗したときの処理
	      .fail(function() {
	        //失敗とアラートを出す
	        alert("失敗！");

	      });
	}






	function toggleItemFlag(index) {
	    const itemHisId = document.getElementById('itemHisId'+index).value;
	    const itemId = document.getElementById('itemId'+index).value;
	    const itemFlag = document.getElementById('itemCheck'+index);
	    alert(itemFlag.checked);
	    let itemFlagValue = itemFlag.checked ? 1 : 0;
	    const data = {
	        itemFlag: itemFlagValue,
	        itemHisId: itemHisId,
	        itemId: itemId
	    }
	    console.log(data);
        clickItemRestock(index, itemFlag.checked, itemId, itemHisId, data);
	}

	//同じものを使うかどうかの確認モーダルを出すよ
	function clickItemRestock(index, flag, itemId, itemHisId, data) {
		let restart = false;
		const itemRestockButton = document.getElementById("itemRestockButton"+index);
		if (flag) {
			console.log(itemRestockButton);
			//「この日用品？」のモーダルを出す。※izimodalはボタンをクリックしないと出てこない
			itemRestockButton.click();

			// 「はい」ボタンのクリックイベントリスナーを追加
	        const yesButton = document.getElementById("itemRestockYes" + itemHisId);
	        yesButton.addEventListener("click", function() {
	            // 「はい」がクリックされたときの処理をここに記述
	            data.restart = true;
	            console.log(data);
	            restockAjax(data)
	        });
			// 「いいえ」ボタンのクリックイベントリスナーを追加
	        const noButton = document.getElementById("itemRestockNo" + itemHisId);
	        noButton.addEventListener("click", function() {
	            // 「いいえ」がクリックされたときの処理をここに記述
	            console.log("いいえがクリックされました");
	            data.restart = true;
	            getStockAjax(itemId, itemHisId, data);
	        });
		} else {
			data.restart = false;
			restockAjax(data);
		}
    }
		//同じものを使う場合のajax
	function restockAjax(data) {
		$.ajaxSetup({scriptCharset:'utf-8'});
	    $.ajax({
	        //どのサーブレットに送るか
	        //ajaxSampleのところは自分のプロジェクト名に変更する必要あり。
	        url: '/A-five/AjaxServlet',
	        //どのメソッドを使用するか
	        type:"POST",
	        //受け取るデータのタイプ
	        dataType:"json",
	        //何をサーブレットに飛ばすか（変数を記述）
	        data: data,
	        //この下の２行はとりあえず書いてる（書かなくても大丈夫？）
	        processDate:false,
	        timeStamp: new Date().getTime()
	       //非同期通信が成功したときの処理
	    }).done(function(data) {
	        alert("成功1");
	        alert(index);
	    })
	       //非同期通信が失敗したときの処理
	      .fail(function() {
	        //失敗とアラートを出す
	        alert("失敗！");
	      });
	}

    //同じ項目で違う商品を使う場合。
    function getStockAjax(itemId, itemHisId, data) {
        $.ajaxSetup({scriptCharset:'utf-8'});
        $.ajax({
            //どのサーブレットに送るか
            //ajaxSampleのところは自分のプロジェクト名に変更する必要あり。
            url: '/A-five/AjaxServlet',
            //どのメソッドを使用するか
            type:"POST",
            //受け取るデータのタイプ
            dataType:"json",
            //何をサーブレットに飛ばすか（変数を記述）
            data: {itemId: itemId},
            //この下の２行はとりあえず書いてる（書かなくても大丈夫？）
            processDate:false,
            timeStamp: new Date().getTime()
            //非同期通信が成功したときの処理
        }).done(function(getData) {
            alert("成功1");
            console.log(getData);
            modalItemEveryDaily(itemHisId, getData, data);
        }).fail(function() {
            //失敗とアラートを出す
            alert("失敗！");
        });
    }

    //newStockAjaxで取得した複数の商品データを表示、選択できる
    function modalItemEveryDaily(itemHisId, listData, data) {
        const content = document.getElementById('itemModalStockContent' + itemHisId);
        content.innerHTML = '';
        const h4 = document.createElement('h4');
        h4.textContent = listData[0].dailyName;
        content.appendChild(h4);

        listData.forEach(function(data) {
            // 新しいdiv要素を生成
            let div = document.createElement("div");
            let itemP = document.createElement("p");
            let volumeP = document.createElement("p");
            let priceP = document.createElement("p");
            let memoP = document.createElement("p");

            itemP.textContent = '商品名：' + data.itemName;
            volumeP.textContent = '容量：' + data.itemVolume + data.dailyUnit;
            priceP.textContent = '価格：' + data.itemPrice + '円';
            memoP.textContent = 'メモ：' + data.itemMemo;
            div.appendChild(itemP);
            div.appendChild(volumeP);
            div.appendChild(priceP);
            div.appendChild(memoP);

            let label = document.createElement('label');
            let radio = document.createElement('input');
            radio.type = 'radio';
            radio.name = 'selectedItem'; // 同じ名前を指定することで選択が相互に排他的になります
            radio.value = data.itemId;

            label.appendChild(radio);
            label.appendChild(div);
            content.appendChild(label);
        });
        content.style.display = 'flex';
        newStockAjax(itemHisId, data);
    }

    function newStockAjax(itemHisId, data) {
    	const yesBtn = document.getElementById('itemStockYes' + itemHisId);
    	console.log(itemHisId + 'aaaaa');
    	yesBtn.addEventListener('click', function() {
    		const selectedItemId = document.querySelector('input[name="selectedItem"]:checked').value;
    		data.itemId = selectedItemId;
    		restockAjax(data);
    	});
    }
</script>
</body>
</html>
