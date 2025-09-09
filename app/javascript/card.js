document.addEventListener("DOMContentLoaded", function() {
  // 公開鍵がなければ処理しない
  if (!gon.public_key) return;

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();

  // Elements 作成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  if (!form) return;

  form.addEventListener("submit", function(e) {
    e.preventDefault();

    // すでに hidden token が存在する場合は再度生成せず submit
    const existingTokenInput = document.querySelector('input[name="order_address[token]"]');
    if (existingTokenInput && existingTokenInput.value !== "") {
      form.submit();
      return;
    }

    // token がまだない場合のみ生成
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        alert("カード情報に誤りがあります: " + response.error.message);
      } else {
        const token = response.id;

        // hidden input を作成または更新
        let tokenInput = existingTokenInput;
        if (!tokenInput) {
          tokenInput = document.createElement('input');
          tokenInput.setAttribute('type', 'hidden');
          tokenInput.setAttribute('name', 'order_address[token]');
          form.appendChild(tokenInput);
        }
        tokenInput.value = token;

        // フォーム送信
        form.submit();
      }

      // Elements をクリア
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
  });
});

