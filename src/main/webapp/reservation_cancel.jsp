<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./image/assets/user/ロゴマーク_金色b.webp">
<link rel="stylesheet" href="./css/user/style.css">
<link rel="stylesheet" href="./css/user/reservation_cancelStyle.css">
<link rel="stylesheet" href="./css/user/hamburgerStyle.css">
    <title>Reservation cancel</title>
</head>

<body>
    <!-- ヘッダー -->
	<header class="header" data-name="ヘッダー">
		<div class="logos" id="logo" onclick="location.href='./top.jsp'">
			<img src="./image/assets/user/ロゴタイプ_金色b.svg" alt="logo"
				class="logo">
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
	</header>
    <main>
        <div class="cancel-container">
            <h1 class="cancel-page-title">予約のキャンセル</h1>
            <p class="cancel-description">以下の予約をキャンセルします。内容をご確認ください。</p>

            <table class="reservation-info">
                <tr>
                    <td class="info-title">
                        予約情報
                    </td>
                </tr>
                <tr>
                    <td class="info-label">
                        予約番号:
                    </td>
                    <td class="info-value">
                        RES-2025-001
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/personicon.svg" alt="">
                        <span class="info-label">予約者名:</span>
                    </td>
                    <td class="info-value">
                        山田 太郎
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/personicon.svg" alt="">
                        <span class="info-label">予約人数:</span>
                    </td>
                    <td class="info-value">
                        2名
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/dayicon.svg" alt="">
                        <span class="info-label">日付:</span>
                    </td>
                    <td class="info-value">
                        2025年11月25日
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/timeicon.svg" alt="">
                        <span class="info-label">開始時間:</span>
                    </td>
                    <td class="info-value">
                        19:00
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/timeicon.svg" alt="">
                        <span class="info-label">終了時間:</span>
                    </td>
                    <td class="info-value">
                        21:00
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/courseicon.svg" alt="">
                        <span class="info-label">コース:</span>
                    </td>
                    <td class="info-value">
                        スペシャルコース
                    </td>
                </tr>
                <tr>
                    <td>
                        <img src="./image/assets/user/seaticon.svg" alt="">
                        <span class="info-label">座席:</span>
                    </td>
                    <td class="info-value">
                        座席2
                    </td>
                </tr>
            </table>
            <div class="warning-box">
                <span class="warning-icon">⚠</span>
                <p class="warning-text">キャンセルポリシー: 予約日の2日前以降のキャンセルには、キャンセル料が発生する場合があります。</p>
            </div>

            <button type="button" class="cancel-submit-btn" id="openBtn">予約をキャンセルする</button>
        </div>
    </main>
    <footer>
        <p><small>&copy;The Shisha Honjin</small></p>
    </footer>
    <dialog id="confirmModal">
        <h2 class="modal-title">予約をキャンセルしますか？</h2>
        <p class="modal-message">この操作は取り消せません。予約番号 RES-2025-001 をキャンセルしてもよろしいですか？</p>
        
        <div class="modal-buttons">
            <button type="button" class="modal-btn modal-btn-confirm" id="confirmBtn">キャンセルを確定する</button>
            <button type="button" class="modal-btn modal-btn-back" id="closeBtn">戻る</button>
        </div>
    </dialog>
    <script>
        const modal = document.getElementById('confirmModal');
        const openBtn = document.getElementById('openBtn');
        const closeBtn = document.getElementById('closeBtn');
        const confirmBtn = document.getElementById('confirmBtn');

        // ボタンで開く
        openBtn.addEventListener('click', () => {
            modal.showModal(); // これだけで中央に表示 + 背景固定になります
        });

        // 「いいえ」ボタンで閉じる
        closeBtn.addEventListener('click', () => {
            modal.close();
        });

        // 「はい」ボタンの処理
        confirmBtn.addEventListener('click', () => {
            modal.close();
        });
    </script>
</body>

</html>
<script type="text/javascript" src="./javascript/logoScript.js"></script>
<script type="text/javascript" src="./javascript/Hamburgermenu.js"></script>