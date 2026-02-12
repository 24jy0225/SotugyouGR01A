<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="model.Store, java.util.*"%>
<% 
String action = (String)session.getAttribute("action"); 
List<Store> storeList = (List<Store>)session.getAttribute("storeList");
// 送信先の判定
String formAction = "UserController";
if ("ByAdmin".equals(action)) {
    formAction = "AdminController";
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
</head>
<body>
    <header class="systemheader" data-name="ヘッダー">
        <div class="logos" id="logo" onclick="location.href='./top.html'">
            <img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo" class="logo">
        </div>
        <nav class="system-nav-menu">
            <a href="./Login.jsp" class="nav-link">Login</a>
        </nav>
    </header>
    <main>
        <div class="container">
            <div class="step_indicator">
                <h2>予約登録システム</h2>
                <div class="step_image">
                    <img src="./image/assets/user/coursepage.svg" alt="">
                </div>
            </div>

            <div class="course_selection_area">
                <h3>コースを選択してください</h3>
                <p class="selected_date">選択日:12月25日(木)</p>
                
                <form action="<%= formAction %>" method="get">
                    <div style="margin-bottom: 20px; text-align: center;">
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
                            <input type="radio" name="course" value="60" style="display:none;" checked>
                            <div class="course_card">
                                <div class="course_icon">
                                    <img src="./image/assets/user/courseicon.svg" alt="時計">
                                </div>
                                <h4>1時間のコース</h4>
                                <p class="duration">60分</p>
                            </div>
                        </label>

                        <label style="display: block; cursor: pointer;">
                            <input type="radio" name="course" value="90" style="display:none;">
                            <div class="course_card">
                                <div class="course_icon">
                                    <img src="./image/assets/user/courseicon.svg" alt="時計">
                                </div>
                                <h4>1時間30分のコース</h4>
                                <p class="duration">90分</p>
                            </div>
                        </label>

                        <label style="display: block; cursor: pointer;">
                            <input type="radio" name="course" value="120" style="display:none;">
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
                    <div style="text-align: center; margin-top: 20px;">
                        <input type="submit" value="次に進む" class="restart_button" style="background-color: #d4af37; color: white; border: none; width: 200px;">
                    </div>
                </form>

                <a href="#" class="back_link" onclick="history.back(); return false;">← 日付選択に戻る</a>
            </div>

            <button class="restart_button" onclick="location.href='./top.jsp'">最初からやり直す</button>
        </div>
    </main>
    <footer>
        <p><small>&copy;The Shisha Honjin</small></p>
    </footer>
</body>
</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>