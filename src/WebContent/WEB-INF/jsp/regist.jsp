<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登録</title>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
    src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
</head>
<body>
    <!--全体を囲う-->
	<div id="tabs">
		<!-- タブ-->
		<div>
            <ul>
                <li><a href="#tabs1"> 日用品登録</a></li>
                <li><a href="#tabs2"> 家事登録</a></li>
            </ul>
		</div>
        <!-- CSSで罰ボタンを -->
        <!-- 日用品登録フォーム-->
        <div id="tabs1">
            <form id="dailyRegistForm" action="/A-five/RegistServlet" method="post">
                <input id="dailyName" name="dailyName" type="text" placeholder="日用品項目" list="dailySelect">
                <datalist id="dailySelect" name="dailySelect">

                </datalist>
                <input name="itemName" type="text" placeholder="商品名" >
                <input name="itemPrice" type="text" placeholder="値段">
                <input name="itemVolume" type="text" placeholder="容量">
                <input id="dailyUnit" name="dailyUnit" type="text" placeholder="単位" list="unitSelect">
                <datalist id="unitSelect" name="unitSelect">
                    <!-- 日用品項目と単位はマップ -->
                </datalist>
                <input name="itemMemo" type="text" placeholder="メモ(100字まで)" max="100">
                <input name="itemStart" type="date" placeholder="使用開始日">
                <input name="itemPeriod" type="text" placeholder="予測使用日数">
                <input name="regist" type="hidden" value="itemSubmit">
                <button type="submit">登録</button>
            </form>
        </div>
        <!-- 家事登録フォーム-->
        <div id="tabs2">
            <form id="hwRegistForm" action="/A-five/RegistServlet" method="post">
                <input name="hwName" type="text" placeholder="家事項目" list="hwSelect">
                <datalist id="hwSelect">
                	<c:forEach var="item" items="${itemlist}">
                		<option>${item.dailyName}</option>
                	</c:forEach>
                </datalist>
                <input name="hwFreq" type="text" min="0" placeholder="目標頻度">
                <select name="freqUnit">
                    <option value="1">日</option>
                    <option value="7">週</option>
                    <option value="30">月</option>
                </select>
                <input name="hwMemo" type="text" placeholder="メモ">
                <input name="regist" type="hidden" value="hwSubmit">
                <button type="submit">登録</button>
            </form>
        </div>
	</div>
	<c:if test="{not empty result}">
		<script type="text/javascript">alert(result);</script>
	</c:if>
    <script>


        // タブを作るJquery
        $(function() {
            $( "#tabs" ).tabs();
        });

        // 数字を入力系のinputタグで1未満が入力されたらアラートでエラー表示
        let numberInputs = document.querySelectorAll('input[name=itemPrice], input[name=itemVolume], input[name=hwFreq], input[name=itemDue]');
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




        // 日用品登録フォームのinputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
        const dailyRegistForm = document.getElementById('dailyRegistForm');
        dailyRegistForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const inputs = dailyRegistForm.querySelectorAll('input:not([type="submit"]), select');
            //フラグ
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                hasEmptyInput = empCheck(input, hasEmptyInput);
            });
            if (!hasEmptyInput) {
                if (confirm('本当に送信しますか？')) {
                    dailyRegistForm.submit(); // フォームを送信
                }
            }
        })

        // 家事登録フォームのinputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
        const HwRegistForm = document.getElementById("hwRegistForm");
        HwRegistForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const inputs = HwRegistForm.querySelectorAll('input:not([type="submit"]), select');
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                hasEmptyInput = empCheck(input, hasEmptyInput);
            });
            if (!hasEmptyInput) {
                if (confirm('本当に送信しますか？')) {
                	HwRegistForm.submit();
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


        // mappingDataにはこんなマップデータが入ってる
        /* [{
            シャンプー: 'ml',
            食器用洗剤: 'ml',
            ティッシュ: 'box'
        } ,{
            シャンプー: 'ml',
            食器用洗剤: 'ml',
            ティッシュ: 'box'
        } ] */

        //mappingDataはデータベースから持ってくる
        //日用品項目と日用品の単位をマッピング
        function unitSet(mappingData) {
        	const dailySelect = document.getElementById('dailySelect');
            const dailyName = document.getElementById('dailyName');
        	//日用品項目の予測補完をoptionタグで作成
        	mappingData.forEach(function(value, key) {
        	    let option = document.createElement('option');
	            option.classList.add(key);
	            option.value = key;
	            option.textContent = key;
	            //dailySelectの子要素として挿入
	            dailySelect.appendChild(option);
        	});
			const dailyUnit = document.getElementById('dailyUnit');
	        const unitSelect = document.getElementById('unitSelect');
	        //日用品の項目に応じて単位を変える
	        dailyName.addEventListener('blur', function() {
	            let unit = mappingData.get(dailyName.value);
	            if (unit) {
	            	dailyUnit.value = unit;
	            } else {
	            	dailyUnit.value = '';
	            }
	        });
        }
		window.onload = goAjax;
       	function goAjax(){
			alert("functionはいったよ！");
			//非同期通信始めるよ
			$.ajaxSetup({scriptCharset:'utf-8'});
			$.ajax({
				//どのサーブレットに送るか
				//ajaxSampleのところは自分のプロジェクト名に変更する必要あり。
				url: '/A-five/AjaxServlet',
				//どのメソッドを使用するか
				type:"GET",
				//受け取るデータのタイプ
				dataType:"json",
				//この下の２行はとりあえず書いてる（書かなくても大丈夫？）
				processDate:false,
				timeStamp: new Date().getTime()
			}).done(function(data) {
				alert("成功1");
				let mappingData = new Map();
				Object.entries(data).forEach(function([key, value]) {
					mappingData.set(key, value);
				  });
				console.log(mappingData);
				unitSet(mappingData);
				/* const mappingData = JSON.stringify(data);
				console.log(mappingData); */
				/* const dataArray = JSON.parse(data);
				const mappingData = {};
				dataArray.forEach(function(item) {
					console.log(item.dailyName);
				})
				console.log(data + 'hdfalkda'); */
			  })
			  .fail(function() {
				alert("失敗！");
			  });
		}


    </script>
    ${ dailyJson}
</body>
</html>





