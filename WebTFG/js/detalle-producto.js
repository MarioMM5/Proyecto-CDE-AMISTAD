// detalle-producto.js

const productos = {
  "413844533": {
    nombre: "Camiseta Oficial",
    precio: 25.00,
    tallas: ["S", "M", "L", "XL"],
    colores: ["Blanco", "Negro", "Rojo"],
    imagen: "../img/camiseta.png",
    info: "Incluye opción de personalización con nombre y dorsal."

  },
  "413844534": {
    nombre: "Sudadera del Equipo",
    precio: 15.00,
    tallas: ["M", "L", "XL"],
    colores: ["Gris", "Negro"],
    imagen: "../img/sudadera.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844535": {
    nombre: "Abrigo del Equipo",
    precio: 25.00,
    tallas: ["L", "XL"],
    colores: ["Negro", "Azul"],
    imagen: "../img/abrigo.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844536": {
    nombre: "Chubasquero del Equipo",
    precio: 15.00,
    tallas: ["S", "M", "L"],
    colores: ["Azul", "Negro"],
    imagen: "../img/chubasquero.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844537": {
    nombre: "Mochila del Equipo",
    precio: 25.00,
    tallas: [], // Sin tallas porque es mochila
    colores: ["Negro"],
    imagen: "../img/mochila.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844538": {
    nombre: "Chandal Oficial",
    precio: 25.00,
    tallas: ["S", "M", "L", "XL"],
    colores: ["Rojo", "Negro"],
    imagen: "../img/chandal.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844539": {
    nombre: "Conjunto del Equipo",
    precio: 15.00,
    tallas: ["M", "L"],
    colores: ["Blanco", "Azul"],
    imagen: "../img/conjunto_entero.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844520": {
    nombre: "Calcetines del Equipo",
    precio: 25.00,
    tallas: [], // Sin tallas
    colores: ["Blanco", "Negro"],
    imagen: "../img/calcetines.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844521": {
    nombre: "Polo del Equipo",
    precio: 25.00,
    tallas: ["S", "M", "L", "XL"],
    colores: ["Blanco", "Azul"],
    imagen: "../img/polo.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  },
  "413844522": {
    nombre: "Pack del Equipo",
    precio: 25.00,
    tallas: [], // Sin tallas
    colores: [], // Sin colores
    imagen: "../img/pack.jpg",
    info: "Incluye opción de personalización con nombre y dorsal."
  }
};

const params = new URLSearchParams(window.location.search);
const productId = params.get('id');
const container = document.getElementById('product-detail');

if (!productId || !productos[productId]) {
  container.innerHTML = `<p class="error">Producto no encontrado.</p>`;
} else {
  const p = productos[productId];
  const esCamiseta = productId === "413844533";

  // Generamos botones de talla
  const tallasButtons = p.tallas.map(t => `
    <button type="button" class="option-button size-option" data-value="${t}">${t}</button>
  `).join('');

  // Generamos botones de color (se ignorará en la camiseta)
  const coloresButtons = p.colores.map(c => `
    <button type="button" class="option-button color-option" data-value="${c.toLowerCase()}">${c}</button>
  `).join('');

  container.innerHTML = `
    <div class="product-detail-container">
<div class="product-image">
  <img src="${p.imagen}" alt="${p.nombre}" />
<div class="product-note" style="
  background-color: #f9f9f9;
  border: 1px solid #ddd;
  padding: 1rem;
  margin-top: 1rem;
  border-radius: 8px;
  font-size: 0.95rem;
  color: #333;
  text-align: center;
">
  <h3 style="
    margin-top: 0;
    margin-bottom: 0.5rem;
    font-size: 1.1rem;
    color: #222;
  ">ℹ️ Información del producto</h3>
  <p style="margin: 0;">${p.info || ''}</p>
</div>
</div>
      <div class="product-info">
        <h1>${p.nombre}</h1>
        <p class="price">€${p.precio.toFixed(2)}</p>

        <form id="product-options-form">
          <!-- Tallas -->
          ${p.tallas.length ? `
          <label>Talla:</label>
          <div class="option-group" id="size-options">
            ${tallasButtons}
          </div>` : ''}

          <!-- Colores (solo si no es camiseta) -->
          ${!esCamiseta && p.colores.length ? `
          <label>Color:</label>
          <div class="option-group" id="color-options">
            ${coloresButtons}
          </div>` : ''}

          <!-- Cantidad -->
          <label for="quantity-input">Cantidad:</label>
          <input type="number" id="quantity-input" name="quantity" value="1" min="1" required />

          <!-- Personalización solo para camiseta -->
          ${esCamiseta ? `
          <div style="margin-top: 1rem;">
  <label for="name-input" style="display: block; font-weight: bold; margin-bottom: 0.3rem;">Nombre (opcional):</label>
  <input
    type="text"
    id="name-input"
    name="name"
    placeholder="Ej: Gutiérrez"
    style="
      width: 95%;
      padding: 0.6rem 0.8rem;
      border: 2px solid #ccc;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s, box-shadow 0.3s;
    "
    onfocus="this.style.borderColor='#007BFF'; this.style.boxShadow='0 0 0 3px rgba(0,123,255,0.2)'"
    onblur="this.style.borderColor='#ccc'; this.style.boxShadow='none'"
  />
</div>

          <label for="number-input">Dorsal (opcional):</label>
          <input type="number" id="number-input" name="dorsal" min="1" placeholder="Número" />
          ` : ''}

          <button type="submit" class="add-cart-btn">Añadir al carrito</button>
        </form>
      </div>
    </div>
  `;
}

// --- lógica de selección de opciones ---
function setupOptionGroup(groupId) {
  const group = document.getElementById(groupId);
  if (!group) return () => "";  // si no existe, devuelve siempre vacío
  const buttons = group.querySelectorAll('.option-button');
  let selectedValue = "";

  buttons.forEach(btn => {
    btn.addEventListener('click', () => {
      buttons.forEach(b => b.classList.remove('selected'));
      btn.classList.add('selected');
      selectedValue = btn.dataset.value;
    });
  });

  return () => selectedValue;
}

const getSelectedSize  = setupOptionGroup('size-options');
const getSelectedColor = setupOptionGroup('color-options');

// --- envío del formulario ---
document.getElementById('product-options-form').addEventListener('submit', e => {
  e.preventDefault();
  const p = productos[productId];

  // Recuperar valores
  const talla    = getSelectedSize();
  const color    = p.colores.length ? getSelectedColor() : "";
  const cantidad = parseInt(document.getElementById('quantity-input').value, 10);

  // Validaciones
  if (p.tallas.length && !talla) {
    alert('Por favor, selecciona una talla.');
    return;
  }
  if (p.colores.length && color === "") {
    alert('Por favor, selecciona un color.');
    return;
  }

  // Datos adicionales para la camiseta
  let nombreUsuario = "";
  let dorsalUsuario = "";
  if (productId === "413844533") {
    nombreUsuario = document.getElementById('name-input').value.trim();
    dorsalUsuario = document.getElementById('number-input').value.trim();
  }

  // Aquí enviarías al carrito (por ahora un alert)
  alert(
    `Añadido al carrito:\n` +
    `Producto: ${p.nombre}\n` +
    `Talla: ${talla || '—'}\n` +
    `${p.colores.length ? `Color: ${color}\n` : ''}` +
    `Cantidad: ${cantidad}\n` +
    `${nombreUsuario ? `Nombre: ${nombreUsuario}\n` : ''}` +
    `${dorsalUsuario ? `Dorsal: ${dorsalUsuario}\n` : ''}`
  );

  // TODO: guardar en localStorage o enviar a backend
});