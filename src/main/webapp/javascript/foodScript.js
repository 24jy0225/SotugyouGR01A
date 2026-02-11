// ★★★ ドリンクメニュー画像のパス設定 ★★★
const foodMenuImages = [
    '../image/assets/user/menu/food1.webp',
    '../image/assets/user/menu/food2.webp',
    '../image/assets/user/menu/food3.webp',
    '../image/assets/user/menu/food4.webp',
    '../image/assets/user/menu/food5.webp'
];

// ドリンク画像の代替テキスト
const foodImageAlts = [
    '1',
    '2',
    '3',
    '4',
    '5'
];

// === ドリンクスライダーの動作 ===
let foodCurrentIndex = 0;
const foodSliderTrack = document.getElementById('foodSliderTrack');
const foodDotsContainer = document.getElementById('foodDotsContainer');
const foodCurrentPageEl = document.getElementById('foodCurrentPage');
const foodTotalPagesEl = document.getElementById('foodTotalPages');
const foodPrevBtn = document.getElementById('foodPrevBtn');
const foodNextBtn = document.getElementById('foodNextBtn');

// ドリンクスライダー初期化
function initfoodSlider() {
    // 画像をスライダーに追加
    foodMenuImages.forEach((imagePath, index) => {
        const slideItem = document.createElement('div');
        slideItem.className = 'slide-item';

        const img = document.createElement('img');
        img.src = imagePath;
        img.alt = foodImageAlts[index] || `ドリンクメニュー ${index + 1}`;

        slideItem.appendChild(img);
        foodSliderTrack.appendChild(slideItem);
    });

    // ドットを作成
    foodMenuImages.forEach((_, index) => {
        const dot = document.createElement('div');
        dot.className = 'dot';
        if (index === 0) dot.classList.add('active');
        dot.addEventListener('click', () => goTofoodSlide(index));
        foodDotsContainer.appendChild(dot);
    });

    // 総ページ数を表示
    foodTotalPagesEl.textContent = foodMenuImages.length;
}

// ドリンクスライドを移動する関数
function goTofoodSlide(index) {
    foodCurrentIndex = index;
    const offset = -foodCurrentIndex * 100;
    foodSliderTrack.style.transform = `translateX(${offset}%)`;

    // ドットの更新
    const dots = foodDotsContainer.querySelectorAll('.dot');
    dots.forEach((dot, i) => {
        dot.classList.toggle('active', i === foodCurrentIndex);
    });

    // ページ番号の更新
    foodCurrentPageEl.textContent = foodCurrentIndex + 1;
}

// ドリンク：次のスライドへ
function nextfoodSlide() {
    foodCurrentIndex = (foodCurrentIndex + 1) % foodMenuImages.length;
    goTofoodSlide(foodCurrentIndex);
}

// ドリンク：前のスライドへ
function prevfoodSlide() {
    foodCurrentIndex = (foodCurrentIndex - 1 + foodMenuImages.length) % foodMenuImages.length;
    goTofoodSlide(foodCurrentIndex);
}

// ドリンクボタンのイベント
foodNextBtn.addEventListener('click', nextfoodSlide);
foodPrevBtn.addEventListener('click', prevfoodSlide);

// ドリンク：キーボード操作（矢印キー）
document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowLeft') prevfoodSlide();
    if (e.key === 'ArrowRight') nextfoodSlide();
});

// ドリンク：タッチスワイプ対応（スマホ用）
let foodTouchStartX = 0;
let foodTouchEndX = 0;

foodSliderTrack.addEventListener('touchstart', (e) => {
    foodTouchStartX = e.changedTouches[0].screenX;
});

foodSliderTrack.addEventListener('touchend', (e) => {
    foodTouchEndX = e.changedTouches[0].screenX;
    handlefoodSwipe();
});

function handlefoodSwipe() {
    if (foodTouchEndX < foodTouchStartX - 50) nextfoodSlide();
    if (foodTouchEndX > foodTouchStartX + 50) prevfoodSlide();
}

// ドリンクスライダー初期化実行
initfoodSlider();