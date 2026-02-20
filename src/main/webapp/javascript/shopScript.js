// ★★★ 店舗写真のパス設定 ★★★
const shopImages = [
    '../assets/shopimg1.jpeg',
    '../assets/shopimg2.jpg',
    '../assets/shopimg3.webp',
    '../assets/shopimg4.jpeg',
    '../assets/shopimg5.jpg',
    '../assets/shopimg6.jpg',
];

// 店舗写真の代替テキスト
const shopImageAlts = [
    'カウンター',
    '店内の様子1',
    '店内の様子2',
    'カウンター席',
    'テーブル席',
    ''
];

// === 店舗写真スライダーの動作 ===
let shopCurrentIndex = 0;
let shopAutoSlideInterval = null;
const shopSliderTrack = document.getElementById('shopSliderTrack');
const shopDotsContainer = document.getElementById('shopDotsContainer');
const shopCurrentPageEl = document.getElementById('shopCurrentPage');
const shopTotalPagesEl = document.getElementById('shopTotalPages');
const shopPrevBtn = document.getElementById('shopPrevBtn');
const shopNextBtn = document.getElementById('shopNextBtn');

// 店舗写真スライダー初期化
function initShopSlider() {
    // 画像をスライダーに追加
    shopImages.forEach((imagePath, index) => {
        const slideItem = document.createElement('div');
        slideItem.className = 'slide-item';

        const img = document.createElement('img');
        img.src = imagePath;
        img.alt = shopImageAlts[index] || `店舗写真 ${index + 1}`;

        slideItem.appendChild(img);
        shopSliderTrack.appendChild(slideItem);
    });

    // ドットを作成
    shopImages.forEach((_, index) => {
        const dot = document.createElement('div');
        dot.className = 'dot';
        if (index === 0) dot.classList.add('active');
        dot.addEventListener('click', () => {
            goToShopSlide(index);
            resetShopAutoSlide(); // 手動操作時は自動スライドをリセット
        });
        shopDotsContainer.appendChild(dot);
    });

    // 総ページ数を表示
    shopTotalPagesEl.textContent = shopImages.length;
    
    // 自動スライド開始
    startShopAutoSlide();
}

// 店舗写真スライドを移動する関数
function goToShopSlide(index) {
    shopCurrentIndex = index;
    const offset = -shopCurrentIndex * 100;
    shopSliderTrack.style.transform = `translateX(${offset}%)`;

    // ドットの更新
    const dots = shopDotsContainer.querySelectorAll('.dot');
    dots.forEach((dot, i) => {
        dot.classList.toggle('active', i === shopCurrentIndex);
    });

    // ページ番号の更新
    shopCurrentPageEl.textContent = shopCurrentIndex + 1;
}

// 店舗写真：次のスライドへ
function nextShopSlide() {
    shopCurrentIndex = (shopCurrentIndex + 1) % shopImages.length;
    goToShopSlide(shopCurrentIndex);
}

// 店舗写真：前のスライドへ
function prevShopSlide() {
    shopCurrentIndex = (shopCurrentIndex - 1 + shopImages.length) % shopImages.length;
    goToShopSlide(shopCurrentIndex);
}

// 自動スライド開始
function startShopAutoSlide() {
    shopAutoSlideInterval = setInterval(() => {
        nextShopSlide();
    }, 4000); // 4秒ごとに切り替え
}

// 自動スライドをリセット（手動操作時）
function resetShopAutoSlide() {
    clearInterval(shopAutoSlideInterval);
    startShopAutoSlide();
}

// 店舗写真ボタンのイベント
shopNextBtn.addEventListener('click', () => {
    nextShopSlide();
    resetShopAutoSlide();
});

shopPrevBtn.addEventListener('click', () => {
    prevShopSlide();
    resetShopAutoSlide();
});

// 店舗写真：キーボード操作（矢印キー）
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') {
        prevShopSlide();
        resetShopAutoSlide();
    }
    if (e.key === 'ArrowRight') {
        nextShopSlide();
        resetShopAutoSlide();
    }
});

// 店舗写真：タッチスワイプ対応（スマホ用）
let shopTouchStartX = 0;
let shopTouchEndX = 0;

shopSliderTrack.addEventListener('touchstart', (e) => {
    shopTouchStartX = e.changedTouches[0].screenX;
});

shopSliderTrack.addEventListener('touchend', (e) => {
    shopTouchEndX = e.changedTouches[0].screenX;
    handleShopSwipe();
    resetShopAutoSlide();
});

function handleShopSwipe() {
    if (shopTouchEndX < shopTouchStartX - 50) nextShopSlide();
    if (shopTouchEndX > shopTouchStartX + 50) prevShopSlide();
}

// 店舗写真スライダー初期化実行
initShopSlider();