const pay = () => {
  if (!gon.public_key) return;

  const form = document.getElementById('charge-form');
  if (!form) return;

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", function(e) {
    e.preventDefault();

    const existingTokenInput = document.querySelector('input[name="order_address[token]"]');

    if (existingTokenInput && existingTokenInput.value !== "") {
      form.submit();
      return;
    }

    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        alert("カード情報に誤りがあります: " + response.error.message);
      } else {
        const token = response.id;

        let tokenInput = existingTokenInput;
        if (!tokenInput) {
          tokenInput = document.createElement('input');
          tokenInput.setAttribute('type', 'hidden');
          tokenInput.setAttribute('name', 'order_address[token]');
          form.appendChild(tokenInput);
        }
        tokenInput.value = token;

        form.submit();
      }

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
    });
  });
};

// Turbo 対応：初回読み込み + render 後も動作
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);


