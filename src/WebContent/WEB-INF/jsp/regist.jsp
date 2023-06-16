<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            <form id="dailyRegistForm" action="" method="post">
                <input id="dailyName" name="dailyName" type="text" placeholder="日用品項目" style="display: none;">
                <select id="dailySelect" name="dailySelect">
                    <!-- foreachでユーザー毎の日用品項目を取得。日用品情報テーブル -->
                    <option value="shanpoo">シャンプー</option>
                    <option value="wash">洗剤</option>
                    <option value="tissue">ティッシュ</option>
                    <option value="create">新規作成</option>
                </select>
                <input name="itemName" type="text" placeholder="商品名">
                <input name="itemPrice" type="text" placeholder="値段">
                <input name="itemVolume" type="text" placeholder="容量">
                <select id="unit" name="unit">
                    <!-- 日用品項目と単位はマップ -->
                    <option value="ml">ml</option>
                    <option value="box">箱</option>
                </select>
                <input name="itemMemo" type="text" placeholder="メモ(100字まで)" max="100">
                <input name="itemSubmit" type="submit" value="登録">
            </form>
        </div>
        <!-- 家事登録フォーム-->
        <div id="tabs2">
            <form id="hwRegistForm" action="" method="post">
                <input type="text" placeholder="家事項目">
                <input name="hwFreq" type="text" min="0" placeholder="目標頻度">
                <select name="unit">
                    <option value="1">日</option>
                    <option value="7">週</option>
                    <option value="30">月</option>
                </select>
                <input type="text" placeholder="メモ">
                <input type="submit" value="登録">
            </form>
        </div>
	</div>
    <script>
        // タブを作るJquery
        $(function() {
            $( "#tabs" ).tabs();
        });

        // 数字を入力系のinputタグで1未満が入力されたらアラートでエラー表示
        let numberInputs = document.querySelectorAll('input[name=itemPrice], input[name=itemVolume], input[name=hwFreq]');
        // 値段・容量・目標頻度の入力欄をforeach
        numberInputs.forEach(function(input){
            // blur：次の入力欄が選択されたら
            input.addEventListener('blur', function(){
                //.trim()：入力された文字の前後のスペースをなくす→スペースだけで送信させない
                let inputValue = input.value.trim();
                //全角を半角に変換
                let halfWidthValue = convertFullWidthToHalfWidth(inputValue);
                //10は10進数であることを示す
                let parsedValue = parseInt(halfWidthValue, 10);
                //nextElementSibilingは兄弟要素を取得。値段の入力欄の場合、次の要素である容量の入力欄を取得（35行目）
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
            })
        })
        function convertFullWidthToHalfWidth(input) {
        // 全角数字を半角数字に変換
        let halfWidth = input.replace(/[０-９]/g, function(match) {
            return String.fromCharCode(match.charCodeAt(0) - 0xFEE0);
        });

        return halfWidth;
        }

        // 日用品項目のプルダウンメニューで新規登録を選択したら、入力フィールドが出現
        let daily_select = document.getElementById('dailySelect');
        let daily_name = document.getElementById('dailyName');
        daily_select.addEventListener('change', function() {
            if (daily_select.value == 'create') {
                daily_name.style.display = 'block';
            } else {
                daily_name.style.display = 'none';
            }
        })


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
        const HwRegistForm = document.getElementById('hwRegistForm');
        HwRegistForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const inputs = HwRegistForm.querySelectorAll('input:not([type="submit"]), select');
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                hasEmptyInput = empCheck(input, hasEmptyInput);
            });
            if (!hasEmptyInput) {
                if (confirm('本当に送信しますか？')) {
                    HwRegistForm.submit(); // フォームを送信
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

        // 日用品項目の選択を変えたら、それに応じて単位もかわからない
        const mappingData = {
            shanpoo: 'ml',
            wash: 'ml',
            tissue: 'box',
        }
        const dailySelect = document.getElementById('dailySelect');
        const unitSelect = document.getElementById('unit');
        dailySelect.addEventListener('change', function() {
            let selectedDaily = dailySelect.value;
            let unit = mappingData[selectedDaily];
            if (unit) {
                unitSelect.value = unit;
            } else {
                unitSelect.value = 'ml';
            }
        });

    </script>
</body>
</html>





