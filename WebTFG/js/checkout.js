

document.addEventListener("submit", function (e) {
  e.preventDefault();

  // Datos del formulario principal
  const name = document.getElementById("name").value.trim();
  const email = document.getElementById("email").value.trim();
  const address = document.getElementById("address").value.trim();

  // Datos de la tarjeta
  const cardNumber = document.getElementById("card-number").value.trim();
  const expiry = document.getElementById("expiry").value.trim();
  const cvv = document.getElementById("cvv").value.trim();

  // Validaciones
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  const cardNumberRegex = /^\d{16}$/;
  const expiryRegex = /^(0[1-9]|1[0-2])\/\d{2}$/;
  const cvvRegex = /^\d{3}$/;

  if (!name || !email || !address || !cardNumber || !expiry || !cvv) {
    showMessage("Por favor, rellena todos los campos.");
    return;
  }

  if (!emailRegex.test(email)) {
    showMessage("Por favor, introduce un correo electrónico válido.");
    return;
  }

  if (!cardNumberRegex.test(cardNumber)) {
    showMessage("El número de tarjeta debe tener exactamente 16 dígitos.");
    return;
  }

  if (!expiryRegex.test(expiry)) {
    showMessage("La fecha de expiración debe tener el formato MM/AA.");
    return;
  }

  if (!cvvRegex.test(cvv)) {
    showMessage("El CVV debe tener exactamente 3 dígitos.");
    return;
  }

  // Si todo es válido
  alert("¡Pago con tarjeta procesado con éxito!");
  localStorage.removeItem("cart");
  window.location.href = "mercha.html";
});


document.addEventListener("DOMContentLoaded", () => {
  const cartContainer = document.getElementById("cart-products");
  const cart = JSON.parse(localStorage.getItem("cart")) || [];

  if (cart.length === 0) {
    cartContainer.innerHTML = "<p>No hay productos en el carrito.</p>";
  } else {
    cartContainer.innerHTML = ""; // limpiamos antes

    let total = 0;
    cart.forEach((product) => {
      const item = document.createElement("div");
      total += product.precio * product.cantidad;
      item.className = "cart-item";
      item.innerHTML = `
        <img src="${product.imagen}" alt="${product.nombre}">
        <div class="cart-item-details">
          <h4>${product.nombre}</h4>
          <p><strong>Talla:</strong> ${product.talla || "N/A"}</p>
          <p><strong>Cantidad:</strong> ${product.cantidad}</p>
          <p><strong>Precio unidad:</strong> ${product.precio.toFixed(2)} €</p>
          <p><strong>Subtotal:</strong> ${(
            product.precio * product.cantidad
          ).toFixed(2)} €</p>
        </div>
      `;
      cartContainer.appendChild(item);
    });

    // Mostrar total
    const totalElement = document.createElement("div");
    totalElement.className = "cart-total";
    totalElement.innerHTML = `<h4>Total:</h4><p>${total.toFixed(2)} €</p>`;
    cartContainer.appendChild(totalElement);
  }
});

window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});


  document.addEventListener("DOMContentLoaded", () => {
    const btnTarjeta = document.getElementById("btn-tarjeta");
    const btnPaypal = document.getElementById("btn-paypal");
    const formTarjeta = document.getElementById("form-tarjeta");

    btnTarjeta.addEventListener("click", () => {
      formTarjeta.style.display = "block";
    });

    btnPaypal.addEventListener("click", () => {
      // Cambia esta URL por la real si tienes integración con PayPal
      window.location.href = "https://www.paypal.com/checkoutnow";
      formTarjeta.style.display = "none";

    });

    formTarjeta.addEventListener("submit", function (e) {
      e.preventDefault();
      alert("¡Pago con tarjeta procesado con éxito!");
      localStorage.removeItem("cart");
      window.location.href = "mercha.html";
    });
  });

  function showMessage(text, type = "error", duration = 4000) {
  const container = document.getElementById("message-container");
  if (!container) return;

  const message = document.createElement("div");
  message.className = `message ${type}`;
  message.textContent = text;

  // Botón cerrar
  const closeBtn = document.createElement("button");
  closeBtn.textContent = "×";
  closeBtn.className = "close-btn";
  closeBtn.onclick = () => container.removeChild(message);
  message.appendChild(closeBtn);

  container.appendChild(message);

  // Desaparece automáticamente
  setTimeout(() => {
    if (container.contains(message)) {
      container.removeChild(message);
    }
  }, duration);
}