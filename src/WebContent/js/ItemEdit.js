

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

