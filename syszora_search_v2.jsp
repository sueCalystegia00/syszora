<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.net.*,java.time.*,java.sql.*" %>
<%!
/* HTMLのいくつかの文字をエスケープし，改行の前に<br>を付ける */
String prettyPrintHTML(String s) {
    if (s == null)
    return "";
    return s.replace("&", "&amp;")
   	.replace("\"", "&quot;")
    .replace("<", "&lt;")
    .replace(">", "&gt;")
    .replace("'", "&#39;")
    .replace("\n", "<br>\n");
}

public class MyHttpClient {
    public String url = "";
    public String encoding = "UTF-8"; /* レスポンスの文字コード */
    public String header = ""; /* レスポンスヘッダ文字列 */
    public String body = ""; /* レスポンスボディ */
    public String find = "";

    /* 4つの引数（URL，エンコーディング）をとるコンストラクタ */
    public MyHttpClient(String uri) {
    	url = uri;
    }


    /* 実際にアクセスし，フィールドheaderおよびbodyに値を格納する */
    public void doAccess()
    throws MalformedURLException, ProtocolException, IOException {

	/* 接続準備 */
	URL u = new URL(url);
	HttpURLConnection con = (HttpURLConnection)u.openConnection();
	con.setRequestMethod("GET");
	con.setInstanceFollowRedirects(true);

	/* 接続 */
	con.connect();

	/* レスポンスヘッダの獲得 */
	Map<String, List<String>> headers = con.getHeaderFields();
	StringBuilder sb = new StringBuilder();
	Iterator<String> it = headers.keySet().iterator();

	while (it.hasNext()) {
	    String key = (String) it.next();
	    sb.append("  " + key + ": " + headers.get(key) + "\n");
	}

	/* レスポンスコードとメッセージ */
	sb.append("RESPONSE CODE [" + con.getResponseCode() + "]\n");
	sb.append("RESPONSE MESSAGE [" + con.getResponseMessage() + "]\n");

	header = sb.toString();

	/* レスポンスボディの獲得 */
	BufferedReader reader = new BufferedReader(
	    new InputStreamReader(con.getInputStream(),
		encoding));
	String line;
	sb = new StringBuilder();

	while ((line = reader.readLine()) != null) {
	    sb.append(line + "\n");

	}

	body = sb.toString();

	/* 接続終了 */
	reader.close();
	con.disconnect();
    }
}

//検索結果の数をカウントする
int count(String str){
	int defference = str.length() - str.replace("<star>","").length();
	return defference/6;
}

//星のX座標を算出する
double XCoordinate(double direction, double homedirection){
	double x = (1 - Math.tan((homedirection - direction)/180 * Math.PI)/0.7002)/2;
	//System.out.println(Math.tan(35/180 * Math.PI));
	return x;
}

//星のY座標を算出する
double YCoordinate(double altitude){
	double y = 1 - Math.tan(altitude/180 * Math.PI)/0.7002;
	return y;
}

//星の内容を引き出す
String star_content(String id){
	String msg_content = "";
	String uri = "http://www.walk-in-starrysky.com/star.do?cmd=detail&hrNo="+id;

	MyHttpClient Cmhc; // HTTPで通信するためのインスタンス

	boolean optionEscape = true;
	StringBuilder content = new StringBuilder("");	//内容

    try {
		Cmhc = new MyHttpClient(uri);
		Cmhc.doAccess();
		String s = Cmhc.body;

		//内容を表示する
		int pos1 = s.indexOf("<content>");
		int pos2 = s.indexOf("</content>");
		if (pos1 >= 0 && pos2 >= 0) {
			content.append(s.substring(pos1 + "<content>".length(), pos2));
		}
		msg_content = content.toString();


    } catch(MalformedURLException e) {
	System.out.println("URLが不適切です。");
    } catch(NullPointerException e){
    System.out.println("検索条件を指定してください");
    } catch(ProtocolException e) {
   	System.out.println("HTTPの通信に失敗しました。");
    } catch(IOException e) {
    System.out.println("何らかの不具合が発生しました。");
    }

	return msg_content;
}


//星の起源を引き出す
String star_origin(String id){
	String msg_origin = "";
	String uri = "http://www.walk-in-starrysky.com/star.do?cmd=detail&hrNo="+id;

	String msg = ""; // メッセージ
	MyHttpClient Omhc; // HTTPで通信するためのインスタンス

	boolean optionEscape = true;
	StringBuilder origin = new StringBuilder("");	//起源

	try {
		Omhc = new MyHttpClient(uri);
		Omhc.doAccess();

		String s = Omhc.body;

		//起源を表示する
		int pos3 = s.indexOf("<origin>");
		int pos4 = s.indexOf("</origin>");
		if (pos3 >= 0 && pos4 >= 0) {
			origin.append(s.substring(pos3 + "<origin>".length(), pos4));
		}
		msg_origin = origin.toString();

	} catch(MalformedURLException e) {
	System.out.println("URLが不適切です。");
	} catch(NullPointerException e){
	System.out.println("検索条件を指定してください");
	} catch(ProtocolException e) {
	System.out.println("HTTPの通信に失敗しました。");
	} catch(IOException e) {
	System.out.println("何らかの不具合が発生しました。");
	}
	return msg_origin;
}

%>
<%
//リクエスト・レスポンスとも文字コードをUTF-8に
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
StringBuilder sb = new StringBuilder("");
StringBuilder starsH = new StringBuilder("");
StringBuilder destarsH = new StringBuilder("");
StringBuilder starsC = new StringBuilder("");
StringBuilder destarsC = new StringBuilder("");
StringBuilder content = new StringBuilder("");	//内容
StringBuilder origin  = new StringBuilder("");  //起源
String msg_content = ""; //APIから受け取った星の内容について
String msg_origin = ""; //APIから受け取った星の起源について
double x;
double y;
String msg = ""; // 結果メッセージ
String test = "";
String stars_html = "";
String destars_html="";
String stars_css ="";
String destars_css="";

MyHttpClient mhc; // HTTPで通信するためのインスタンス

//boolean optionEscape = ("1".equals(request.getParameter("E"))); // レスポンスボディをHTMLエスケープするならtrue
boolean optionEscape = true;

LocalDateTime d = LocalDateTime.now();//日時インスタンスを作成
int year = d.getYear();	//年を受け取る
//String month = "6";
int month = d.getMonthValue(); //月
int day_of_month = d.getDayOfMonth();
//String day = request.getParameter("day"); //日
//String hour = request.getParameter("hour"); //時
int hour =d.getHour();

/*String year = request.getParameter("year");	//年を受け取る
String month = request.getParameter("month"); //月
String day = request.getParameter("day"); //日
String hour = request.getParameter("hour"); //時
*/
String surl = "http://www.walk-in-starrysky.com/star.do?cmd=display&year="+year+"&month="+month+"&day="+day_of_month+"&hour="+hour+"&minute=0&second=0&latitude=34.265934&longitude=135.151606"; /* URL */
String durl = "http://www.walk-in-starrysky.com/star.do?cmd=detail&hrNo=hhhh";

String window;
Connection conn = null;
String img;
String choice = request.getParameter("text");
double homedirection=0.0;

if(choice.equals("1")){
	window = "8階の窓";
	homedirection = 45;
	img ="image/back1.jpg";
}else if(choice.equals("2")){
	window = "6階の窓";
	homedirection = 180;
	img ="image/back2.jpg";
}else {
	window = "3階の窓";
	homedirection = 250;
	img ="image/back3.jpg";
}

String find = "";	//検索結果
String findsum = "";	//検索結果一覧


// if (year != null || month != null || day != null) {
    sb.append("<hr>");
    try {
	mhc = new MyHttpClient(surl);
	mhc.doAccess();

	String search = mhc.body;


	//表示数を調べる
	int count = count(search);

	//星の配列を用意する
	double star[][] = new double[count][3];

	//検索結果を表示する
	for(int i = 0 ; i < count ; i++){
		int s_size = search.indexOf("<visualGradeFrom>");
		int e_size = search.indexOf("</visualGradeFrom>");
		int s_id = search.indexOf("<hrNo>");
		int e_id = search.indexOf("</hrNo>");
		int s_jn = search.indexOf("<jpName>");
		int e_jn = search.indexOf("</jpName>");
		int s_dir = search.indexOf("<direction>");
		int e_dir = search.indexOf("</direction>");
		int s_alt = search.indexOf("<altitude>");
		int e_alt = search.indexOf("</altitude>");
		int e_star = search.indexOf("</star>");
		if (s_id >= 0 && e_id >= 0) {
			String size = search.substring(s_size + "<visualGradeFrom>".length(), e_size);
			double sizedouble = Double.parseDouble(size);
			String id = search.substring(s_id + "<hrNo>".length(), e_id);
			String jN = search.substring(s_jn + "<jpName>".length(), e_jn);
			String dir= search.substring(s_dir + "<direction>".length(), e_dir);
			String alt= search.substring(s_alt + "<altitude>".length(), e_alt);

			double sdirection = Double.parseDouble(dir);
			double saltitude  = Double.parseDouble(alt);
			if(saltitude > 0 && saltitude < 60){
				if(sdirection > homedirection - 35 && sdirection < homedirection + 35){
					//System.out.println("sdirection=" + sdirection);
					msg_content = star_content(id);
					msg_origin  = star_origin(id);
					if(msg_content.length() == 0){
						msg_content = "詳細な情報はありません";
						msg_origin = "詳細な情報はありません";
					}

					x = 1500 * XCoordinate(sdirection, homedirection);
					y = 500 * YCoordinate(saltitude);
					if(sizedouble < 2){
						starsH.append("<img src=\"image/star1-5.png\""+
									  " id=star" + id +
									  " name="+ id +
									  "size=" +
									  " onmouseover=\"over(this)\""+
									  " onmouseleave=\"leave(this)\""+
									  " onClick=\"openDetail("+id+")\"/>");
						destarsH.append("<div id=\"modalContainer"+id+"\">"+
											"<div id=\"modal"+id+"\">"+
												"<h1>"+jN+"</h1>"+
			        							"<h2>内容</h2>"+
			        							"<p>"+msg_content+"</p>"+
			        							"<h2>起源</h2>"+
			        							"<p>"+msg_origin+"<p>"+
			            						"<button class=\"peke\" onClick=\"closeBtn("+id+")\"> × </button>"+
			    							"</div>"+
			            				"</div>");
						starsC.append("#star" + id +
											"{position : absolute;"+
											" width : "+(sizedouble + 20)+"px;"+
											" height : "+(sizedouble + 20)+"px;"+
											" top : " + y + "px;"+
											" left : " + x + "px;"+
											" transition:.4s;"+
											" transform: translate(-50%, -50%);}");
						destarsC.append(
									"#modalContainer"+id+
									  		"{display: none;"+
									  		" position: fixed;"+
									  		" top: 0;"+
									  		" left: 0;"+
									  		" height: 100%;"+
									  		" width: 100%;"+
									  		" z-index: 9999;"+
									  		" background-color: rgba(0, 0, 0, .54);"+
									  		" align-items: center;"+
									  		" justify-content: center;"+
									  		" transition: all 300ms ease;}"+
									 "#modal"+id+
											"{position: relative;"+
											" display: none;"+
											" flex-direction: column;"+
						  					" width: 70%;"+
											" height: 70%;"+
										 	" background-color: white;"+
											" border-radius: 5px;"+
											" align-items: center;"+
											" justify-content: center;"+
											" padding: 10px;"+
											" font-size: 12px;}");
						}else if(sizedouble < 4){
							starsH.append("<img src=\"image/star2.1.png\""+
									  " id=star" + id +
									  " name="+ id +
									  " onmouseover=\"over(this)\""+
									  " onmouseleave=\"leave(this)\""+
									  " onClick=\"openDetail("+id+")\"/>");
						destarsH.append("<div id=\"modalContainer"+id+"\">"+
											"<div id=\"modal"+id+"\">"+
												"<h1>"+jN+"</h1>"+
			        							"<h2>内容</h2>"+
			        							"<p>"+msg_content+"</p>"+
			        							"<h2>起源</h2>"+
			        							"<p>"+msg_origin+"<p>"+
			            						"<button class=\"peke\" onClick=\"closeBtn("+id+")\"> × </button>"+
			    							"</div>"+
			            				"</div>");
						starsC.append("#star" + id +
											"{position : absolute;"+
											" width : "+(sizedouble+18)+"px;"+
											" height : "+(sizedouble+18)+"px;"+
											" top : " + y + "px;"+
											" left : " + x + "px;"+
											" transition:.4s;"+
											" transform: translate(-50%, -50%);}");
						destarsC.append(
									"#modalContainer"+id+
									  		"{display: none;"+
									  		" position: fixed;"+
									  		" top: 0;"+
									  		" left: 0;"+
									  		" height: 100%;"+
									  		" width: 100%;"+
									  		" z-index: 9999;"+
									  		" background-color: rgba(0, 0, 0, .54);"+
									  		" align-items: center;"+
									  		" justify-content: center;"+
									  		" transition: all 300ms ease;}"+
									 "#modal"+id+
											"{position: relative;"+
											" display: none;"+
											" flex-direction: column;"+
						  					" width: 70%;"+
											" height: 70%;"+
										 	" background-color: white;"+
											" border-radius: 5px;"+
											" align-items: center;"+
											" justify-content: center;"+
											" padding: 10px;"+
											" font-size: 12px;}");
						}else{
							starsH.append("<img src=\"image/star1-4.png\""+
									  " id=star" + id +
									  " name="+ id +
									  " onmouseover=\"over(this)\""+
									  " onmouseleave=\"leave(this)\""+
									  " onClick=\"openDetail("+id+")\"/>");
						destarsH.append("<div id=\"modalContainer"+id+"\">"+
											"<div id=\"modal"+id+"\">"+
												"<h1>"+jN+"</h1>"+
			        							"<h2>内容</h2>"+
			        							"<p>"+msg_content+"</p>"+
			        							"<h2>起源</h2>"+
			        							"<p>"+msg_origin+"<p>"+
			            						"<button class=\"peke\" onClick=\"closeBtn("+id+")\"> × </button>"+
			    							"</div>"+
			            				"</div>");
						starsC.append("#star" + id +
											"{position : absolute;"+
											" width : "+(sizedouble+3)+"px;"+
											" height : "+(sizedouble+3)+"px;"+
											" top : " + y + "px;"+
											" left : " + x + "px;"+
											" transition:.4s;"+
											" transform: translate(-50%, -50%);}");
						destarsC.append(
									"#modalContainer"+id+
									  		"{display: none;"+
									  		" position: fixed;"+
									  		" top: 0;"+
									  		" left: 0;"+
									  		" height: 100%;"+
									  		" width: 100%;"+
									  		" z-index: 9999;"+
									  		" background-color: black;"+
									  		" align-items: center;"+
									  		" justify-content: center;"+
									  		" transition: all 300ms ease;}"+
									 "#modal"+id+
											"{position: relative;"+
											" display: none;"+
											" flex-direction: column;"+
						  					" width: 70%;"+
											" height: 70%;"+
										 	" background-color: white;"+
											" border-radius: 5px;"+
											" align-items: center;"+
											" justify-content: center;"+
											" padding: 10px;"+
											" font-size: 12px;}");
						}
					}
				}
				//確認用
				//sb.append(id + "," + dir + "," + alt + "<br>");
			}
		search = search.substring(e_star + "</star>".length());
	}

	/*
	msg += "((BODY))<br>";
	msg += optionEscape ? prettyPrintHTML(mhc.body) : mhc.body;
	*/

	//msg = sb.toString();
	stars_html = starsH.toString();
	stars_css = starsC.toString();
	destars_html = destarsH.toString();
	destars_css = destarsC.toString();

    } catch(MalformedURLException e) {
	msg = "URLが不適切です。";
    } catch(NullPointerException e){
    msg = "検索条件を指定してください";
    } catch(ProtocolException e) {
   	msg = "HTTPの通信に失敗しました。";
    } catch(IOException e) {
    msg = "何らかの不具合が発生しました。";
    }
//}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>syszora_search</title>
        <style type="text/css">
		@import url('https://fonts.googleapis.com/css?family=Sawarabi+Mincho&display=swap');
			body	{font-family: 'Sawarabi Mincho', sans-serif;}

			content	{width: 500px;
					 font-size: 24px;
					 line-height: 1.5;}
			input[type="submit"]{width: 300px;
								 font-size: 24px;
								 background-color: #ffaa00;
								 background-image: -webkit-gradient(linear,
								 									left top, left bottom,
								 									from(#ffe7b8),to(#ffaa00));
								 background-image: -webkit-linear-gradient(top, #ffe7b8 0%, #ffaa00 100%);
								 background-image: linear-gradient(to bottom, #ffe7b8 0%, #ffaa00 100%)
								 border: solid 1px #aaaaaa;
								 border-radius: 10px;
								 paddig-top: 10px;
								 padding-bottom: 10px}
			#stars	{position: relative;
			         margin : 20px;
			         width: 100%;
			         height: 100%;}

			<%= stars_css %>

			<%= destars_css %>

			.peke {
				  position: absolute;
				  top: 8px;
				  right: 8px;
				  font-size: 25px;
			}
			@keyframes fadeIn{
			    from{
			        opacity: 0;
			    }
			    to{
			        opacity: 1;
			    }
			}

			.fadeIn {
			    animation: fadeIn .5s ease 0s;
			}
			@keyframes fadeOut{
			    from{
			        opacity: 1;
			    }
			    to{
			        opacity: 0;
			    }
			}
			.fadeOut {
			    animation: fadeOut .3s ease 0s;
			    animation-fill-mode: forwards;
			}

			.background{
				position:absolute;
				width:128%;
				height:135%;
				background-image: url(<%= img %>);
				background-repeat:no-repeat;
				background-size:cover;
				background-position: center;
				top:-25px;
			}//追記
        </style>

        <script type="text/javascript">
            function over(x) {
			    x.style.width = "30px";
			    x.style.height = "30px";
			}

		    function leave(x) {
			    x.style.width = "15px";
			    x.style.height = "15px";
			}

		    function openDetail(x) {
				//console.log(x);
				var container = document.getElementById('modalContainer' + x);
				var modal = document.getElementById('modal' + x);
				//var modal = 'modal' + x;
				//var container = 'modalContainer'+ x;
				modal.idName = 'fadeIn';
            	modal.style.display = 'flex';
				container.idName = 'fadeIn';
            	container.style.display = 'flex';
          	}

		    function closeBtn(x) {
		    	var container = document.getElementById('modalContainer' + x);
				var modal = document.getElementById('modal' + x);
				modal.idName = 'fadeOut';
            	modal.style.display = 'none';
				container.idName = 'fadeOut';
            	container.style.display = 'none';
          	}

        </script>
    </head>
    <body>
    	<div class="background"></div>
    	<%= request.getRequestURI() %>
<!--    	<header>
			<h1>syszora_search</h1>
		</header>


		<content>
 	        <form action="<%= request.getRequestURI() %>" method="GET">
	            <p>観測日時:</p>
	            <select name="year">
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					<option value="2025">2025</option>
				</select> 年
				<select name="month">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select> 月
				<select name="day">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
					<option value="31">31</option>
				</select> 日
				<select name="hour">
					<option value="0">0</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
					<option value="13">13</option>
					<option value="14">14</option>
					<option value="15">15</option>
					<option value="16">16</option>
					<option value="17">17</option>
					<option value="18">18</option>
					<option value="19">19</option>
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
				</select> 時
	            <input type="submit" value="検索">
	        </form>
-->
	        <%= msg %><br>
	        <div id = "stars">
		        <%= stars_html %>
			</div>
			<%= destars_html %>
			<div id="modalContainer">

			</div>
			<div id="window">
			<%=window %>
			</div>
		</content>
    </body>
</html>