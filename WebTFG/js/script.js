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

let currentIndex = 0;
const carousel = document.getElementById("carousel");
const images = carousel.querySelectorAll("img");
const totalImages = images.length;

document.getElementById("nextBtn").addEventListener("click", () => {
  currentIndex = (currentIndex + 1) % totalImages;
  updateCarousel();
});

document.getElementById("prevBtn").addEventListener("click", () => {
  currentIndex = (currentIndex - 1 + totalImages) % totalImages;
  updateCarousel();
});

function updateCarousel() {
  const offset = -currentIndex * 100; 
  carousel.style.transform = `translateX(${offset}%)`; 
}



window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});



