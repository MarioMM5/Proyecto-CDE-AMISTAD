const SUPABASE_URL = "https://sbbddlhuflacpqnrvpyb.supabase.co";
const SUPABASE_ANON_KEY =
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU"; // tu key completa
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
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

const cardsPerPage = 9;
let currentPage = 1;
let filteredCards = [];

function showPage(page) {
  const totalPages = Math.ceil(filteredCards.length / cardsPerPage);
  currentPage = Math.max(1, Math.min(page, totalPages));
}
function initMap() {
  const location = { lat: 40.33965630499046, lng: -3.8157986731186764 };
  const map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,
    center: location,
    styles: [
      {
        featureType: "all",
        elementType: "labels.text.fill",
        stylers: [{ color: "#00ff7f" }],
      },
      {
        featureType: "all",
        elementType: "geometry",
        stylers: [{ color: "#045d36" }],
      },
    ],
    disableDefaultUI: true,
  });
  new google.maps.Marker({
    position: location,
    map: map,
    title: "maps",
  });
}
document.querySelectorAll(".faq-question").forEach((button) => {
  button.addEventListener("click", () => {
    const expanded = button.getAttribute("aria-expanded") === "true";
    button.setAttribute("aria-expanded", !expanded);

    const answer = button.nextElementSibling;
    if (!expanded) {
      answer.classList.add("show");
    } else {
      answer.classList.remove("show");
    }
  });
});

window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
document.addEventListener("DOMContentLoaded", function () {
  // Credenciales Supabase

document
  .getElementById("contactForm")
  .addEventListener("submit", async function (e) {
    e.preventDefault();

    const fullName = document.getElementById("fullName").value.trim();
    const email = document.getElementById("email").value.trim();
    const message = document.getElementById("message").value.trim();

    // Obtener la fecha local en formato "YYYY-MM-DD" en Madrid
    const fechaLocal = new Date().toLocaleDateString("es-ES", { timeZone: "Europe/Madrid" });
    
    // Convertir a formato ISO local (YYYY-MM-DD)
    // toLocaleDateString puede devolver 15/6/2025, así que normalizamos:
    const [day, month, year] = fechaLocal.split("/");
    const fechaISO = `${year.padStart(4, "0")}-${month.padStart(2, "0")}-${day.padStart(2, "0")}`;

    console.log("Fecha local para insertar (solo fecha):", fechaISO);

    const { data, error } = await supabaseClient
      .from("contact_messages")
      .insert([
        {
          full_name: fullName,
          email: email,
          message: message,
          created_at: fechaISO,
        },
      ]);

    if (error) {
      console.error("❌ Error al insertar en Supabase:", error);
      alert("Error al enviar. Revisa la consola.");
    } else {
      console.log("✅ Mensaje insertado correctamente:", data);
      alert("¡Mensaje enviado con éxito!");
      this.reset();
    }
  });
  // Inicializar el mapa
});
