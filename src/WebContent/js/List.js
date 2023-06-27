

	$(function(){
			$(".iziModal").iziModal();
		});
	$(function() {
	            $( "#tabs" ).tabs();
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


/*日用品編集画面*/

window.onload = function() {
function clearTextitemName() {
	var textForm = document.getElementById("itemName");
  textForm.value = '';
}

function clearTextitemCapacity() {
	var textForm = document.getElementById("itemCapacity");
  textForm.value = '';
}

function clearTextitemPrice() {
	var textForm = document.getElementById("itemPrice");
  textForm.value = '';
}

function clearTextitemRemarks() {
	var textForm = document.getElementById("itemRemarks");
  textForm.value = '';
}

// 数字を入力系のinputタグで1未満が入力されたらアラートでエラー表示
let numberInputs = document.querySelectorAll('input[name=itemPrice], input[name=itemVolume], input[name=hwFreq], input[name=itemPeriod], input[name=itemCapacity], input[name=HWFreq]');
// 値段・容量・目標頻度の入力欄をforeach
numberInputs.forEach(function(input){
    // blur：次の入力欄が選択されたら
    input.addEventListener('blur', function(){
    	numCheck(input);
    })
})

//数字のエラーチェックをする関数
function numCheck(input) {
    let inputValue = input.value.trim();
    let halfWidthValue = convertFullWidthToHalfWidth(inputValue);
    let parsedValue = parseInt(halfWidthValue, 10);
    let errorNum = input.nextElementSibling;
    if (isNaN(parsedValue) || parsedValue < 1) {
        if (errorNum.classList.contains('errorMessage')) {
            errorNum.textContent = '1以上の数値を入力してください';
        } else {
            //divタグのerrorクラスを作成
            errorNum = document.createElement('div');
            errorNum.classList.add('errorMessage');
            errorNum.textContent = '1以上の数値を入力してください';
            //inputの親要素（form）を取得。insertBefore(入れたいもの, どこの前に入れるか)
            input.parentNode.insertBefore(errorNum, input.nextElementSibling);
        }
        input.value = '';
    } else {
        if (errorNum.classList.contains('errorMessage')) {
            errorNum.remove();
        }
        input.value = parsedValue;
    }
}

function convertFullWidthToHalfWidth(input) {
// 全角数字を半角数字に変換
let halfWidth = input.replace(/[０-９]/g, function(match) {
    return String.fromCharCode(match.charCodeAt(0) - 0xFEE0);
});

return halfWidth;
}
// 日用品項目のプルダウンメニューで新規登録を選択したら、入力フィールドが出現

// 日用品編集フォームのinputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
const itemEditForm = document.getElementById("itemEditForm");
itemEditForm.addEventListener('submit', function(event) {
    event.preventDefault();
    const inputs = itemEditForm.querySelectorAll('input:not([type="submit"]), select');
    let hasEmptyInput = false;
    inputs.forEach(function(input) {
        hasEmptyInput = empCheck(input, hasEmptyInput);
    });
    if (!hasEmptyInput) {
        if (confirm('本当に送信しますか？')) {
        	itemEditForm.submit();
        }
    }
})


// 空チェック。booleanを返す
function empCheck(input, hasEmptyInput) {
    //次の要素を取得
    let error = input.nextElementSibling;
    if (input.style.display !== 'none' && input.value.trim() === '') {
        hasEmptyInput = true;
        if (error.classList.contains('errorMessage')) {
            error.textContent = '中身が空です';
        } else {
            error = document.createElement('div');
            error.classList.add('errorMessage');
            error.textContent = '中身が空です';
            //親要素を取得。次の要素の前にerrorを入れる
            input.parentNode.insertBefore(error, input.nextElementSibling);
        }
    } else {
        if (error && error.classList.contains('errorMessage')) {
            error.remove();
        }
    }
    return hasEmptyInput;
}

/*家事編集画面*/

 function clearTextHWName() {
        var textForm = document.getElementById("HWName");
      textForm.value = '';
    }
    //家事頻度のクリア
    function clearTextHWFreq() {
        var textForm = document.getElementById("HWFreq");
      textForm.value = '';
    }
    //備考（家事）のクリア
    function clearTextHWMemo() {
        var textForm = document.getElementById("HWMemo");
      textForm.value = '';
    }


// 家事編集フォームのinputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
/*const hwEditForm = document.getElementById("hwEditForm");
hwEditForm.addEventListener('submit', function(event) {
    event.preventDefault();
    const inputs = hwEditForm.querySelectorAll('input:not([type="submit"]), select');
    let hasEmptyInput = false;
    inputs.forEach(function(input) {
        hasEmptyInput = empCheck(input, hasEmptyInput);
    });
    if (!hasEmptyInput) {
        if (confirm('本当に送信しますか？')) {
        	hwEditForm.submit();
        }
    }
})*/
}