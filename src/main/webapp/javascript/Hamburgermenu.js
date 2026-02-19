// ハンバーガーメニューの開閉機能
document.addEventListener('DOMContentLoaded', function() {
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const hamburgerIcon = hamburgerBtn.querySelector('img');
    const mobileNav = document.getElementById('mobileNav');
    const body = document.body;
    
    // オーバーレイ要素を作成
    const overlay = document.createElement('div');
    overlay.className = 'overlay';
    body.appendChild(overlay);
    
    // ハンバーガーメニューボタンのクリックイベント
    hamburgerBtn.addEventListener('click', function() {
        toggleMenu();
    });
    
    // オーバーレイのクリックイベント
    overlay.addEventListener('click', function() {
        closeMenu();
    });
    
    // メニュー内のリンクをクリックした時にメニューを閉じる
    const mobileNavLinks = document.querySelectorAll('.mobile-nav-link');
    mobileNavLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            closeMenu();
        });
    });
    
    // メニューの開閉を切り替える関数
    function toggleMenu() {
        mobileNav.classList.toggle('active');
        overlay.classList.toggle('active');
        
        // メニューが開いている時はbodyのスクロールを防ぐ
        if (mobileNav.classList.contains('active')) {
            body.style.overflow = 'hidden';
            // アイコンを開いた状態に変更
            hamburgerIcon.src = './image/assets/user/hamburgerOpen.svg';
        } else {
            body.style.overflow = '';
            // アイコンを閉じた状態に変更
            hamburgerIcon.src = './image/assets/user/hamburger.svg';
        }
    }
    
    // メニューを閉じる関数
    function closeMenu() {
        mobileNav.classList.remove('active');
        overlay.classList.remove('active');
        body.style.overflow = '';
        // アイコンを閉じた状態に変更
        hamburgerIcon.src = './image/assets/user/hamburger.svg';
    }
    
    // ウィンドウサイズが変更された時の処理
    window.addEventListener('resize', function() {
        // PC画面サイズになった時にメニューを閉じる
        if (window.innerWidth > 1024) {
            closeMenu();
        }
    });
});