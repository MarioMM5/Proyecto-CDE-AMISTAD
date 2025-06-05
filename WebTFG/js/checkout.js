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

      let subtotal = product.precio * product.cantidad;

      if (
        product.nombre === "Pack del Equipo" &&
        product.ropaJuego === "SI (+35.00€)"
      ) {
        subtotal += 35;
      }

      total += subtotal;

      item.className = "cart-item";

      if (product.nombre === "Pack del Equipo") {
        item.innerHTML = `
      <img src="${product.imagen[0]}" alt="${product.nombre}">
      <div class="cart-item-details">
        <h4>${product.nombre}</h4>
        <p><strong>Cantidad:</strong> ${product.cantidad}</p>
        <p><strong>Conjunto:</strong> ${product.conjunto}</p>
        <p><strong>Sudadera:</strong> ${product.sudadera}</p>
        <p><strong>Medias:</strong> ${product.medias}</p>
        <p><strong>Chándal:</strong> ${product.chandal}</p>
        <p><strong>Abrigo:</strong> ${product.abrigo}</p>
        <p><strong>Chubasquero:</strong> ${product.chubasquero}</p>
        <p><strong>Ropa de juego:</strong> ${product.ropaJuego}</p>
        <p><strong>Subtotal:</strong> ${subtotal.toFixed(2)} €</p>
      </div>
    `;
      } else if (product.nombre === "Conjunto del Equipo") {
        item.innerHTML = `
        <img src="${product.imagen[0]}" alt="${product.nombre}">
        <div class="cart-item-details">
          <h4>${product.nombre}</h4>
          <p><strong>Cantidad:</strong> ${product.cantidad}</p>
          <p><strong>Talla:</strong> ${product.talla}</p>
          <p><strong>Medias:</strong> ${product.medias}</p>
        </div>
      `;
      } else {
        item.innerHTML = `
      <img src="${product.imagen[0]}" alt="${product.nombre}">
      <div class="cart-item-details">
        <h4>${product.nombre}</h4>
        <p><strong>Talla:</strong> ${product.talla || "N/A"}</p>
        <p><strong>Cantidad:</strong> ${product.cantidad}</p>
        <p><strong>Precio unidad:</strong> ${product.precio.toFixed(2)} €</p>
        <p><strong>Subtotal:</strong> ${subtotal.toFixed(2)} €</p>
      </div>
    `;
      }

      cartContainer.appendChild(item);
    });

    // Mostrar total
    const totalElement = document.createElement("div");
    totalElement.className = "cart-total";
    totalElement.innerHTML = `<h4>Total:</h4><p>${total.toFixed(2)} €</p>`;
    const totalContainer = document.getElementById("cart-total-container");
    totalContainer.innerHTML = ""; 
    totalContainer.appendChild(totalElement);
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

  const closeBtn = document.createElement("button");
  closeBtn.textContent = "×";
  closeBtn.className = "close-btn";
  closeBtn.onclick = () => container.removeChild(message);
  message.appendChild(closeBtn);

  container.appendChild(message);

  setTimeout(() => {
    if (container.contains(message)) {
      container.removeChild(message);
    }
  }, duration);
}
