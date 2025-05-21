// Variables globales para el paginado y filtrado
const cardsPerPage = 9;
let currentPage = 1;
let filteredCards = []; // Noticias filtradas visibles según búsqueda

// Inicialización del sidebar y toggle
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

// Contadores animados épicos
document.addEventListener("DOMContentLoaded", () => {
  const counters = [
    { id: "matches", target: 128 },
    { id: "fans", target: 2478 },
    { id: "goals", target: 312 },
  ];

  counters.forEach(({ id, target }) => {
    let count = 0;
    const step = Math.ceil(target / 60);
    const el = document.getElementById(id);
    const interval = setInterval(() => {
      count += step;
      if (count >= target) {
        count = target;
        clearInterval(interval);
      }
      el.textContent = count;
    }, 40);
  });

  // Frase épica aleatoria
  const quotes = [
    "¡No luchamos por el marcador, luchamos por la gloria!",
    "El verde no es solo un color, es nuestra sangre.",
    "Donde pisa CDE Amistad, florece la victoria.",
  ];
  document.getElementById("epicQuote").textContent =
    quotes[Math.floor(Math.random() * quotes.length)];

  // Obtener noticias desde Supabase y mostrar última página al cargar
  obtenerDatos();
});

// Cambiar clase en header al hacer scroll
window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});

// Configuración de Supabase
const SUPABASE_URL = 'https://sbbddlhuflacpqnrvpyb.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU';
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Función para formatear fechas en formato español
function formatearFecha(fechaISO) {
  const fecha = new Date(fechaISO);
  return fecha.toLocaleDateString('es-ES', {
    day: 'numeric',
    month: 'long',
    year: 'numeric',
  });
}

// Función principal para obtener noticias de Supabase y crear tarjetas
async function obtenerDatos() {
  const { data, error } = await supabaseClient
    .from('noticias')
    .select('*');

  if (error) {
    console.error('Error al obtener noticias:', error);
    return;
  }

  // Ordenar las noticias por fecha, más recientes primero
  data.sort((a, b) => new Date(b.fecha) - new Date(a.fecha));

  const contenedor = document.getElementById('newsGrid');
  contenedor.innerHTML = ''; // Limpiar contenido previo

  if (!data || data.length === 0) {
    contenedor.innerHTML = '<p>No hay noticias disponibles.</p>';
    return;
  }

  
  data.forEach(noticia => {
    const card = document.createElement('article');
    card.className = 'news-card';

    card.innerHTML = `
    <img src="${noticia.imagen || '../img/placeholder.jpg'}" alt="${noticia.titulo}">
    <div class="card-content">
      <h2><a href="detalle-noticias.html?id=${noticia.id}">${noticia.titulo}</a></h2>
      <p class="description">${noticia.contenido}</p>
      <span class="date">${formatearFecha(noticia.fecha)}</span>
    </div>
    `;
  

    contenedor.appendChild(card);
  });

  // Actualiza filteredCards con el orden correcto para paginación
  filteredCards = Array.from(document.querySelectorAll(".news-card"));

  // Mostrar la primera página (las noticias más recientes)
  showPage(1);
}


// Mostrar página concreta con paginado
function showPage(page) {
  const totalPages = Math.ceil(filteredCards.length / cardsPerPage);
  currentPage = Math.max(1, Math.min(page, totalPages));

  // Ocultar todas las tarjetas
  document.querySelectorAll(".news-card").forEach((card) => {
    card.style.display = "none";
  });

  // Mostrar sólo las tarjetas de la página actual
  const startIndex = (currentPage - 1) * cardsPerPage;
  const endIndex = startIndex + cardsPerPage;
  filteredCards.slice(startIndex, endIndex).forEach((card) => {
    card.style.display = "block";
  });

  // Actualizar botones y mensajes
  const prevBtn = document.getElementById("prevPage");
  const nextBtn = document.getElementById("nextPage");
  const noResultsMessage = document.getElementById("noResultsMessage");

  prevBtn.disabled = currentPage === 1;
  nextBtn.disabled = currentPage === totalPages || totalPages === 0;

  if (filteredCards.length === 0) {
    prevBtn.style.display = "none";
    nextBtn.style.display = "none";
    noResultsMessage.style.display = "block";
  } else {
    prevBtn.style.display = "inline-block";
    nextBtn.style.display = "inline-block";
    noResultsMessage.style.display = "none";
  }
}

// Filtrar noticias por búsqueda y mostrar página 1 (o la que tú quieras)
function filterCards() {
  const search = document.getElementById("newsSearch").value.toLowerCase();
  const allCards = Array.from(document.querySelectorAll(".news-card"));

  filteredCards = allCards.filter((card) => {
    const title = card.querySelector("h2").textContent.toLowerCase();
    return title.includes(search);
  });

  currentPage = 1;
  showPage(currentPage);
}

// Listeners para filtrado y paginado
document.getElementById("newsSearch").addEventListener("input", filterCards);
document.getElementById("prevPage").addEventListener("click", () => showPage(currentPage - 1));
document.getElementById("nextPage").addEventListener("click", () => showPage(currentPage + 1));
