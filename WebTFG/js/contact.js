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
}
  function initMap() {
    const location = {lat: 40.33965630499046, lng: -3.8157986731186764 }; // Coordenadas de Móstoles, ajusta si quieres
    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 15,
      center: location,
      styles: [
        {
          "featureType": "all",
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#00ff7f"}]
        },
        {
          "featureType": "all",
          "elementType": "geometry",
          "stylers": [{"color": "#045d36"}]
        }
      ],
      disableDefaultUI: true,
    });
    new google.maps.Marker({
      position: location,
      map: map,
      title: "Señor Supremo de la Programación",
    });
  }
document.querySelectorAll('.faq-question').forEach(button => {
  button.addEventListener('click', () => {
    const expanded = button.getAttribute('aria-expanded') === 'true';
    button.setAttribute('aria-expanded', !expanded);

    const answer = button.nextElementSibling;
    if (!expanded) {
      answer.classList.add('show');
    } else {
      answer.classList.remove('show');
    }
  });
});
document.getElementById('contactForm').addEventListener('submit', function(e) {
  e.preventDefault();
  alert('¡Mensaje enviado con éxito! Pronto nos pondremos en contacto contigo.');
  this.reset();
});
window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
