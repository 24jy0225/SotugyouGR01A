// ヘッダー要素を取得
const logo = document.getElementById('logo');

// 監視用の番兵要素を作成（ページ最上部に配置）
const sentinel = document.createElement('div');
sentinel.style.position = 'absolute';
sentinel.style.top = '0';
sentinel.style.height = '1px';
sentinel.style.width = '100%';
sentinel.style.pointerEvents = 'none'; // クリックイベントを無効化
document.body.prepend(sentinel);

// Intersection Observerを作成
const observer = new IntersectionObserver(
	(entries) => {
		entries.forEach(entry => {
			if (entry.isIntersecting) {
				// 番兵が表示されている = ページトップにいる
				logo.classList.remove('scrolled');
			} else {
				// 番兵が見えなくなった = トップから離れた
				logo.classList.add('scrolled');

			}
		});
	},
	{
		// rootMargin: ビューポートからの余白（必要に応じて調整）
		rootMargin: '0px',
		// threshold: 監視要素の何%が見えたら発火するか
		threshold: 0
	}
);

// 監視を開始
observer.observe(sentinel);