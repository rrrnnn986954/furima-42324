document.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // ページに無ければ終了

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value, 10);

    // 価格が数値で300〜9999999の範囲のみ計算
    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const tax = Math.floor(price * 0.1); // 小数点切り捨て
      const profit = Math.floor(price - tax);

      document.getElementById("add-tax-price").textContent = tax;
      document.getElementById("profit").textContent = profit;
    } else {
      document.getElementById("add-tax-price").textContent = "";
      document.getElementById("profit").textContent = "";
    }
  });
});