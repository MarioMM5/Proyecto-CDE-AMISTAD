window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
const sidebar = document.getElementById("sidebar");
const toggleBtn = document.getElementById("toggleBtn");
const arrow = toggleBtn.querySelector(".arrow");
const icon = toggleBtn.querySelector("i");

toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
  icon.classList.toggle("fa-arrow-right");
  icon.classList.toggle("fa-xmark");
  arrow.innerHTML = sidebar.classList.contains("collapsed")
    ? "&#x25C0;"
    : "&#x25B6;";
});
document.querySelectorAll(".buy-btn").forEach((btn) => {
  btn.addEventListener("click", () => {
    window.location.href = "detalle-producto.html?id=413844533";
  });
});

document.addEventListener("DOMContentLoaded", () => {
  const cartItemsUl = document.getElementById("cart-items");
  const checkoutBtn = document.getElementById("checkout-btn");

  const cart = JSON.parse(localStorage.getItem("cart")) || [];

  if (cart.length === 0) {
    cartItemsUl.innerHTML = "<li>El carrito está vacío.</li>";
  } else {
    cartItemsUl.innerHTML = "";

    cart.forEach((item) => {
      const li = document.createElement("li");
      if (item.nombre === "Pack del Equipo") {
        li.innerHTML = `
          <div style="width: 150px; height: 150px; background-color: white; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
              <img src="${item.imagen[0]}" alt="${item.nombre}" style="max-height: 100%; max-width: 100%; object-fit: contain;">
            </div>
            <br>
            <strong>${item.nombre}</strong><br>
            Conjunto: ${item.conjunto}<br>
            Sudadera: ${item.sudadera}<br>
            Medias: ${item.medias}<br>
            Chandal: ${item.chandal}<br>
            Abrigo: ${item.abrigo}<br>
            Chubasquero: ${item.chubasquero}<br>
            Ropa de juego: ${item.ropaJuego}<br>
            Cantidad: ${item.cantidad} <br>
          `;
      } else if (item.nombre === "Conjunto del Equipo") {
        li.innerHTML = `
          <div style="width: 150px; height: 150px; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
              <img src="${item.imagen[0]}" alt="${
          item.nombre
        }" style="max-height: 100%; max-width: 100%; object-fit: contain;">
            </div>
            <br>
          <strong>${item.nombre}</strong> - Talla: ${
          item.talla || "—"
        } - Medias: ${item.medias || "—"} - Cantidad: ${item.cantidad}`;
      } else {
        li.innerHTML = `
          <div style="width: 150px; height: 150px; display: flex; align-items: center; justify-content: center; margin: 0 auto;">
              <img src="${item.imagen[0]}" alt="${
          item.nombre
        }" style="max-height: 100%; max-width: 100%; object-fit: contain;">
            </div>
            <br>
          <strong>${item.nombre}</strong> - Talla: ${
          item.talla || "—"
        } - Cantidad: ${item.cantidad}`;
      }
      cartItemsUl.appendChild(li);
    });
  }

  checkoutBtn.addEventListener("click", () => {
    const cart = JSON.parse(localStorage.getItem("cart")) || [];
    if (cart.length === 0) {
      alert("El carrito está vacío.");
      return;
    }
    window.location.href = "checkout.html";
  });
});

document.addEventListener("DOMContentLoaded", () => {
  const clearCartBtn = document.getElementById("clear-cart-btn");
  const cart = JSON.parse(localStorage.getItem("cart")) || [];
  if (cart.length === 0) {
    clearCartBtn.style.display = "none";
  } else {
    clearCartBtn.style.display = "block";
  }
  if (clearCartBtn) {
    clearCartBtn.addEventListener("click", () => {
      const confirmClear = confirm(
        "¿Estás seguro de que quieres vaciar el carrito?"
      );
      if (confirmClear) {
        localStorage.removeItem("cart");
        alert("Carrito vaciado.");
        location.reload();
      }
    });
  }
});
