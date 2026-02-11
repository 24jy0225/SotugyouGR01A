// ★★★ ドリンクメニュー画像のパス設定 ★★★
const drinkMenuImages = [
    '../image/assets/user/menu/softdrink1.webp',
    '../image/assets/user/menu/softdrink2.webp',
    '../image/assets/user/menu/alcoholdrink1.webp',
    '../image/assets/user/menu/alcoholdrink2.webp',
    '../image/assets/user/menu/cocktaildrink1.webp',
    '../image/assets/user/menu/cocktaildrink2.webp'
];

// ドリンク画像の代替テキスト
const drinkImageAlts = [
    'ソフトドリンク1',
    'ソフトドリンク2',
    'アルコールドリンク1',
    'アルコールドリンク2',
    'カクテル1',
    'カクテル2'
];

// === ドリンクスライダーの動作 ===
let drinkCurrentIndex = 0;
const drinkSliderTrack = document.getElementById('drinkSliderTrack');
const drinkDotsContainer = document.getElementById('drinkDotsContainer');
const drinkCurrentPageEl = document.getElementById('drinkCurrentPage');
const drinkTotalPagesEl = document.getElementById('drinkTotalPages');
const drinkPrevBtn = document.getElementById('drinkPrevBtn');
const drinkNextBtn = document.getElementById('drinkNextBtn');

// ドリンクスライダー初期化
function initDrinkSlider() {
    // 画像をスライダーに追加
    drinkMenuImages.forEach((imagePath, index) => {
        const slideItem = document.createElement('div');
        slideItem.className = 'slide-item';

        const img = document.createElement('img');
        img.src = imagePath;
        img.alt = drinkImageAlts[index] || `ドリンクメニュー ${index + 1}`;

        slideItem.appendChild(img);
        drinkSliderTrack.appendChild(slideItem);
    });

    // ドットを作成
    drinkMenuImages.forEach((_, index) => {
        const dot = document.createElement('div');
        dot.className = 'dot';
        if (index === 0) dot.classList.add('active');
        dot.addEventListener('click', () => goToDrinkSlide(index));
        drinkDotsContainer.appendChild(dot);
    });

    // 総ページ数を表示
    drinkTotalPagesEl.textContent = drinkMenuImages.length;
}

// ドリンクスライドを移動する関数
function goToDrinkSlide(index) {
    drinkCurrentIndex = index;
    const offset = -drinkCurrentIndex * 100;
    drinkSliderTrack.style.transform = `translateX(${offset}%)`;

    // ドットの更新
    const dots = drinkDotsContainer.querySelectorAll('.dot');
    dots.forEach((dot, i) => {
        dot.classList.toggle('active', i === drinkCurrentIndex);
    });

    // ページ番号の更新
    drinkCurrentPageEl.textContent = drinkCurrentIndex + 1;
}

// ドリンク：次のスライドへ
function nextDrinkSlide() {
    drinkCurrentIndex = (drinkCurrentIndex + 1) % drinkMenuImages.length;
    goToDrinkSlide(drinkCurrentIndex);
}

// ドリンク：前のスライドへ
function prevDrinkSlide() {
    drinkCurrentIndex = (drinkCurrentIndex - 1 + drinkMenuImages.length) % drinkMenuImages.length;
    goToDrinkSlide(drinkCurrentIndex);
}

// ドリンクボタンのイベント
drinkNextBtn.addEventListener('click', nextDrinkSlide);
drinkPrevBtn.addEventListener('click', prevDrinkSlide);

// ドリンク：キーボード操作（矢印キー）
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') prevDrinkSlide();
    if (e.key === 'ArrowRight') nextDrinkSlide();
});

// ドリンク：タッチスワイプ対応（スマホ用）
let drinkTouchStartX = 0;
let drinkTouchEndX = 0;

drinkSliderTrack.addEventListener('touchstart', (e) => {
    drinkTouchStartX = e.changedTouches[0].screenX;
});

drinkSliderTrack.addEventListener('touchend', (e) => {
    drinkTouchEndX = e.changedTouches[0].screenX;
    handleDrinkSwipe();
});

function handleDrinkSwipe() {
    if (drinkTouchEndX < drinkTouchStartX - 50) nextDrinkSlide();
    if (drinkTouchEndX > drinkTouchStartX + 50) prevDrinkSlide();
}

// ドリンクスライダー初期化実行
initDrinkSlider();