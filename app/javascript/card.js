const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const numberContainer = document.getElementById('number-form');
  const expiryContainer = document.getElementById('expiry-form');
  const cvcContainer = document.getElementById('cvc-form');
  if (!numberContainer || !expiryContainer || !cvcContainer) return;

  if (!gon.public_key) {
    console.error("Payjp public key is not defined.");
    return;
  }

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener('submit', function(e) {
    e.preventDefault();

    payjp.createToken(numberElement).then(function(response) {
      if (response.error) {
        alert(response.error.message);
      } else {
        const tokenInput = document.createElement('input');
        tokenInput.setAttribute('type', 'hidden');
        tokenInput.setAttribute('name', 'order_address[token]');
        tokenInput.setAttribute('value', response.id);
        form.appendChild(tokenInput);
        form.submit();
      }
    });
  });
};

document.addEventListener('DOMContentLoaded', pay);
