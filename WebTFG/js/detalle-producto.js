// detalle-producto.js

const productos = {
  413844533: {
    nombre: "Camiseta Oficial",
    precio: 25.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/camiseta.png",
    info: `
    <strong>Camisetas con diseño exclusivo para el CDE Amistad</strong><br><br>

    Verdes con bordeados blancos.<br><br>

    <strong>Personalización individual:</strong> talla, nombre, dorsal.<br><br>

    Hechas con poliéster muy cómodas y resistibles para poder jugar a buen rendimiento.<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda alrededor de 3 semanas desde que se realiza el pedido.
  `,
  },
  413844534: {
    nombre: "Sudadera del Equipo",
    precio: 25.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/sudadera.jpg",
    info: `
    <strong>Marca:</strong> Gañafote<br><br>
    Sudadera diseñada en exclusiva para el <strong>C.D.E. Amistad</strong> en color verde con detalles en blanco.<br><br>
    
    Fabricada en un <strong>tejido ligero</strong> para garantizar la comodidad del futbolista durante la práctica deportiva.<br><br>
    
    La impresión se ha realizado mediante la técnica de <strong>sublimación</strong>, que permite que el estampado quede totalmente integrado en el tejido. No se nota al tacto, ni se rompe ni pierde color con el tiempo.<br><br>
    
    Las prendas son fabricadas bajo pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Consulta el siguiente documento para elegir correctamente la talla:
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda aproximadamente <strong>3 semanas</strong> desde que se realiza el pedido.
  `,
  },
  413844535: {
    nombre: "Abrigo del Equipo",
    precio: 36.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/abrigo.jpg",
    info: `
    <strong>Abrigo color negro fabricado en Poliéster</strong>.<br><br>
    <strong>Especificaciones:</strong><br>
    • Muy ligero y compacto<br>
    • Gran comodidad térmica<br>
    • Cremallera en bolsillos<br>
    • Capucha<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda alrededor de 3 semanas desde que se realiza el pedido.
  `,
  },
  413844536: {
    nombre: "Chubasquero del Equipo",
    precio: 18.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/chubasquero.jpg",
    info: `
    <strong>Marca:</strong> Gañafote<br><br>
    
    Chubasquero en color negro fabricado en <strong>Poliéster</strong>, con las siguientes especificaciones:<br><br>

    - Cremallera principal <strong>reflectante</strong><br>
    - Bolsillos con cremallera <strong>reflectante</strong><br>
    - Capucha con tela <strong>transpirable</strong><br>
    - Bolsillo posterior para <strong>guardar el chubasquero</strong><br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla:<br>
    
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda aproximadamente <strong>3 semanas</strong> desde que se realiza el pedido.
  `,
  },
  413844537: {
    nombre: "Mochila del Equipo",
    precio: 18.0,
    tallas: [], // Sin tallas porque es mochila
    imagen: "../img/mochila.jpg",
    info: `
    Mochila de color <strong>negro</strong> fabricada en <strong>poliéster</strong>, diseñada para resistir las batallas del día a día con estilo y funcionalidad:<br><br>

    - Bolsillo principal de <strong>gran capacidad</strong><br>
    - Bolsillo exterior con <strong>red interior</strong> para pequeños objetos<br>
    - Bolsillo <strong>zapatero acolchado</strong> en la parte inferior<br>
    - <strong>Acolchado en la espalda</strong> y <strong>asas anchas</strong> para mayor comodidad en todo momento
  `,
  },
  413844538: {
    nombre: "Chandal Oficial",
    precio: 45.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/chandal.jpg",
    info: `
    <strong>El chándal del C.D.E. Amistad</strong> se compone de chaqueta y pantalón.<br><br>

    La chaqueta ha sido diseñada en exclusiva para el C.D.E. Amistad en color verde con detalles en blanco. Chaqueta abierta con cremallera, gorro y bolsillos con cremallera. Cuenta con un ribs en los puños de color negro para un ajuste óptimo.<br>
    <strong>Composición:</strong> 100% poliéster.<br><br>

    El pantalón es 100% poliéster en color negro con el escudo del club bordado en blanco.<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda alrededor de 3 semanas desde que se realiza el pedido.
  `,
  },
  413844539: {
    nombre: "Conjunto del Equipo",
    precio: 30.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    medias: ["NO", "25-28", "29-32", "33-36", "27-40", "41-44"],
    imagen: "../img/conjunto_entero.jpg",
    info: `
    <strong>Marca:</strong> Gañafote<br><br>
    El Conjunto de entrenamiento del C.D.E. Amistad está compuesto por camiseta, pantalón y medias (opcional).<br><br>

    La camiseta y el pantalón han sido diseñados en exclusiva para el C.D.E. Amistad a través de la técnica de sublimación. 
    La principal ventaja de esta técnica para el diseño de camisetas deportivas es que el estampado está completamente 
    impregnado en la camiseta hasta que forma parte de la tela misma. No se nota al tacto, ni puedes percibir ninguna aspereza, 
    no se rompe ni pierde matiz con el tiempo.<br><br>

    Fabricado en un tejido ligero, transpirable y resistente ideal para la práctica deportiva.<br><br>

    <strong>Color camiseta y pantalón:</strong> Verde con detalles en blanco<br>
    <strong>Color medias:</strong> Blanco<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank" style="color: #007bff; text-decoration: underline;">ver guía de tallas</a>.<br><br>

    El artículo tarda alrededor de 3 semanas desde que se realiza el pedido.
  `,
  },
  413844520: {
    nombre: "Medias del Equipo",
    precio: 6.50,
    tallas: ["25-28", "29-32", "33-36", "27-40", "41-44"],
    imagen: "../img/calcetines.jpg",
    info: `
    <strong>Medias personalizadas C.D.E. Amistad</strong><br><br>

    <strong>Medias blancas:</strong> Entrenamiento<br>
    <strong>Medias negras:</strong> Partido<br><br>

    Diseño personalizado con el escudo y nombre del Club en verde.<br><br>

    Con forma cómoda para un mejor ajuste en la parte superior y en el tobillo.
  `,
  },
  413844521: {
    nombre: "Polo del Equipo",
    precio: 25.0,
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/polo.jpg",
    info: `
    <strong>Marca:</strong> Gañafote<br><br>
    Polo diseñado en <strong>exclusiva</strong> para el <strong>C.D.E. Amistad</strong>.<br><br>

    - Color <strong>verde</strong> con detalles en <strong>blanco y negro</strong><br>
    - Fabricado con <strong>técnica de sublimación</strong>: el estampado está completamente integrado en la tela. No se nota al tacto, no se rompe ni pierde intensidad con el tiempo.<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor, tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank">Guía de tallas</a>.<br><br>
    
    El artículo tarda alrededor de <strong>3 semanas</strong> desde que se realiza el pedido.
  `,
  },
  413844522: {
    nombre: "Pack del Equipo",
    precio: 200.0,
    medias: ["25-28", "29-32", "33-36", "27-40", "41-44"],
    tallas: ["4", "6", "8", "10", "12", "14", "XS", "S", "M", "L", "XL", "XXL"],
    imagen: "../img/pack.jpg",
    opciones: ["SI (+35.00€)", "NO"],
    info: `
    <strong>Marca:</strong> Gañafote<br><br>
    Con el pack de ropa de entrenamiento del <strong>C.D.E. Amistad</strong> tendrás todas las prendas necesarias para desarrollar la actividad a un precio más económico.<br><br>

    Las prendas son fabricadas según se realiza el pedido, por lo que <strong>NO se aceptan cambios de talla</strong>. Por favor tenga en cuenta el siguiente documento para elegir correctamente la talla: 
    <a href="https://cdeamistad.com/wp-content/uploads/2022/09/Medidas-Ropa-cdeamistad-2022.pdf" target="_blank">Guía de tallas</a>.<br><br>

    El artículo tarda alrededor de <strong>3 semanas</strong> desde que se realiza el pedido.<br><br>

    <strong>El pack contiene:</strong><br>
    - Conjunto de entrenamiento (Camiseta, pantalón y medias)<br>
    - Sudadera<br>
    - Chandal (Chaqueta y pantalón)<br>
    - Chubasquero<br>
    - Abrigo<br>
    - Mochila<br><br>

    <em>*Los alumnos nuevos en la temporada 2024/2025 deberán marcar la casilla "Ropa de Juego": camiseta, pantalón y medias.</em>
  `,
  },
};

const params = new URLSearchParams(window.location.search);
const productId = params.get("id");
const container = document.getElementById("product-detail");
function obtenerRecomendados(idActual, productos, cantidad = 3) {
  const otrosProductos = Object.entries(productos)
    .filter(([id]) => id !== idActual)
    .slice(0, cantidad);

  return otrosProductos
    .map(
      ([id, prod]) => `
    <div class="recommended-card">
      <a href="detalle-producto.html?id=${id}" title="${prod.nombre}">
        <div class="img-wrapper">
          <img src="${prod.imagen}" alt="${prod.nombre}" />
        </div>
        <p class="recommended-title">${prod.nombre}</p>
      </a>
    </div>
  `
    )
    .join("");
}
if (!productId || !productos[productId]) {
  container.innerHTML = `<p class="error">Producto no encontrado.</p>`;
} else {
  const p = productos[productId];
  const esCamiseta = productId === "413844533";
  const esConjunto = productId === "413844539";
  const esPack = productId === "413844522";

  // Generamos botones de talla
  const tallasButtons = p.tallas
    .map(
      (t) => `
    <button type="button" class="option-button size-option" data-value="${t}">${t}</button>
  `
    )
    .join("");

  let optionsButtons = "";
  if (productId === "413844522") {
    optionsButtons = p.opciones
      .map(
        (t) => `
    <button type="button" class="option-button size-option" data-value="${t}">${t}</button>
  `
      )
      .join("");
  }

  let mediasButtons = "";
  if (productId === "413844539" || productId === "413844522") {
    mediasButtons = p.medias
      .map(
        (t) => `
    <button type="button" class="option-button size-option" data-value="${t}">${t}</button>
  `
      )
      .join("");
  }
  function render(label, buttons, id = "siu") {
    return buttons.length
      ? `
        <label style="font-weight: bold;">${label}:</label>
        <div class="option-group" id=${id} style="display: flex; gap: 10px;">
          ${buttons}
        </div>
      `
      : "";
  }

  container.innerHTML = `
<a href="javascript:history.back()" class="back-link">
  <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" width="24" height="24">
    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
  </svg>
  Volver atrás
</a>

<div class="product-detail-container">
  <div style="flex:1;display:flex;flex-direction:column;align-items:center;">
    <img src="${p.imagen}" alt="${p.nombre}" class="product-image" />
    <div class="product-info-box">
      <h3 style="margin:0 0 0.5rem;font-size:1.1rem;color:#222;">ℹ️ Información del producto</h3>
      <p style="margin:0;">${p.info || ""}</p>
    </div>
  </div>

  <form id="product-options-form">
    <div class="product-title-box">
      <h2>${p.nombre}</h2>
      <p>${p.precio || ""}€</p>
    </div>

    ${!esPack ? render("Talla", tallasButtons, "size-options") : ""}
    ${
      esCamiseta
        ? `
      <div>
        <label for="name-input" style="display:block;font-weight:bold;margin-bottom:0.3rem;">Nombre (opcional):</label>
        <input type="text" id="name-input" name="name" placeholder="Ej: Gutiérrez" />
      </div>
      <label for="number-input">Dorsal (opcional):</label>
      <input type="number" id="number-input" name="dorsal" min="1" placeholder="Número" />
    `
        : ""
    }

    ${esConjunto ? render("Medias", mediasButtons, "medias") : ""}

    ${
      esPack
        ? `
      ${render("Conjunto de equipo", tallasButtons, "conjunto")}
      ${render("Sudadera", tallasButtons, "sudadera")}
      ${render("Chandal", tallasButtons, "chandal")}
      ${render("Abrigo", tallasButtons, "abrigo")}
      ${render("Chubasquero", tallasButtons, "chubasquero")}
      ${render("Medias", mediasButtons, "medias")}
      ${render(
        "Ropa de juego (Obligatoria nuevos alumnos)",
        optionsButtons,
        "ropa-juego"
      )}
    `
        : ""
    }

    <label for="quantity-input" style="font-weight:bold;">Cantidad:</label>
    <input type="number" id="quantity-input" name="quantity" value="1" min="1" required />

    <button type="submit" class="add-cart-btn">Añadir al carrito</button>
<div id="message-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999;"></div>

    <div class="recommended-section">
      <h3>Productos Relacionados</h3>
      <div class="recommended-list">
        ${obtenerRecomendados(productId, productos)}
      </div>
    </div>
  </form>
</div>`;

}

// --- lógica de selección de opciones ---
function setupOptionGroup(groupId) {
  const group = document.getElementById(groupId);
  if (!group) return () => "";
  const buttons = group.querySelectorAll(".option-button");
  let selectedValue = "";

  buttons.forEach((btn) => {
    btn.addEventListener("click", () => {
      buttons.forEach((b) => b.classList.remove("selected"));
      btn.classList.add("selected");
      selectedValue = btn.dataset.value;
    });
  });

  return () => selectedValue;
}

const getSelectedConf = setupOptionGroup("conjunto");
const getSelectedSudadera = setupOptionGroup("sudadera");
const getSelectedChandal = setupOptionGroup("chandal");
const getSelectedAbrigo = setupOptionGroup("abrigo");
const getSelectedChubasquero = setupOptionGroup("chubasquero");
const getSelectedMedias = setupOptionGroup("medias");
const getSelectedRopa_Juego = setupOptionGroup("ropa-juego");
const selectedMedias = setupOptionGroup("medias-options");
const getSelectedSize = setupOptionGroup("size-options");

// Función para obtener carrito desde localStorage
function getCart() {
  const cartJSON = localStorage.getItem("cart");
  return cartJSON ? JSON.parse(cartJSON) : [];
}

// Función para guardar carrito en localStorage
function saveCart(cart) {
  localStorage.setItem("cart", JSON.stringify(cart));
}

// --- envío del formulario ---
document
  .getElementById("product-options-form")
  .addEventListener("submit", (e) => {
    e.preventDefault();
    const p = productos[productId];

    // Recuperar valores
    const talla = getSelectedSize();
    const cantidad = parseInt(
      document.getElementById("quantity-input").value,
      10
    );

    // Validaciones
    const requiredSelections = [
      { label: "el conjunto", getter: getSelectedConf },
      { label: "la sudadera", getter: getSelectedSudadera },
      { label: "el chándal", getter: getSelectedChandal },
      { label: "el abrigo", getter: getSelectedAbrigo },
      { label: "el chubasquero", getter: getSelectedChubasquero },
    ];

    if (productId === "413844522") {
      for (const { label, getter } of requiredSelections) {
        if (!getter()) {
          showMessage(`Por favor, selecciona todos los campos.`);
        }
        return;

      }
    }

    if (p.tallas.length && !talla && productId !== "413844522") {
      showMessage("Por favor, selecciona una talla.");
      return;
    }

    // Datos adicionales para la camiseta
    let nombreUsuario = "";
    let dorsalUsuario = "";
    if (productId === "413844533") {
      nombreUsuario = document.getElementById("name-input").value.trim();
      dorsalUsuario = document.getElementById("number-input").value.trim();
      if (!nombreUsuario || !dorsalUsuario) {
        showMessage("Por favor, introduce un nombre y dorsal.");
        return;
      }
    }

    // Datos adicionales para el conjunto
    if (productId === "413844539") {
      if (!getSelectedMedias()) {
        showMessage("Por favor, selecciona una talla de medias.");
        return;
      }
    }

    // Construir objeto del producto para añadir al carrito
    const item = {
      id: productId,
      nombre: p.nombre,
      talla: talla || null,
      cantidad,
      nombreUsuario: nombreUsuario || null,
      dorsalUsuario: dorsalUsuario || null,
      medias: getSelectedMedias() || null,
      sudadera: getSelectedSudadera() || null,
      chandal: getSelectedChandal() || null,
      abrigo: getSelectedAbrigo() || null,
      chubasquero: getSelectedChubasquero() || null,
      ropaJuego: getSelectedRopa_Juego() || null,
      precio: p.precio || 0,
      imagen: p.imagen || "",
    };

    let itemExists = false;
    const cart = getCart();
    cart.forEach((product) => {
      if (product.id === item.id && product.talla === item.talla) {
        product.cantidad += cantidad;
        itemExists = true;
        return;
      }
    });
    if (!itemExists) {
      cart.push(item);
    }
    saveCart(cart);



    // Redirigir al catálogo (cambia 'catalogo.html' por la ruta correcta)
    window.location.href = "mercha.html";
  });
  
window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
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
