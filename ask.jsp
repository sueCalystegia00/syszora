<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"  %>

<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

Connection conn = null;
String msg = "";


// 引数は、ダウンロードしたshopping.dbの所在に基づき、適切な値に変更すること。
// Windowsのフォルダー区切り文字は「\」であっても，ここでは「/」を使用できる。

%>

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>問い合わせ</title>
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
				margin-left: 30px;
				margin-right: 30px;
				color: white;
			}
			#form{
				position: relative;
				width: 60%;
				margin: 30px;
			}

			input,textarea{
				display: block;
			}

			input{
				width:70%;
			}

			textarea{
				width: 70%;
				height: 120px;
			}

			input[type="submit"]{
				width: 300px;
				font-size: 24px;
				background-color: #ffaa00;
				background-image: -webkit-gradient(
										linear,
										left top, left bottom,
										from(#ffe7b8),to(#ffaa00));
				background-image: -webkit-linear-gradient(top, #ffe7b8 0%, #ffaa00 100%);
				background-image: linear-gradient(to bottom, #ffe7b8 0%, #ffaa00 100%)
				border: solid 1px #aaaaaa;
				border-radius: 10px;
				paddig-top: 10px;
				padding-bottom: 10px;
			}
			a{
				width: 150px;
				font-size: 18px;
				color: white;
				background-color: #006bc2;
				background-image: -webkit-gradient(
										linear,
										left top, left bottom,
										from(#ffe7b8),to(#ffaa00));
				background-image: -webkit-linear-gradient(top, #ffe7b8 0%, #ffaa00 100%);
				background-image: linear-gradient(to bottom, #ffe7b8 0%, #ffaa00 100%)
				border: solid 1px #aaaaaa;
				border-radius: 10px;
				padding-top: 10px;
				padding-left: 20px;
				padding-right: 20px;
				padding-bottom: 10px;
			}

    </style>
    <!--	jQuery導入
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        -->
        <script type="text/javascript">
		</script>
	</head>

		<body>
			<div class="background"></div>
			<div class="header">
				<h1>質問・お問い合わせ</h1>
			</div>
			<div class="contents">

				<p>ご意見、ご感想等ありましたら以下の欄にご記入の上送信してください</p>
				<p>皆様の声をお待ちしております</p>
				<div id="form">
					<form action="none" method="GET">
						<p>
		            	<label>
		            		名前：<input type="text" name="username">
		            	</label>
		            	</p>
		            	<p>
		            	<label>
		            		メールアドレス：<input type="text" name="usermail">
		            	</label>
		            	</p>
		            	<p>
		            	<label>
		            		コメント：<textarea name="usercomment"></textarea>
		            	</label>
		            	</p>
		            	<p>
		            	<input type="submit" value="送信">
		            	</p>
		        	</form>
				</div>
				<div id="rink">
					<a href="syszora_index.jsp">ホーム</a>
					<a href="select.jsp">窓選択へ</a>
				</div>
			</div>
		</body>
</html>