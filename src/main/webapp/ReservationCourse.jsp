<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Store, java.util.*, model.User "%>
<% 
String action = (String)session.getAttribute("action"); 
List<Store> storeList = (List<Store>)session.getAttribute("storeList");
// 送信先の判定
String formAction = "UserController";
if ("ByAdmin".equals(action)) {
    formAction = "AdminController";
}

User user = (User) session.getAttribute("LoginUser");

String date =  (String)session.getAttribute("date");
String formattedDate = "未選択"; //初期値

if (date != null && date.contains("-")) {
    // "2026-02-16" を "-" で分割して配列にする
    String[] parts = date.split("-");
    // 配列の 0:年, 1:月, 2:日 を使って組み立て
    formattedDate = parts[0] + "年" + parts[1] + "月" + parts[2] + "日";
}
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>予約登録システム - コース選択</title>
    <link rel="icon" href="./image/assets/user/ロゴ完成_金色b.svg">
    <link rel="stylesheet" href="./css/user/style.css">
    <link rel="stylesheet" href="./css/user/reservation_courseStyle.css">
    <link rel="stylesheet" href="./css/user/hamburgerStyle.css">
</head>
<body>
	<header class="header" data-name="ヘッダー">
	<% if(action.equals("ByUser")){ %>
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
		</div>
		<button class="hamburger-menu" id="hamburgerBtn" aria-label="メニュー">
            <img src="./image/assets/user/hamburger.svg" alt="メニュー">
        </button>
		<!-- PC用ナビゲーション -->
        <nav class="nav-menu">
			<a href="./whats_Shisha.jsp" class="nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="nav-link">System</a>
			<a	href="./menu.jsp" class="nav-link">Menu</a> 
			<a href="./topics.jsp" class="nav-link">Topics</a> 
			<a href="./contact.jsp" class="nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="nav-link">Reservation</a>
			<%if (user != null) { %>
				<div class="nav-member-group">
					<a href="UserController?command=MyPage" class="nav-link">Member</a>
					<a href="UserController?command=logout" class="nav-logout-link">logout</a>
				</div>
			<% } else { %>
				<a href="./Login.jsp" class="nav-link">Login</a>
			<% } %>
		</nav>
        <!-- スマホ用ナビゲーション -->
        <nav class="mobile-nav" id="mobileNav">
            <a href="./whats_Shisha.jsp" class="mobile-nav-link">What's</a> 
			<a href="./how_to_Use.jsp" class="mobile-nav-link">Use</a> 
			<a href="./system-introduction.jsp" class="mobile-nav-link">System</a>
			<a	href="./menu.jsp" class="mobile-nav-link">Menu</a> 
			<a href="./topics.jsp" class="mobile-nav-link">Topics</a> 
			<a href="./contact.jsp" class="mobile-nav-link">Contact</a>
			<a href="UserController?command=reservationDate" class="mobile-nav-link">Reservation</a>
			<%if (user != null) { %>
				<a href="UserController?command=MyPage" class="mobile-nav-link">Member</a>
				<a href="UserController?command=logout" class="mobile-nav-link mobile-nav-logout">Logout</a>
			<% } else { %>
				<a href="./Login.jsp" class="mobile-nav-link">Login</a>
			<% } %>
        </nav>
	<% } %>
	</header>
	
    <main>
        <div class="container">
            <div class="step_indicator">
            	<h2>予約登録</h2>
                <div class="step_image">
                    <img src="./image/assets/user/coursepage.svg" alt="">
                </div>
            </div>

            <div class="course_selection_area">
                <h3>コースを選択してください</h3>
                <p class="selected_date">選択日:<%= formattedDate %></p>
                
                <form action="<%= formAction %>" method="get">
                    <div class="storeSerect">
                        <label for="store">店舗選択：</label>
                        <select name="storeNumber" id="store" required>
                            <% if(storeList != null) { 
                                for(Store store : storeList){ %>
                                <option value="<%= store.getStoreNumber()%>">
                                    <%= store.getStoreName() %>
                                </option>
                            <% } 
                            } %>
                        </select>
                    </div>

                    <div class="course_cards">
                        <label style="display: block; cursor: pointer;">
                            <input type="submit" name="course" value="60" style="display:none;" checked>
                            <div class="course_card">
                                <div class="course_icon">
                                    <img src="./image/assets/user/courseicon.svg" alt="時計">
                                </div>
                                <h4>1時間のコース</h4>
                                <p class="duration">60分</p>
                            </div>
                        </label>

                        <label style="display: block; cursor: pointer;">
                            <input type="submit" name="course" value="90" style="display:none;">
                            <div class="course_card">
                                <div class="course_icon">
                                    <img src="./image/assets/user/courseicon.svg" alt="時計">
                                </div>
                                <h4>1時間30分のコース</h4>
                                <p class="duration">90分</p>
                            </div>
                        </label>

                        <label style="display: block; cursor: pointer;">
                            <input type="submit" name="course" value="120" style="display:none;">
                            <div class="course_card">
                                <div class="course_icon">
                                    <img src="./image/assets/user/courseicon.svg" alt="時計">
                                </div>
                                <h4>2時間のコース</h4>
                                <p class="duration">120分</p>
                            </div>
                        </label>
                    </div>

                    <input type="hidden" name="command" value="Seat">
                </form>

                <a href="#" class="back_link" onclick="history.back(); return false;">← 日付選択に戻る</a>
            </div>

            <button class="restart_button" onclick="location.href='UserController?command=reservationDate'">最初からやり直す</button>
        </div>
    </main>
    <footer>
        <p><small>&copy;The Shisha Honjin</small></p>
    </footer>
</body>
</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>