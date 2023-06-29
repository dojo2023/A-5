<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>



<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/A-five/css/home.css">
</head>
<body>

		<%@ include file="common_header.jsp" %>

		<%@ include file="common_list.jsp" %>


<!--     <div class="col-9 d-flex justify-content-center align-items-center">
	<div class="d-flex justify-content-center align-items-center"> -->
<div class="calenderWrapper">
	<div class="calender">
    	<!-- カレンダー関連 -->
	    <!-- xxxx年xx月を表示 -->
	    <!-- <div class="tuki">
	    <h2 id="header"></h2>
	    </div> -->

	    <!-- ボタンクリックで月移動 -->
	    <div id="nextPrevButton">
	        <button id="prev" onclick="prev()">＜</button>
	        <div class="tuki">
		    <h2 id="header"></h2>
		    </div>
	        <button id="next" onclick="next()">＞</button>
	    </div>

	    <!-- カレンダー -->
	    <div id="calendar"></div>
	 <!-- </div>
	 </div> -->
	    <!-- カレンダー関連ここまで -->
	</div>
</div>
<div class="plusBtnWrapper">
	<button id="plusBtn" class="plusBtn" >+</button>
	<button id='hiddenBtn' type="hidden" data-izimodal-open="#tabs"></button>
	<script type="text/javascript">
		const plusBtn = document.getElementById('plusBtn');
		const hiddenBtn = document.getElementById('hiddenBtn');
		plusBtn.addEventListener('click', function() {
			hiddenBtn.click();
		})
	</script>
</div>


	<script>
	<!-- カレンダー関連 -->
	const week = ["日", "月", "火", "水", "木", "金", "土"];
	const today = new Date();
	// 月末だとずれる可能性があるため、1日固定で取得
	var showDate = new Date(today.getFullYear(), today.getMonth(), 1);

	// 初期表示
	window.onload = function () {
	    showProcess(today, calendar);
	};
	// 前の月表示
	function prev(){
	    showDate.setMonth(showDate.getMonth() - 1);
	    showProcess(showDate);
	}

	// 次の月表示
	function next(){
	    showDate.setMonth(showDate.getMonth() + 1);
	    showProcess(showDate);
	}

	// カレンダー表示
	function showProcess(date) {
	    var year = date.getFullYear();
	    var month = date.getMonth();
	    document.querySelector('#header').innerHTML = year + "年 " + (month + 1) + "月";

	    var calendar = createProcess(year, month);
	    document.querySelector('#calendar').innerHTML = calendar;
	}

	// カレンダー作成
	function createProcess(year, month) {
	    // 曜日
	    var calendar = "<table><tr class='dayOfWeek'>";
	    for (var i = 0; i < week.length; i++) {
	        calendar += "<th>" + week[i] + "</th>";
	    }
	    calendar += "</tr>";

	    var count = 0;
	    var startDayOfWeek = new Date(year, month, 1).getDay();
	    var endDate = new Date(year, month + 1, 0).getDate();
	    var lastMonthEndDate = new Date(year, month, 0).getDate();
	    var row = Math.ceil((startDayOfWeek + endDate) / week.length);

	    // 1行ずつ設定
	    for (var i = 0; i < row; i++) {
	        calendar += "<tr>";
	        // 1colum単位で設定
	        for (var j = 0; j < week.length; j++) {
	            if (i == 0 && j < startDayOfWeek) {
	                // 1行目で1日まで先月の日付を設定
	                calendar += "<td class='disabled'>" + (lastMonthEndDate - startDayOfWeek + j + 1) + "</td>";
	            } else if (count >= endDate) {
	                // 最終行で最終日以降、翌月の日付を設定
	                count++;
	                calendar += "<td class='disabled'>" + (count - endDate) + "</td>";
	            } else {
	                // 当月の日付を曜日に照らし合わせて設定
	                count++;
	                if(year == today.getFullYear()
	                  && month == (today.getMonth())
	                  && count == today.getDate()){
	                    calendar += "<td class='today'><h5>" + count + "</br>"
	                    + "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
	                    +"</h5></td>";
	                } else {
	                	if (count === 3) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 4) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 7) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 8) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 9) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 14) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						} else if (count === 16) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 17) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 20) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 22) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 23) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 25) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 26) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 28) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 29) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else if (count === 30) {
	                		//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
							+ "<a href='/A-five/src/HomeServlet'><img src='./img/HW_icon.png' width='20' height='20' alt='家事'></a>"
		                    +"</h5></td>";
						}else {
							//表示したい項目がある場合は、ここでリンクを設定する
		                    calendar += "<td><h5>" + count + "<br>"
		                    //+"<a href=''>"+year+"</a>"
		                     //アイコン表示
		                    +"</h5></td>";
						}

	                }
	            }
	        }
	        calendar += "</tr>";
	    }
	    return calendar;
	}
	</script>
	<!-- カレンダー関連ここまで -->

</body>
</html>