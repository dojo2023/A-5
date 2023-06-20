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
<p>商品名:<input type="text" id="itemName"  name="itemName">
<input type="button" value="クリア" onclick="clearTextitemname()" />
</p>

<p>容量：<input type="text"  id="itemCapacity" value="itemCapacity"  name="itemCapacity" placeholder="数字を入力">
<select name=”item”>
    <option value=”select”>単位を選択</option>
    <option value=”ml”>ml</option>
    <option value=”g”>g</option>
    <option value=”ko”>個</option>
    <option value=”m”>メートル</option>
    <option value=”hon”>本</option>
    <option value=”others”>その他</option>
<input type="button" value="クリア" onclick="clearTextitemcapacity()" />
</p>

<p>値段：<input type="text" id="itemprice" name="itemprice" placeholder="数字を入力">円
    <input type="button" value="クリア" onclick="clearTextitemprice()" />
</p>

<p>使用開始日：<input type="date" name="startDate">
</p>
<p>使用終了日：<input type="date" name="endDate">
</p>

<p>備考：<input type="text" id="itemremarks" name="itemremarks">
<input type="button" value="クリア" onclick="clearTextitemremarks()" />
</p>
<p>
<input type="submit" value="更新する" onclick="return checkFormValue();">
<button type="button">キャンセル</button>
</p>
</form>
<script>

function checkFormValue(){
    //商品名のチェック
    if(itemname.value == ""){
        alert("商品名を入力して下さい")
        //submitさせずに戻る
        return false;
    }
    //容量のチェック
    if(itemcapacity.value ==""){
        alert("容量を入力して下さい")
        return false;
    }
    //値段のチェック
    if(itemprice.value ==""){
        alert("値段を入力して下さい")
        return false;
    }
    //ここまできたら全てok
    return true
}

function clearTextitemname() {
	var textForm = document.getElementById("itemname");
  textForm.value = '';
}

function clearTextitemcapacity() {
	var textForm = document.getElementById("itemcapacity");
  textForm.value = '';
}

function clearTextitemprice() {
	var textForm = document.getElementById("itemprice");
  textForm.value = '';
}

function clearTextitemremarks() {
	var textForm = document.getElementById("itemremarks");
  textForm.value = '';
}
</script>
</body>
</html>