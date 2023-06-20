<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
</head>
<body>
<div class="login-page">

  <div class="form">
  <form id="loginForm" method="POST" action="LoginServlet">
    	<div class="userName">
    		<input type="text" minlength="6" pattern="^[a-zA-Z0-9]+$" maxlength="12" placeholder="ユーザー名(半角英数字6～12字)" value="${param.user_name}" name="user_name" required>
            <div class="error"> ${error}</div>
        </div>
        <div class= "togglePassword">
    		<span id="buttonEye" class="fa fa-eye" onclick="pushHideButton()"></span>
      		<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
     	<input type="password" id="textPassword" pattern="^[a-zA-Z0-9]+$"  maxlength="12" placeholder="パスワード(半角英数字8～12字)" name="user_pass" required>
     	</div>
    <input type="submit" name="LOGIN" value="ログイン">

    <p class="message"><a href= "AccountServlet">新規登録はこちら</a></p>
  </form>
  </div>
</div>
</body>
	<style>
	.login-page {
  width: 360px;
  height: 500px;/*幅*/
  padding: 8% 0 0;
  margin: auto;
	}
	.form {/*formの四角の中身に対する変更*/
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;/*幅*/
  max-height: 480px;/*高さ*/
  margin: 0 auto 100px;
  padding: 45px;/*padding..テキストと四角の間*/
  text-align: center;/*テキスト中央ぞろえ*/
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);/*影*/
	}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 10px;
  margin: 0 0 0px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
	/*目のやつ*/
span{position: relative;
	 top: 40px;
	 left: 110px;}

#textPassword {
       border: none; /* デフォルトの枠線を消す */
}
#fieldPassword {
        border-width: thin;
        border-style: solid;
        width: 200px;
      }

      /*inputタグの、name属性が"LOGIN"のものに適応*/
      input[name="LOGIN"]{
      	 font-family: "Roboto", sans-serif;
  		outline: 0;
  		background: #4CAF50;
  		width: 100%;
  		border: 0;
  		padding: 15px;
  		color: #FFFFFF;
  		font-size: 14px;
  		-webkit-transition: all 0.3 ease;
  		transition: all 0.3 ease;
  		cursor: pointer;
      }
      input[name="LOGIN"]:hover,.form button:active,.form button:focus {
  			background: #43A047;
		}
	.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
	.form .error{
		color: #FF0000;
		font-size: 10px;
		padding: 0px;
		text-align: left;/*テキスト ぞろえ*/}
	.form .userName{
	height:50px}

	.form .togglePassword{
	height:100px}



	.form .error-message{
		color: #FF0000;
		font-size: 10px;
		padding: 0px;
		text-align: left;/*テキスト中央ぞろえ*/
		/*position: absolute;*/
	 		top: 160px;
	 		left: 500px;
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
      /*
      var sample = [6,8];
      let i = 0;
      i = i + 1;
      */

      // inputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
      let loginForm = document.getElementById('loginForm'); // ID=accountFromの中身を取得
      loginForm.addEventListener('submit', function(submit) { //type=submitが押された瞬間、以下の処理を開始
          let inputs = loginForm.querySelectorAll('input:not([type="submit"])');
      		//inputタグのうちsubmitじゃないもの（=ユーザー名・パスワード）をinputsとして取得
          inputs.forEach(function(input) {//ユーザー名・パスワードそれぞれに判定をしたい for文
              let error = input.nextElementSibling;//テキストを取得してる？

              if (input.value.trim() === '') {
                  submit.preventDefault();//習った
                  if (!error || !error.classList.contains('error-message')) {
                      error = document.createElement('div');
                      error.classList.add('error-message');//クラスerror-messageを作る
                      error.textContent = '入力されていません';
                      input.parentNode.insertBefore(error, input.nextElementSibling);//inputの次に入れる
                  }
              }
              else {
                  if (error && error.classList.contains('error-message')) {
                      error.remove();
                  }
              }
          });
      })

      </script>
</html>