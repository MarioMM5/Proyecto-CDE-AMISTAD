        const SUPABASE_URL = 'https://sbbddlhuflacpqnrvpyb.supabase.co';
        const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNiYmRkbGh1ZmxhY3BxbnJ2cHliIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMjUxNzAsImV4cCI6MjA2MTcwMTE3MH0.ZGvT8pasYJoW-2nLfoRyH5gqCsy9c218Cqkoz0XUxtU';
        const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

        const urlParams = new URLSearchParams(window.location.search);
        const noticiaId = urlParams.get('id');

        async function cargarNoticia(id) {
            const { data, error } = await supabaseClient
                .from('noticias')
                .select('*')
                .eq('id', id)
                .single();

            if (error || !data) {
                document.getElementById('titulo').textContent = '';
                document.getElementById('fecha').textContent = '';
                document.getElementById('contenido').textContent = '';
                document.getElementById('imagen').style.display = 'none';

                const errDiv = document.getElementById('error');
                errDiv.style.display = 'block';
                errDiv.textContent = '⚠️ No se pudo cargar la noticia o no existe.';
                return;
            }

            document.getElementById('titulo').textContent = data.titulo;
            document.getElementById('fecha').textContent = new Date(data.fecha).toLocaleDateString('es-ES', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
            document.getElementById('contenido').textContent = data.contenido;

            if (data.imagen) {
                const img = document.getElementById('imagen');
                img.src = data.imagen;
                img.alt = data.titulo;
                img.style.display = 'block';
            }
        }

        if (!noticiaId) {
            document.getElementById('titulo').textContent = '';
            const errDiv = document.getElementById('error');
            errDiv.style.display = 'block';
            errDiv.textContent = '⚠️ No se especificó ninguna noticia.';
        } else {
            cargarNoticia(noticiaId);
        }
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