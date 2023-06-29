<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.4/Chart.min.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="/A-five/css/analysis.css">
</head>

<body>
		<%@ include file="common_header.jsp" %>

		<%@ include file="common_list.jsp" %>
<div class="canvasWrapper" id="canvasWrapper">
<canvas id="stage"></canvas>
</div>

<script>
var mydata = {
		  labels: ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"],
		  datasets: [
		    {
		      label: '月合計',
		      hoverBackgroundColor: "rgba(255,99,132,0.3)",
		      data: [350, 1040, 530, 2200, 220, 1300, 1500, 628, 5300, 700, 850, 3240],
		    }
		  ]
		};

		//「オプション設定」
		var options = {
		  title: {
		    display: true,
		    text: '使用予定額'
		  }
		};

		var canvas = document.getElementById('stage');
		canvas.width = 130;
		canvas.height = 60;

		var chart = new Chart(canvas, {

		  type: 'bar',  //グラフの種類
		  data: mydata,  //表示するデータ
		  options: options  //オプション設定

		});

</script>
</body>

</html>