<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"  %>
<%!

%>
<%

request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE html>
<html lang="ja">
	<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <title>SYSZORA</title>

        <style type="text/css">
			<!--
			@import url('https://fonts.googleapis.com/css?family=Sawarabi+Mincho&display=swap');
			.background{
				position:fixed;
				width:100%;
				height:100%;
				background-image: url(index.gif);
				background-repeat:no-repeat;
				background-size:cover;
				background-position:center;
			}
			.header{
				position: absolute;
				width: 100%;
				padding: 10px;
				font-family: 'Sawarabi Mincho', sans-serif;
				color: white;
				font-size: 20px;
			}
			.contents{
				position: absolute;
				width: 100%;
				margin-top: 120px;
				margin-left: auto;
				margin-right: auto;
				color: white;
			}
			#introduce{
				min-width: 50%;
				max-width: 460px;
				float: left;
				padding-left: 30px;
				padding-right: 30px;
				margin: auto;
			}
			#blank{
				width : 100%;
				clear: both;
				margin: 30%;
			}
			#rink{
				position: relative;
				float: right;
				padding: 10px;
				margin-left: 20px;
				margin-right: 20px;
			}
			#rink a{
				background-color: aliceblue;
				padding: 5px 30px;
				border-radius: 5px;}

			}
			.footter{
				clear:both;
				width: 100%;
			}
        </style>

        
        <script type="text/javascript">
		</script>
    </head>
	<body>
		<div class="background"></div>
		<div class = "header">
			<h1>SYSZORA</h1>
		</div>
		<div class = "contents">
			<div id = "introduce">
				<h2>シス工棟から星空を眺めませんか？</h2>
				<p>
				勉強、お疲れ様です<br>
				少し休んでいきませんか？<br>
				一緒にシス工棟から星空を見てみましょう<br>
				綺麗な星と、そこにある少しの物語を知って、<br>
				疲れた心身をリフレッシュしましょう<br>
				</p>
			</div>
			<div id = "blank">
			</div>
			<div id = "rink">
					<p><a href="select.jsp">窓選択へ</a></p>
					<p><a href="ask.jsp">質問・お問い合わせ</a></p>
			</div>
		</div>
	</body>
</html>
