<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="/A-five/css/regist.css">
<meta charset="UTF-8">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
    <!--全体を囲う-->
    <div id="formWrapper" class="iziModal">
	<div id="tabs">
		<!-- タブ-->
		<div>
            <ul>
                <li><a href="#tabs1"> 日用品登録</a></li>
                <li><a href="#tabs2"> 家事登録</a></li>
            </ul>
		</div>
        <!-- CSSで罰ボタンを -->
        <!-- 日用品登録フォーム-->
        <div id="tabs1">
            <form id="dailyRegistForm" action="/A-five/RegistServlet" method="post">
                <input id="dailyName" name="dailyName" type="text" placeholder="日用品項目" list="dailySelect">
                <datalist id="dailySelect" name="dailySelect">

                </datalist>
                <input name="itemName" type="text" placeholder="商品名" >
                <input name="itemPrice" type="text" placeholder="値段">
                <input name="itemVolume" type="text" placeholder="容量">
                <input id="dailyUnit" name="dailyUnit" type="text" placeholder="単位" list="unitSelect">
                <datalist id="unitSelect" name="unitSelect">
                    <!-- 日用品項目と単位はマップ -->
                </datalist>
                <input name="itemMemo" type="text" placeholder="メモ(100字まで)" max="100">
                <input name="itemStart" type="date" placeholder="使用開始日">
                <input name="itemFreq" type="text" placeholder="予測使用日数">
                <input name="regist" type="hidden" value="itemSubmit">
                <input id="existFlag" name="existFlag" type="hidden" >
                <button type="submit">登録</button>
            </form>
        </div>
        <!-- 家事登録フォーム-->
        <div id="tabs2">
            <form id="hwRegistForm" action="/A-five/RegistServlet" method="post">
                <input id="hwName" name="hwName" type="text" placeholder="家事項目" list="hwSelect">
                <datalist id="hwSelect">
                	<c:forEach var="hwName" items="${hwNameList}">
                		<option>${hwName}</option>
                	</c:forEach>
                </datalist>
                <select name="freqUnit">
                    <option value="1">日</option>
                    <option value="7">週</option>
                    <option value="30">月</option>
                </select>
                <input name="hwFreq" type="text" min="0" placeholder="目標頻度">
                <input name="hwMemo" type="text" placeholder="メモ">
                <input name="regist" type="hidden" value="hwSubmit">
                <button type="submit">登録</button>
            </form>
        </div>
	</div>
	</div>
	<c:if test="{not empty result}">
		<script type="text/javascript">alert(result);</script>
	</c:if>
    <script src="/A-five/js/Regist.js"></script>
</body>
</html>





