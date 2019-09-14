<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"  %>
<%!


%>
<%

String karamu = request.getParameter("karamu");
String atai = request.getParameter("atai");
String shouhin = request.getParameter("shouhin");
String result = request.getParameter("table");

request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");

Connection conn = null;
String msg = "";

%>
<!DOCTYPE html>
<html>
    <head>
	<title>窓選択</title>
    </head>
    <body>
	<h1>調べたい窓と時間を選んでください</h1>
	<form method="post" action = "result.jsp">
	<input type ="text"name="time" size ="2">時
	</form>
	<img src = "image/a.jpg" alt="robee8">
	<p><a href="search.jsp">質問・お問い合わせ</a></p>
	<p><a href="top.jsp">ホーム</a></p>

    </body>
</html>
