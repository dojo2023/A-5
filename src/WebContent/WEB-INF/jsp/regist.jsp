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
<!-- <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css"> -->
</head>
<body>
    <!--全体を囲う-->
    <div id="tabs">
        <!-- タブ-->
        <div>
            <ul>
                <li><a href="#tabs-1"> 日用品登録</a></li>
                <li><a href="#tabs-2"> 家事登録<%= request.getAttribute("due") %></a></li>
            </ul>
        </div>
        <!-- CSSで罰ボタンを -->
        <!-- 日用品登録フォーム-->
        <div id="tabs-1">
            <form id="dailyRegistForm" action="" method="post">
                <input id="daily_name" name="daily_name" type="text"
                    placeholder="日用品項目" style="display: none;"> <select
                    id="daily_select" name="daily_select">
                    <!-- foreachでユーザー毎の日用品項目を取得。日用品情報テーブル -->
                    <option value="shanpoo">シャンプー</option>
                    <option value="wash">洗剤</option>
                    <option value="tissue">ティッシュ</option>
                    <option value="create">新規作成</option>
                </select> <input name="item_name" type="text" placeholder="商品名"> <input
                    name="item_price" type="text" placeholder="値段"> <input
                    name="item_volume" type="text" placeholder="容量"> <select
                    id="unit" name="unit">
                    <!-- 日用品項目と単位はマップ -->
                    <option value="ml">ml</option>
                    <option value="box">箱</option>
                </select> <input name="item_memo" type="text" placeholder="メモ(100字まで)"
                    max="100"> <input name="item_submit" type="submit"
                    value="登録">
            </form>
        </div>
        <!-- 家事登録フォーム-->
        <div id="tabs-2">
            <form id="HwRegistForm" action="" method="post">
                <input type="text" placeholder="家事項目"> <input name="hw_freq"
                    type="text" min="0" placeholder="目標頻度"> <select name="unit">
                    <option value="1">日</option>
                    <option value="7">週</option>
                    <option value="30">月</option>
                </select> <input type="text" placeholder="メモ"> <input type="submit"
                    value="登録">
            </form>
        </div>
    </div>
    <script>
        // タブを作るJquery
        $(function() {
            $( "#tabs" ).tabs();
        });
        // 数字を入力系のinputタグで1未満が入力されたらアラートでエラー表示
        let numberInputs = document.querySelectorAll('input[name=item_price], input[name=item_volume], input[name=hw_freq]');
        numberInputs.forEach(function(input){
            input.addEventListener('blur', function(){
                let inputValue = input.value.trim();
                let halfWidthValue = convertFullWidthToHalfWidth(inputValue);
                let parsedValue = parseInt(halfWidthValue, 10);
                if (isNaN(parsedValue) || parsedValue < 1) {
                    alert('1以上を入力')
                    input.value = '';
                } else {
                    input.value = halfWidthValue;
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
        let daily_select = document.getElementById('daily_select');
        let daily_name = document.getElementById('daily_name');
        daily_select.addEventListener('change', function() {
            if (daily_select.value == 'create') {
                daily_name.style.display = 'block';
            } else {
                daily_name.style.display = 'none';
            }
        })
// inputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
        let dailyRegistForm = document.getElementById('dailyRegistForm');
        dailyRegistForm.addEventListener('submit', function(event) {
            let inputs = dailyRegistForm.querySelectorAll('input:not([type="submit"]), select');
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                let error = input.nextElementSibling;
                if (input.style.display !== 'none' && input.value.trim() === '') {
                    hasEmptyInput = true;
                    if (!error || !error.classList.contains('error-message')) {
                        event.preventDefault();
                        error = document.createElement('div');
                        error.classList.add('error-message');
                        error.textContent = '中身が空です';
                        input.parentNode.insertBefore(error, input.nextElementSibling);
                    }
                } else {
                    event.preventDefault();
                    if (error && error.classList.contains('error-message')) {
                        error.remove();
                    }
                }
            });
            if (!hasEmptyInput) {
                if (confirm('本当に送信しますか？')) {
                    dailyRegistForm.submit(); // フォームを送信
                }
            }
        })
        // 日用品項目の選択を変えたら、それに応じて単位もかわからない
        const mappingData = {
            shanpoo: 'ml',
            wash: 'ml',
            tissue: 'box',
        }
        const dailySelect = document.getElementById('daily_select');
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
        // inputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
        let HwRegistForm = document.getElementById('HwRegistForm');
        HwRegistForm.addEventListener('submit', function(event) {
            let inputs = HwRegistForm.querySelectorAll('input:not([type="submit"]), select');
            let hasEmptyInput = false;
            inputs.forEach(function(input) {
                let error = input.nextElementSibling;
                if (input.value.trim() === '') {
                    hasEmptyInput = true;
                    if (!error || !error.classList.contains('error-message')) {
                        event.preventDefault();
                        error = document.createElement('div');
                        error.classList.add('error-message');
                        error.textContent = '中身が空です';
                        input.parentNode.insertBefore(error, input.nextElementSibling);
                    }
                } else {
                    event.preventDefault();
                    if (error && error.classList.contains('error-message')) {
                        error.remove();
                    }
                }
            });
            if (!hasEmptyInput) {
                if (confirm('本当に送信しますか？')) {
                    HwRegistForm.submit(); // フォームを送信
                }
            }
        })
    </script>
</body>
</html>





