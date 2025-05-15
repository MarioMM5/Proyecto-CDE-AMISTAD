// detalle-producto.js

const productos = {
  413844533: {
    nombre: "Camiseta Oficial",
    precio: 25.0,
    tallas: ["S", "M", "L", "XL"],
    colores: ["Blanco", "Negro", "Rojo"],
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
    precio: 15.0,
    tallas: ["M", "L", "XL"],
    colores: ["Gris", "Negro"],
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
    precio: 25.0,
    tallas: ["L", "XL"],
    colores: ["Negro", "Azul"],
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
    precio: 15.0,
    tallas: ["S", "M", "L"],
    colores: ["Azul", "Negro"],
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
    precio: 25.0,
    tallas: [], // Sin tallas porque es mochila
    colores: ["Negro"],
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
    precio: 25.0,
    tallas: ["S", "M", "L", "XL"],
    colores: ["Rojo", "Negro"],
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
    precio: 15.0,
    tallas: ["M", "L"],
    colores: ["Blanco", "Azul"],
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
    precio: 25.0,
    tallas: [], // Sin tallas
    colores: ["Blanco", "Negro"],
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
    tallas: ["S", "M", "L", "XL"],
    colores: ["Blanco", "Azul"],
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
    precio: 25.0,
    tallas: [], // Sin tallas
    colores: [], // Sin colores
    imagen: "../img/pack.jpg",
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

  // Generamos botones de talla
  const tallasButtons = p.tallas
    .map(
      (t) => `
    <button type="button" class="option-button size-option" data-value="${t}">${t}</button>
  `
    )
    .join("");

  // Generamos botones de color (se ignorará en la camiseta)
  const coloresButtons = p.colores
    .map(
      (c) => `
    <button type="button" class="option-button color-option" data-value="${c.toLowerCase()}">${c}</button>
  `
    )
    .join("");

container.innerHTML = `
  <div class="product-detail-container" style="display: flex; gap: 40px; max-width: 1000px; margin: 0 auto; font-family: Arial, sans-serif;">
    
    <!-- Lado izquierdo: imagen + info -->
    <div style="flex: 1; display: flex; flex-direction: column; align-items: center;">
      <img src="${p.imagen}" alt="${p.nombre}" style="max-width: 100%; max-height: 400px; object-fit: contain; border-radius: 10px;" />
      <div class="product-note" style="
        margin-top: 15px;
        background-color: #f9f9f9;
        border: 1px solid #ddd;
        padding: 1rem;
        border-radius: 8px;
        font-size: 0.95rem;
        color: #333;
        text-align: center;
        width: 100%;
        max-width: 320px;
      ">
        <h3 style="
          margin-top: 0;
          margin-bottom: 0.5rem;
          font-size: 1.1rem;
          color: #222;
        ">ℹ️ Información del producto</h3>
        <p style="margin: 0;">${p.info || ""}</p>
      </div>
    </div>
    
    <!-- Lado derecho: formulario -->
    <form id="product-options-form" style="flex: 1; display: flex; flex-direction: column; gap: 15px;">
      
      ${
        p.tallas.length
          ? `
          <label style="font-weight: bold;">Talla:</label>
          <div class="option-group" id="size-options" style="display: flex; gap: 10px;">
            ${tallasButtons}
          </div>`
          : ""
      }
      

      
              ${esCamiseta ? `
          <div style="margin-top: 1rem;">
  <label for="name-input" style="display: block; font-weight: bold; margin-bottom: 0.3rem;">Nombre (opcional):</label>
  <input
    type="text"
    id="name-input"
    name="name"
    placeholder="Ej: Gutiérrez"
    style="
      width: 100%;
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
                <label for="quantity-input" style="font-weight: bold;">Cantidad:</label>
      <input type="number" id="quantity-input" name="quantity" value="1" min="1" required style="width: 80px; padding: 6px; font-size: 1rem;" />
     
      <button type="submit" class="add-cart-btn" style="
        background-color: #2c7be5;
        color: white;
        border: none;
        padding: 12px 0;
        font-size: 1.1rem;
        cursor: pointer;
        border-radius: 6px;
        transition: background-color 0.3s ease;
        margin-top: 10px;
      ">Añadir al carrito</button>
      
      <!-- Productos relacionados justo debajo del botón -->
      <div class="recommended-section" style="margin-top: 30px;">
        <h3 style="font-size: 1.3rem; color: #222; margin-bottom: 15px;">Productos Relacionados</h3>
        <div class="recommended-list" style="display: flex; gap: 15px; flex-wrap: wrap;">
          ${obtenerRecomendados(productId, productos)}
        </div>
      </div>
    </form>
    
  </div>
`;


  // Y añade CSS para que quede presentable:
  const style = document.createElement("style");
  style.textContent = `
  .recommended-section {
    margin-top: 30px;
  }
  .recommended-section h3 {
    font-size: 1.4em;
    font-weight: 700;
    margin-bottom: 15px;
    border-bottom: 3px solid #2a9d8f;
    padding-bottom: 6px;
    color: #264653;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
  .recommended-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
    gap: 20px;
  }
  .recommended-card {
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    overflow: hidden;
    cursor: pointer;
  }
  .recommended-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.15);
  }
  .recommended-card a {
    color: inherit;
    text-decoration: none;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 12px;
  }
  .img-wrapper {
    width: 100%;
    overflow: hidden;
    border-radius: 12px;
  }
  .img-wrapper img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    transition: transform 0.4s ease;
  }
  .recommended-card:hover img {
    transform: scale(1.1);
  }
  .recommended-title {
    margin-top: 10px;
    font-weight: 600;
    font-size: 1em;
    text-align: center;
    color: #2a9d8f;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  }
`;
  document.head.appendChild(style);
}

// --- lógica de selección de opciones ---
function setupOptionGroup(groupId) {
  const group = document.getElementById(groupId);
  if (!group) return () => ""; // si no existe, devuelve siempre vacío
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

const getSelectedSize = setupOptionGroup("size-options");
const getSelectedColor = setupOptionGroup("color-options");

// --- envío del formulario ---
document
  .getElementById("product-options-form")
  .addEventListener("submit", (e) => {
    e.preventDefault();
    const p = productos[productId];

    // Recuperar valores
    const talla = getSelectedSize();
    const color = p.colores.length ? getSelectedColor() : "";
    const cantidad = parseInt(
      document.getElementById("quantity-input").value,
      10
    );

    // Validaciones
    if (p.tallas.length && !talla) {
      alert("Por favor, selecciona una talla.");
      return;
    }
    if (p.colores.length && color === "") {
      alert("Por favor, selecciona un color.");
      return;
    }

    // Datos adicionales para la camiseta
    let nombreUsuario = "";
    let dorsalUsuario = "";
    if (productId === "413844533") {
      nombreUsuario = document.getElementById("name-input").value.trim();
      dorsalUsuario = document.getElementById("number-input").value.trim();
    }

    // Aquí enviarías al carrito (por ahora un alert)
    alert(
      `Añadido al carrito:\n` +
        `Producto: ${p.nombre}\n` +
        `Talla: ${talla || "—"}\n` +
        `${p.colores.length ? `Color: ${color}\n` : ""}` +
        `Cantidad: ${cantidad}\n` +
        `${nombreUsuario ? `Nombre: ${nombreUsuario}\n` : ""}` +
        `${dorsalUsuario ? `Dorsal: ${dorsalUsuario}\n` : ""}`
    );

    // TODO: guardar en localStorage o enviar a backend
  });
