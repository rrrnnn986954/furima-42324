const initItemAmount = () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // ページに無ければ終了

  const updatePrice = () => {
    const price = parseInt(priceInput.value, 10);
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const tax = Math.floor(price * 0.1); // 消費税（小数点切り捨て）
      const profit = price - tax;

      addTaxDom.textContent = tax;
      profitDom.textContent = profit;
    } else {
      addTaxDom.textContent = "";
      profitDom.textContent = "";
    }
  };

  // 入力イベント
  priceInput.addEventListener("input", updatePrice);

  // ページ表示時に初期値も反映
  updatePrice();
};

// Turboロード後とTurboレンダー後の両方に対応
document.addEventListener("turbo:load", initItemAmount);
document.addEventListener("turbo:render", initItemAmount);
