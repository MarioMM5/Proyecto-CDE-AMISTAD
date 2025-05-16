const sidebar = document.getElementById("sidebar");
const toggleBtn = document.getElementById("toggleBtn");
const arrow = toggleBtn.querySelector(".arrow");
const icon = toggleBtn.querySelector('i');

// Funcionalidad para el menú lateral
toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
  icon.classList.toggle('fa-arrow-right');
  icon.classList.toggle('fa-xmark'); // o cualquier otra transformación
  // Cambia la flecha dependiendo de si el menú está colapsado o no
  arrow.innerHTML = sidebar.classList.contains("collapsed") ? "&#x25C0;" : "&#x25B6;";

});

// Carrusel de imágenes
let currentIndex = 0;
const carousel = document.getElementById("carousel");
const images = carousel.querySelectorAll("img");
const totalImages = images.length;

// Funcionalidad para el botón "Siguiente"
document.getElementById("nextBtn").addEventListener("click", () => {
  currentIndex = (currentIndex + 1) % totalImages;
  updateCarousel();
});

// Funcionalidad para el botón "Anterior"
document.getElementById("prevBtn").addEventListener("click", () => {
  currentIndex = (currentIndex - 1 + totalImages) % totalImages;
  updateCarousel();
});

// Actualiza la posición del carrusel
function updateCarousel() {
  const offset = -currentIndex * 100; // El ancho de las imágenes es 100% del contenedor
  carousel.style.transform = `translateX(${offset}%)`; // Usamos % para mantener la adaptabilidad
}


window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
