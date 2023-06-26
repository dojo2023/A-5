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
	        alert("toggleHwFlag成功");
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
		//同じものを使う場合のajax。これもループ入り
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
	        alert("restockAjax成功1");
	    })
	       //非同期通信が失敗したときの処理
	      .fail(function() {
	        //失敗とアラートを出す
	        alert("restockAjax失敗！");
	      });
	}

    //同じ項目で違う商品を使う場合。何故かこれがループされてる
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
            alert("getStockAjax成功1");
            console.log(getData);
            modalItemEveryDaily(itemHisId, getData, data);
        }).fail(function() {
            //失敗とアラートを出す
            alert("getStockAjax失敗！");
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
    	const batsuBtn = document.getElementById('itemStockBatsu' + itemHisId);
    	yesBtn.addEventListener('click', function() {
    		const selectedItemId = document.querySelector('input[name="selectedItem"]:checked').value;
    		data.itemId = selectedItemId;
    		restockAjax(data);
    		batsuBtn.click();
    	});
    }