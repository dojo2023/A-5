 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>新規登録</h1>
  <form id='accountForm'  method="POST" action="/A-five/LoginServlet">
  <!-- 「新規登録」ボタンを押すとログイン画面に遷移
  		新規登録で入れたユーザー名を保持したまま遷移したい -->
    ユーザー名<input type="text" name="user_name">
    <div class= "togglePassword">
    <span id="buttonEye" class="fa fa-eye" onclick="pushHideButton()"></span>
    パスワード<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
    <!-- <form id="fieldPassword"> -->
      <input type="password" id="textPassword" value="">
    </div>
    <input type="submit" name="account" value="新規登録">
  </form>
 <!--ロゴを入れる-->
</body>
<style>
	span{position: relative;
	 top: 0px;
	 left: 280px;}

      #textPassword {
       //border: none; /* デフォルトの枠線を消す */
      }
      #fieldPassword {
        border-width: thin;
        border-style: solid;
        width: 200px;
      }
</style>
<script>
      function pushHideButton() {
        var txtPass = document.getElementById("textPassword");
        var btnEye = document.getElementById("buttonEye");
        if (txtPass.type === "text") {
          txtPass.type = "password";
          btnEye.className = "fa fa-eye";
        } else {
          txtPass.type = "text";
          btnEye.className = "fa fa-eye-slash";
        }
      }
   // inputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
      let accountForm = document.getElementById('accountForm'); /* ID=accountFromの中身を取得 */
      accountForm.addEventListener('submit', function(submit) { //type=submitが押された瞬間、以下の処理を開始
          let inputs = accountForm.querySelectorAll('input:not([type="submit"])');
      		//inputタグのうちsubmitじゃないもの（=ユーザー名・パスワード）をinputsとして取得
          inputs.forEach(function(input) {//ユーザー名・パスワードそれぞれに判定をしたい for文
              let error = input.nextElementSibling;
              if (input.value.trim() === '') {//空白を文字として認識しない trim
                  submit.preventDefault();//習った
                  if (!error || !error.classList.contains('error-message')) {
                      error = document.createElement('div');
                      error.classList.add('error-message');//クラスerror-messageを作る
                      error.textContent = '入力されていません';
                      input.parentNode.insertBefore(error, input.nextElementSibling);//inputの次に入れる
                  }
              } else {
                  if (error && error.classList.contains('error-message')) {
                      error.remove();
                  }
              }
          });
      })
</script>
</html>