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
    <p>家事項目名：<input type="text" id="HWname" ="HWname">
    <input type="button" value="クリア" onclick="clearTextHWname()" />
    </p>
    
    <p>実施日：<input type="date">
    </p>
    
    <p>頻度：<input type="text" id="HWfrequency" name="HWfrequency">
    <select name=”HWfrequencyselect”>
        <option value=”select”>頻度を選択</option>
        <option value=”day”>日</option>
        <option value=”week”>週</option>
        <option value=”month”>月</option>
        <option value=”year”>年</option>
        <option value=”others”>その他</option>
        <input type="button" value="クリア" onclick="clearTextHWfrequency()" />
    </p>
    
    <p>備考：<input type="text" id="HWremarks"  name="HWremarks">
    <input type="button" value="クリア" onclick="clearTextHWremarks()" />
    </p>
    
    <p>
    <input type="submit" value="更新する">
    <button type="button">キャンセル</button>
    </p>
    </form>
    <script>
    
    function checkFormValue(){
        //商品名のチェック
        if(HWname.value == ""){
            alert("家事項目を入力して下さい")
            //submitさせずに戻る
            return false;
        }
        //家事頻度のチェック
        if(HWfrequency.value ==""){
            alert("頻度を入力して下さい")
            return false;
        }
        //ここまできたら全てok
        return true
    }
    //家事項目のクリア
    function clearTextHWname() {
        var textForm = document.getElementById("HWname");
      textForm.value = '';
    }
    //家事頻度のクリア
    function clearTextHWfrequency() {
        var textForm = document.getElementById("HWfrequency");
      textForm.value = '';
    }
    //備考（家事）のクリア
    function clearTextHWremarks() {
        var textForm = document.getElementById("HWremarks");
      textForm.value = '';
    }
    
    
    </script>
    </body>
    </html>