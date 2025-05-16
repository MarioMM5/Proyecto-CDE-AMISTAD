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
const icon = toggleBtn.querySelector('i');

// Funcionalidad para el menú lateral
toggleBtn.addEventListener("click", () => {
  sidebar.classList.toggle("collapsed");
  icon.classList.toggle('fa-arrow-right');
  icon.classList.toggle('fa-xmark'); // o cualquier otra transformación
  // Cambia la flecha dependiendo de si el menú está colapsado o no
  arrow.innerHTML = sidebar.classList.contains("collapsed") ? "&#x25C0;" : "&#x25B6;";

});
document.querySelectorAll('.buy-btn').forEach((btn) => {
  btn.addEventListener('click', () => {
    // Aquí usas el id correspondiente de ese producto
    window.location.href = 'detalle-producto.html?id=413844533';
  });
});