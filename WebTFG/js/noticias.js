const sidebar = document.getElementById("sidebar");
const toggleBtn = document.getElementById("toggleBtn");
const arrow = toggleBtn.querySelector(".arrow");
const icon = toggleBtn.querySelector("i");

// Funcionalidad para el menú lateral
toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
  icon.classList.toggle("fa-arrow-right");
  icon.classList.toggle("fa-xmark");

  arrow.innerHTML = sidebar.classList.contains("collapsed")
    ? "&#x25C0;"
    : "&#x25B6;";
});

const cardsPerPage = 9;
let currentPage = 1;
let filteredCards = []; // Noticias filtradas

function showPage(page) {
  const totalPages = Math.ceil(filteredCards.length / cardsPerPage);
  currentPage = Math.max(1, Math.min(page, totalPages));

  // Ocultar todas las noticias
  document.querySelectorAll(".news-card").forEach((card) => {
    card.style.display = "none";
  });

  // Mostrar solo las noticias filtradas de la página actual
  const startIndex = (currentPage - 1) * cardsPerPage;
  const endIndex = startIndex + cardsPerPage;

  filteredCards.slice(startIndex, endIndex).forEach((card) => {
    card.style.display = "block";
  });

  // Actualiza estado botones
  const prevBtn = document.getElementById("prevPage");
  const nextBtn = document.getElementById("nextPage");
  const noResultsMessage = document.getElementById("noResultsMessage");

  prevBtn.disabled = currentPage === 1;
  nextBtn.disabled = currentPage === totalPages || totalPages === 0;

  if (filteredCards.length === 0) {
    prevBtn.style.display = "none";
    nextBtn.style.display = "none";
    noResultsMessage.style.display = "block"; // Mostrar mensaje
  } else {
    prevBtn.style.display = "inline-block";
    nextBtn.style.display = "inline-block";
    noResultsMessage.style.display = "none"; // Ocultar mensaje
  }
}

function filterCards() {
  const search = document.getElementById("newsSearch").value.toLowerCase();
  const allCards = Array.from(document.querySelectorAll(".news-card"));

  filteredCards = allCards.filter((card) => {
    const title = card.querySelector("h2").textContent.toLowerCase();
    return title.includes(search);
  });

  currentPage = 3; // Reinicia a página 3 al filtrar
  showPage(currentPage);
}

document.getElementById("newsSearch").addEventListener("input", filterCards);

document.getElementById("prevPage").addEventListener("click", () => {
  showPage(currentPage - 1);
});

document.getElementById("nextPage").addEventListener("click", () => {
  showPage(currentPage + 1);
});

// Contadores animados
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

  // Inicializar noticias mostrando la última página al cargar
  filteredCards = Array.from(document.querySelectorAll(".news-card"));
  showPage(Math.ceil(filteredCards.length / cardsPerPage));
});

window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
