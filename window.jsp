<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"  %>
<%

request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String window;
Connection conn = null;
String msg = "";
String img;
String choice = request.getParameter("text");
double homedirection;

if(choice.equals("1")){
	window = "8階の窓";
	homedirection = 45;
	img ="1.jpg";
}else if(choice.equals("2")){
	window = "6階の窓";
	homedirection = 180;
	img ="2.jpg";
}else {
	window = "3階の窓";
	homedirection = 250;
	img ="3.jpg";
}
// 引数は、ダウンロードしたshopping.dbの所在に基づき、適切な値に変更すること。
// Windowsのフォルダー区切り文字は「\」であっても，ここでは「/」を使用できる。

%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
			<!--
			@import url('https://fonts.googleapis.com/css?family=Sawarabi+Mincho&display=swap');
			.background{
				position:fixed;
				width:100%;
				height:100%;
				background-image: url(<%= img %>);
				background-repeat:no-repeat;
				background-size:cover;
				background-position:center;
				top:-25px;
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

        <!--	jQuery導入
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        -->
        <script type="text/javascript">
		</script>
</head>
<body>
<div class="background"></div>

<script>
xhr.onreadystatechange = function() {

    if(xhr.readyState === 4 && xhr.status === 200) {

        console.log( xhr.responseText );

    }
}

</script>

</body>
<h1><%=window %></h1>
	<%=homedirection %>
	<div class="background"></div>
	<%=img %>
	<p><a href="ask.jsp">質問・お問い合わせ</a></p>
	<p><a href="syszora_index.jsp">ホーム</a></p>
	<p><a href="select.jsp">窓選択へ</a></p>


</html>