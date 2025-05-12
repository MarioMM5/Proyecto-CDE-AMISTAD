const sidebar = document.getElementById("sidebar");
const toggleBtn = document.getElementById("toggleBtn");
const arrow = toggleBtn.querySelector(".arrow");
const icon = toggleBtn.querySelector('i');

// Funcionalidad para el menú lateral
toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
  icon.classList.toggle('fa-arrow-right');
  icon.classList.toggle('fa-xmark'); 

  arrow.innerHTML = sidebar.classList.contains("collapsed") ? "&#x25C0;" : "&#x25B6;";

});

document.getElementById("newsSearch").addEventListener("input", function () {
    const search = this.value.toLowerCase();
    const cards = document.querySelectorAll(".news-card");
  
    cards.forEach(card => {
        const title = card.querySelector("h2").textContent.toLowerCase();
        const match = title.includes(search);
  
      card.style.display = match ? "block" : "none";
    });
  });

  // noticias.js
document.addEventListener("DOMContentLoaded", () => {
    const counters = [
      { id: "matches", target: 128 },
      { id: "fans", target: 2478 },
      { id: "goals", target: 312 }
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
  });

  const quotes = [
    "¡No luchamos por el marcador, luchamos por la gloria!",
    "El verde no es solo un color, es nuestra sangre.",
    "Donde pisa CDE Amistad, florece la victoria."
  ];
  
  document.getElementById("epicQuote").textContent =
    quotes[Math.floor(Math.random() * quotes.length)];
  
  
  


