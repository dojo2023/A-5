
        // タブを作るJquery
        $(function() {
            $( "#tabs" ).tabs();
        });

      // 数字を入力系のinputタグで1未満が入力されたらアラートでエラー表示
        let numberInputs = document.querySelectorAll('input[name=itemPrice], input[name=itemVolume], input[name=hwFreq], input[name=itemPeriod], input[name=itemCapacity]');
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
            const inputs = dailyRegistForm.querySelectorAll('input:not([type="hidden"]):not([type="submit"]), select');
            //フラグ
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                hasEmptyInput = empCheck(input, hasEmptyInput);
            });
            if (!hasEmptyInput) {
            	dailyExixtCheck();
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

		/*// 日用品編集フォームのinputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
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
        })*/


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

        //既存の日用品項目を選択したかどうかをチェックし、フラグを使ってサーブレットで判定
        function dailyExixtCheck() {
        	const dailySelect = document.getElementById('dailySelect');
        	const dailyName = document.getElementById('dailyName');
        	const inputValue = dailyName.value;
        	const options = dailySelect.getElementsByTagName('option');
        	let existFlag = false;

        	for (let i = 0; i < options.length; i++) {
                if (options[i].value === inputValue) {
                	existFlag = true;
                    break;
                }
            }
        	const flagInput = document.getElementById('existFlag');
        	flagInput.value = existFlag;
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
        	const dailySelect = document.getElementById('dailySelect');//データリストの親要素
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
				alert("map取得成功");
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
				alert("map取得失敗！");
			  });
		}

