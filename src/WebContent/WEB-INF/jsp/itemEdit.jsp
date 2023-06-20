<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8>"、
<title>日用品編集画面</title>
</head>
<body>
<h1>日用品編集画面</h1>
<form>
<p>商品名:<input type="text" id="itemName" value="itemName"  name="itemName">
<input type="button" value="クリア" onclick="clearTextitemName()" />
</p>

<p>容量：<input type="text"  id="itemCapacity" value="itemCapacity"  name="itemCapacity" placeholder="数字を入力">
<select name=”itemUnit” id="itemUnit" value="itemUnit">
    <option value=”select”>単位を選択</option>
    <option value=”ml”>ml</option>
    <option value=”g”>g</option>
    <option value=”ko”>個</option>
    <option value=”m”>メートル</option>
    <option value=”hon”>本</option>
<input type="button" value="クリア" onclick="clearTextitemCapacity()" />
</p>

<p>値段：<input type="text" id="itemPrice" value="itemPrice" name="itemPrice" placeholder="数字を入力">円
    <input type="button" value="クリア" onclick="clearTextitemPrice()" />
</p>

<p>使用開始日：<input type="date" value="startDate" name="startDate">
</p>
<p>使用終了日：<input type="date" value="endDate"  name="endDate">
</p>

<p>備考：<input type="text" id="itemRemarks" name="itemRemarks" value="itemRemarks">
<input type="button" value="クリア" onclick="clearTextitemRemarks()" />
</p>
<p>
<input type="submit" value="更新する" onclick="return checkFormValue();">
<button type="button">キャンセル</button>
</p>
</form>
<script>

function checkFormValue(){
    //商品名のチェック
    if(itemName.value == ""){
        alert("商品名を入力して下さい")
        //submitさせずに戻る
        return false;
    }
    //容量のチェック
    if(itemCapacity.value ==""){
        alert("容量を入力して下さい")
        return false;
    }
    //値段のチェック
    if(itemPrice.value ==""){
        alert("値段を入力して下さい")
        return false;
    }
    //ここまできたら全てok
    return true
}

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