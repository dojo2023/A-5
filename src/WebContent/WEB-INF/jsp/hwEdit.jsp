<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!DOCTYPE html>
    <html>
    <head>
    <link rel="stylesheet" href "A-five/css/edit.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>家事編集画面</title>
    </head>
    <body>
    <h1>家事編集画面</h1>
    <div id="hwEditModal">
	    <form id="hwEditForm">
		    <p>家事項目名：<input type="text" id="HWName" name="HWname" value="HWName">
		    <input type="button" value="クリア" onclick="clearTextHWName()" />
		    </p>

		    <p>実施日：<input type="date" id="HWDate" name="HWDate" value="HWDate" >
		    </p>

		    <p>頻度：<input type="text" id="HWFreq" name="HWFreq" value="HWFreq">
		        <input type="button" value="クリア" onclick="clearTextHWFreq()" />
		    </p>

		    <p>メモ：<input type="text" id="HWMemo"  name="HWMemo" value="HWMemo" placeholder= "メモ（100字まで）" max="100">
		    <input type="button" value="クリア" onclick="clearTextHWMemo()" />
		    </p>
		    <p>
		    <input type="submit" value="更新する">
		    <button type="button">キャンセル</button>
		    </p>
	    </form>
    </div>
    <script type="text/javascript" src="/A-five/js/HWEdit.js"></script>
    <script>
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