<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
    <html lang="en">
    <html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>家事編集画面</title>
    </head>
    <body>
    <h1>家事編集画面</h1>
    <form>
    <p>家事項目名：<input type="text" id="HWName" name="HWname" value="HWName">
    <input type="button" value="クリア" onclick="clearTextHWName()" />
    </p>
    
    <p>実施日：<input type="date" id="HWDate" name="HWDate" value="HWDate" >
    </p>
    
    <p>頻度：<input type="text" id="HWFreq" name="HWFreq" value="HWFreq">
    <select name=”HWFreqselect”>
        <option value=”select”>頻度を選択</option>
        <option value=”day”>日</option>
        <option value=”week”>週</option>
        <option value=”month”>月</option>
        <option value=”year”>年</option>
        <option value=”others”>その他</option>
        <input type="button" value="クリア" onclick="clearTextHWFreq()" />
    </p>
    
    <p>備考：<input type="text" id="HWMemo"  name="HWMemo" value="HWMemo">
    <input type="button" value="クリア" onclick="clearTextHWMemo()" />
    </p>
    <p>
    <input type="submit" value="更新する">
    <button type="button">キャンセル</button>
    </p>
    </form>
    <script>
    
    function checkFormValue(){
        //商品名のチェック
        if(HWName.value == ""){
            alert("家事項目を入力して下さい")
            //submitさせずに戻る
            return false;
        }
        //家事頻度のチェック
        if(HWFreq.value ==""){
            alert("頻度を入力して下さい")
            return false;
        }
        //ここまできたら全てok
        return true
    }
    //家事項目のクリア
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
    
    
    </script>
    </body>
    </html>