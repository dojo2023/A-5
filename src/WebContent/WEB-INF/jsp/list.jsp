<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.5.0.min.js"></script>

<link href="/A-five/css/iziModal.css" rel="stylesheet" type="text/css">
<link href="/A-five/css/list.css" rel="stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/A-five/css/regist.css">

</head>
<body>

<%@ include file="common_header.jsp" %>
<%@ include file="common_list.jsp" %>
<%-- <%@ include file="regist.jsp" %> --%>
<div class="listWrapper">
<div class="tabWrap">
	<input id="itemTab" type="radio" name="tab_btn" checked>
    <input id="HWTab" type="radio" name="tab_btn">

	<div class="tabArea">
        <label class="itemTabLabel" for="itemTab">日用品</label>
        <label class="HWTabLabel" for="HWTab">家事</label>
    </div>

	<div class="panelArea">

		<div id="itemPanel" class="tabPanel">

			<table class="table">
				<thead>
					<tr>
						<th>日用品項目</th>
						<th></th>
						<th>予測終了日</th>
						<th>日数</th>
						<th>補充</th>
						<th>使用終了</th>
					</tr>
				</thead>
			<c:forEach var="g" items="${itemlist}" varStatus ="status">
			<tbody>
			<!-- <form method="GET" action="/A-five/ListServlet"> -->
			<c:if test="${!g.itemFlag}">

				<tr>
					<td>${g.dailyName}<br>${g.itemName}</td>
					<td><button type="button" data-izimodal-open="#itemModal${g.itemHisId}" class="listDetailBtn">詳細</button></td>
					<td>${g.itemDue}</td>
					<td>あと日</td>
					<td><input id= "itemCheck${status.index}" type="checkbox" onchange="toggleItemFlag(${status.index})" class="toggleButton"></td>
					<td><input type="checkbox">
						<input type="hidden" id="itemHisId${status.index}" value="${g.itemHisId}">
						<input type="hidden" id="itemId${status.index}" value="${g.itemId}">
						<button id="itemRestockButton${status.index}" data-izimodal-open="#itemModalRestock${g.itemHisId}" style="display: none;"></button>

					<div id="itemModalRestock${g.itemHisId}" class="iziModal" >

					<button type="button" class="batsu" data-izimodal-close="#itemModalRestock${g.itemHisId }">×</button>
					<h4 style = "padding:10px;">この日用品を使い続けますか？</h4>
					<hr>
					<table class ="modaltable">
					<tr>
					<td>項目名</td>
					<td>${g.dailyName}</td>
					</tr>

					<tr>
					<td>商品名</td>
					<td>${g.itemName}</td>
					</tr>

					<tr>
					<td>容量</td>
					<td>${g.itemVolume}${g.dailyUnit}</td>
					</tr>

					<tr>
					<td>使用開始日</td>
					<td>${g.itemStart}</td>
					</tr>

					<tr>
					<td>使用終了日</td>
					<td>${g.itemDue}</td>
					</tr>

					<tr>
					<td>備考</td>
					<td>${g.itemMemo}</td>
					</tr>
					</table>

					<button id="itemRestockYes${g.itemHisId }" type="button" class="editButton" data-izimodal-close="#itemModalRestock${g.itemHisId }">はい</button>
					<button id="itemRestockNo${g.itemHisId }" type="button" class="deleteButton" data-izimodal-open="#itemModalStock${g.itemHisId}">いいえ</button>

					</div>

					<div id="itemModalStock${g.itemHisId}" class="iziModal">
					<button id="itemStockBatsu${g.itemHisId}" type="button" class="batsu" data-izimodal-close="#itemModalStock${g.itemHisId }">×</button>
					<div id="itemModalStockContent${g.itemHisId}" class="itemModalStockContent"></div>
					<button id="itemStockYes${g.itemHisId}" type="button" class="editButton">はい</button>
					<button type="button" class="deleteButton">いいえ</button>
					</div>


					<!-- 日用品のモーダル -->
				<div id="itemModal${g.itemHisId}" class="iziModal" >
					<button type="button" class="batsu" data-izimodal-close="#itemModal${g.itemHisId }">×</button>
					<h3 style="padding:10px;">項目名:${g.dailyName}</h3>
					<hr>
					<table class ="modaltable">
					<tr>
					<td>商品名</td>
					<td>${g.itemName}</td>
					</tr>
					<tr>
					<td>容量</td>
					<td>${g.itemVolume}${g.dailyUnit}</td>
					</tr>
					<tr>
					<td >使用開始日</td>
					<td >${g.itemStart}</td>
					</tr>
					<tr>
					<td>使用終了日</td>
					<td >${g.itemDue}</td>
					</tr>
					<tr>
					<td>備考</td>
					<td>${g.itemMemo}</td>
					</tr>
					</table>
					<h2>履歴</h2>

				<c:forEach var="h" items="${itemlist}" varStatus ="status">
				<c:if test="${h.itemId == g.itemId}">
				<table class = "modaltable">
					<tr>
					<td>商品名</td>
					<td>${h.itemName}</td>
					</tr>
					<tr>
					<td>容量</td>
					<td>${h.itemVolume}${h.dailyUnit}</td>
					</tr>
					<tr>
					<td>使用開始日</td>
					<td>${h.itemStart}</td>
					</tr>
					<tr>
					<td>使用終了日</td>
					<td>${h.itemFin}</td>
					</tr>
					<tr>
					<td>備考</td>
					<td>${h.itemMemo}</td>
					</tr>

				</table>

				</c:if>
				</c:forEach>


						<button type="button" class="editButton" data-izimodal-open="#itemEditModal${g.itemHisId }" >編集</button>
						<button type="button" class="deleteButton">削除</button>
				</div>

				<div id="itemEditModal${g.itemHisId}" class="iziModal" >

				<form id="itemEditForm" action="/A-five/ItemEditServlet" method="post">
				<button type="button" class="batsu" data-izimodal-close="#itemEditModal${g.itemHisId }">×</button>
					<h4 style="padding:10px;">商品内容を編集してください</h4>
					<hr>
					<table class ="modaltable2">
					<tr>
			        <td>商品名</td><td><input type="text" id="itemName" value="${g.itemName }"  name="itemName">
			        <input type="button" value="クリア" onclick="clearTextitemName()" /></td>
			        </tr>

			        <tr>
			        <td>容量</td>
			        <td>
			        <input type="text"  id="itemCapacity" value="${g.itemVolume}${g.itemUnit}"  name="itemCapacity" placeholder="数字を入力">
			        <input type="button" value="クリア" onclick="clearTextitemCapacity()" />
			        </td>
			        </tr>

			        <tr>
			        <td>値段</td>
			        <td>
			        <input type="text" id="itemPrice" value="${g.itemPrice}" name="itemPrice" placeholder="数字を入力">円
			        <input type="button" value="クリア" onclick="clearTextitemPrice()" />
			        </td>
			        </tr>

					<tr>
			        <td>使用開始日</td>
			        <td>
			        <input type="date" value="${g.itemStart}" name="startDate">
			        </td>
			        </tr>

			        <tr>
			        <td>使用終了日</td>
			        <td>
			        <input type="date" value="${g.itemFin}"  name="endDate">
			        </td>
			        </tr>

					<tr>
			        <td>備考</td>
			        <td>
			        <input type="text" id="itemRemarks" name="itemRemarks" value="${g.itemMemo }">
			        <input type="button" value="クリア" onclick="clearTextitemRemarks()" />
			        </td>
			        </tr>

			        </table>

			        <p>
			        <input type="submit" value="更新する" class="updatebutton">
			        <button type="button" data-izimodal-open="#itemModal${g.itemHisId }" class ="cancelbutton">キャンセル</button>
			        </p>
			    </form>
				</div>

					</td>
				</tr>

			</c:if>

			</tbody>
			<!-- </form> -->
		    </c:forEach>

			</table>

		</div>


		<div id="HWPanel" class="tabPanel">
			<table class="table">
				<tr>
					<th>家事項目</th>
					<th></th>
					<th>目標頻度</th>
					<th>期限</th>
					<th>完了</th>
				</tr>




			<c:forEach var="e" items="${hwList}" varStatus ="status">



			<!-- <form method="GET" action="/A-five/ListServlet"> -->
			<c:if test="${!e.hwFlag}">
				<tr>
					<td>${e.hwName}</td>
					<td><button type="submit" data-izimodal-open="#HWModal${e.hwHisId}" >詳細</button></td>
					<td>${e.hwFreq}日</td>
					<td>${e.hwDue}</td>
					<td><input type="checkbox" id="hwCheck${status.index}" onchange="toggleHwFlag(${status.index})">
					<input type="hidden" id="hwHisId${status.index}" value="${e.hwHisId}">
					<input type="hidden" id="hwId${status.index}" value="${e.hwId}">


			<div id="HWModal${e.hwHisId}" class="iziModal" >


			<button type="button" class="batsu" data-izimodal-close="#HWModal${e.hwHisId}">×</button>
			<h4 style ="padding: 10px;">${e.hwName}</h4>
			<hr>
			<table class = "modaltable">
			<tr>
			<td>目標頻度</td>
			<td>${e.hwFreq}日に一回</td>
			</tr>
			<tr>
			<td>次回実施日</td>
			<td>${e.hwDue}</td>
			</tr>
			<tr>
			<td>備考</td>
			<td>${e.hwMemo}</td>
			</tr>
			</table>

			<h2>履歴</h2>

			<table class="modaltable">
			<c:forEach var="f" items="${hwList}">

			<c:if test="${f.hwId == e.hwId}">
			<tr>
			<td>${f.hwDate}</td>
			</tr>


			</c:if>
			</c:forEach>
			</table>

			<br>
			<br>

				<button type="button" class="editButton" data-izimodal-open="#HWEditModal${e.hwHisId}">編集</button>
				<button type="button" class="deleteButton" data-izimodal-open="#HWDeleteModal${e.hwHisId}">削除</button>

			</div>
			<div id="HWDeleteModal${e.hwHisId }" class ="iziModal">
<!-- 			    <form id="HWDeleteForm"> -->

		    	<button type="button" class="batsu" data-izimodal-close="#HWDeleteModal${e.hwHisId}">×</button>

		    	<h4 style="padding:10px;">本当にこの家事の予定を削除しますか？</h4>
				<hr>

				<table class="modaltable">
				<tr>
				<td>家事項目名</td>
				<td>${e.hwName}</td>
				</tr>

				<tr>
				<td>目標頻度</td>
				<td>${e.hwFreq}日に一回</td>
				</tr>

				<tr>
				<td>次回実施日</td>
				<td>${e.hwDue}</td>
				</tr>

				<tr>
				<td>備考</td>
				<td>${e.hwMemo}</td>
				</tr>

				</table>

				<form method="POST" action="/A-five/ListServlet">
			    <input type="submit"name="SUBMIT" value="はい">
			    </form>

			    <button type="button" data-izimodal-open="#HWModal${e.hwHisId}">いいえ</button>
		   		<!-- </form> -->
	   		</div>

			<div id="HWEditModal${e.hwHisId }" class ="iziModal">
		    <form id="HWEditForm">

	    	<button type="button" class="batsu" data-izimodal-close="#HWEditModal${e.hwHisId}">×</button>
	    	<h4 style ="padding:10px;">家事内容を編集してください</h4>
			<hr>

			<table class = "modaltable">
			<tr>
		    <td>家事項目名</td>
		    <td>
		    <input type="text" id="HWName" name="HWname" value="${e.hwName }">
		    <input type="button" value="クリア" onclick="clearTextHWName()" />
		    </td>
		    </tr>

			<tr>
		    <td>実施日</td>
		    <td>
		    <input type="date" id="HWDate" name="HWDate" value="${e.hwDate }" >
		    </td>
		    </tr>

			<tr>
		    <td>頻度</td>
		    <td>
		    <input type="text" id="HWFreq" name="HWFreq" value="${e.hwFreq }日">
		    <input type="button" value="クリア" onclick="clearTextHWFreq()" />
		    </td>
		    </tr>

			<tr>
		    <td>メモ</td>
		    <td>
		    <input type="text" id="HWMemo"  name="HWMemo" value="${e.hwMemo}" placeholder= "メモ（100字まで）" max="100">
		    <input type="button" value="クリア" onclick="clearTextHWMemo()" />
		    </td>
		    </tr>

		    </table>
		    <input type="submit" value="更新する" class="updatebutton">
		    <button type="button" data-izimodal-open="#HWModal${e.hwHisId}" class="cancelbutton">キャンセル</button>


				    </form>
			    </div>
			</td>
			</tr>
			</c:if>


			<!-- </form> -->

			</c:forEach>




			</table>
		</div>
	</div>
</div>
</div>
<div class="plusBtnWrapper">
	<button id="plusBtn" class="plusBtn" >+</button>
	<button id='hiddenBtn' type="hidden" data-izimodal-open="#tabs">+</button>
	<script type="text/javascript">
		const plusBtn = document.getElementById('plusBtn');
		const hiddenBtn = document.getElementById('hiddenBtn');
		plusBtn.addEventListener('click', function() {
			hiddenBtn.click();
		})
	</script>

</div>
<!-- <div id="formWrapper" class="iziModal"> -->
	<div id="tabs" class="iziModal">

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
                <input name="hwName" type="text" placeholder="家事項目" list="hwSelect">
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
	<!-- </div> -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/izimodal/1.5.1/js/iziModal.min.js"></script>
<script type="text/javascript" src="/A-five/js/List.js"></script>
<!--  <script src="/A-five/js/Regist.js"></script> -->
</body>
</html>
