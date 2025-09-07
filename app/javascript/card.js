const pay = () => {
  const form = document.getElementById('charge-form');
  const numberContainer = document.getElementById('number-form');
  const expiryContainer = document.getElementById('expiry-form');
  const cvcContainer = document.getElementById('cvc-form');

  console.log("pay function called");
  console.log(form, numberContainer, expiryContainer, cvcContainer);

  if (!form || !numberContainer || !expiryContainer || !cvcContainer) return;

  const payjp = Payjp('pk_test_df4ed8349ca110801ba9ec82');
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", function(e) {
    e.preventDefault();
    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        alert(response.error.message);
      } else {
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'payjpToken');
        tokenInput.setAttribute('value', response.id);
        form.appendChild(tokenInput);
        form.submit();
      }
    });
  });
};

document.addEventListener("turbo:load", pay);
