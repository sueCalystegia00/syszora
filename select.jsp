<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"  %>
<%!



%>
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
        <meta name="viewport" content="width=device-width,initial-scale=1">
	<title>窓選択</title>
	<style type="text/css">
			<!--
			@import url('https://fonts.googleapis.com/css?family=Sawarabi+Mincho&display=swap');
			.h1{
				position: absolute;
				width: 100%;
				padding: 10px;
				font-family: 'Sawarabi Mincho', sans-serif;
				color: white;
				font-size: 20px;
			}
			.h4{
				font-family: 'Sawarabi Mincho', sans-serif;
				color: white;
				font-size: 10px;
			}
			.background{
				position:fixed;
				width:100%;
				height:100%;
				background-image: url(index.gif);
				background-repeat:no-repeat;
				background-size:cover;
				background-position:center;
				z-index: -9999;
			}
			.header{
				position: relative;
				width: 100%;
				padding: 10px;
				font-family: 'Sawarabi Mincho', sans-serif;
				color: white;
				font-size: 15px;
			}
			.contents{
				position: relative;
				width: 100%;
				margin-top: 10px;
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

			}
			#rink{
				position: relative;
				float: right;
				padding: 10px;
				margin-left: 20px;
				margin-right: 20px;
				top:-50px;
			}
			#rink a{
				background-color: aliceblue;
				padding: 5px 30px;
				border-radius: 5px;

			}
			#img input{
				top:40px;
				position: relative;
				padding: 5px;
				margin-left: 20px;
				margin-right: 20px;
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



     <script>

      function postForm(value){

      var form = document.createElement('form');
      var request = document.createElement('input');
	  var homedirection;

      form.method = 'POST';
      form.action = 'syszora_search_v2.jsp';

      request.type = 'hidden'; //入力フォームが表示されないように
      request.name = 'text';
      request.value = value;

      form.appendChild(request);
      document.body.appendChild(form);

      form.submit();

    }

    </script>
     <div class="background"></div>
     <div class = "header">
	  	<h1>調べたい窓を選んでください</h1>
	  	<h3>窓から今見える星が表示されます</h3>
	  	<h4>*星が表示されるまで30秒ほどかかります。窓選択後しばらくお待ちください</h4>
 	 </div>
	 <div class="contents">
	 	 <!--  <form method="post" action = "syszora_search_v2.jsp">
	 	  <input type ="text"name="hour" size ="2">時
	 	 </form>
	 	 -->
	 	<div id = "img">
	 	  <input type="image" src="image/1.png" name="button1" alt="送信する" onclick="postForm(1)" >

	 	  <input type="image" src="image/2.png" name="button2" alt="送信する" onclick="postForm(2)" >

	 	  <input type="image" src="image/3.png" name="button3" alt="送信する" onclick="postForm(3)" >
		</div>
	 	<div id = "blank">
	 	</div>
	 	<div id="rink">
	 	 <p><a href="ask.jsp">質問・お問い合わせ</a></p>
	 	 <p><a href="syszora_index.jsp">ホーム</a></p>
	 	</div>
	 </div>
    </body>
</html>
