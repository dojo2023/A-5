<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>日用品編集画面</title>
</head>
<body>
<h1>日用品編集画面</h1>
<div id="itemEditModal">
	<form id="itemEditForm">
        <p>商品名:<input type="text" id="itemName" value="後で取得"  name="itemName">
        <input type="button" value="クリア" onclick="clearTextitemName()" />
        </p>

        <p>容量：<input type="text"  id="itemCapacity" value="後で取得"  name="itemCapacity" placeholder="数字を入力">
        <input type="button" value="クリア" onclick="clearTextitemCapacity()" />
        </p>

        <p>値段：<input type="text" id="itemPrice" value="後で取得" name="itemPrice" placeholder="数字を入力">円
            <input type="button" value="クリア" onclick="clearTextitemPrice()" />
        </p>

        <p>使用開始日：<input type="date" value="後で取得" name="startDate">
        </p>
        <p>使用終了日：<input type="date" value="後で取得"  name="endDate">
        </p>

        <p>備考：<input type="text" id="itemRemarks" name="itemRemarks" value="後で取得">
        <input type="button" value="クリア" onclick="clearTextitemRemarks()" />
        </p>
        <p>
        <input type="submit" value="更新する" onclick="return checkFormValue()">
        <button type="button">キャンセル</button>
        </p>
    </form>
</div>
<script type="text/javascript" src="/A-five/js/ItemEdit.js"></script>
<script>

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
</script>
</body>
</html>