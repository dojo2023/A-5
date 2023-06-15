<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="login-page">
  <div class="form">
  <form class="register-form" id="loginForm" method="POST" action="/dojo6/src/servlet/LoginServlet">
    	<input type="text" placeholder="ユーザー名" name="user_name">
    	<div id='errorUserName'></div>
    	 <p class="errormessage"></p>
        <div class= "togglePassword">
    		<span id="buttonEye" class="fa fa-eye" onclick="pushHideButton()"></span>
      		<link href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" rel="stylesheet">
     		<!-- <form id="fieldPassword"> -->
     	<input type="password" id="textPassword" placeholder="パスワード">
     	<div id="errorUserPass"></div>
     	<p></p>
    <input type="submit" name="LOGIN" value="ログイン"><br>

    <p class="message"><a href= "/A-five/AccountServlet">新規登録はこちら</a></p>
  </form>
</div>
</body>
	<style>
	.login-page {
  width: 360px;
  padding: 8% 0 0;
  margin: auto;
	}
	.form {//formの四角の中身に対する変更
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 360px;/*幅*/
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
  border: 0;
  margin: 0 0 0px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
	span{position: relative;
	 top: 40px;
	 left: 100px;}
      #textPassword {
       //border: none; /* デフォルトの枠線を消す */
      }
      #fieldPassword {
        border-width: thin;
        border-style: solid;
        width: 200px;
      }
      input[name="LOGIN"]{/*inputタグの、name属性が"LOGIN"のものに適応*/
      	 font-family: "Roboto", sans-serif;
  		text-transform: uppercase;
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
	.form .togglePassword{
	height:40}
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
   // inputタグ(display=noneのもの以外)の中身が空のまま送信ボタンが押されたら、各inputタグの下にエラー表示
 /*     let loginForm = document.getElementById('loginForm'); /* ID=loginFromの中身を取得
      loginForm.addEventListener('submit', function(submit) { //type=submitが押された瞬間、以下の処理を開始
          let inputs = loginForm.querySelectorAll('input:not([type="submit"])');
      		//inputタグのうちsubmitじゃないもの（=ユーザー名・パスワード）をinputsとして取得
          inputs.forEach(function(input) {//ユーザー名・パスワードそれぞれに判定をしたいのでfor文使う
              let error = input.nextElementSibling;
              if (input.value.trim() === '') {//空白を文字として認識しない trim
                  submit.preventDefault();//習った
                  if (!error || !error.classList.contains('error-message')) {
                      error = document.getElementById('errorUserName');
                      error.classList.add('error-message');//クラスerror-messageを作る
                      document.getElementById('errorUserName').textContent = '入力されていません';
                      input.parentNode.insertBefore(error, input.nextElementSibling);//inputの次に入れる
                  }
              } else {
                  if (error && error.classList.contains('error-message')) {
                      error.remove();
                  }
              }
          });
      })*/
      let loginForm = document.getElementById('loginForm').onsubmit = function(event){  //ID=loginFromの中身を取得
    	  event.preventDefault();
    	  const search = document.getElementById('form').value;
    	  document.getElementById('errormessage').textContent =`入力されていません`;
    	};
    	/*
    	<!--処理内容
    	クリックされたら、formがついた要素を引っ張ってくる。
    	その中の、word属性を持っているもの（テキスト打ち込む場所？）のvalue（value属性=入力した言葉？）を'search'に入れる。
    	output（特に何も入ってない段落） を`${search}の検索中`に書き換える

    	-->*/
      </script>
</html>