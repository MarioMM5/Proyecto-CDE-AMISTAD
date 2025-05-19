window.addEventListener("DOMContentLoaded", () => {
  const params = new URLSearchParams(window.location.search);
  const tipo = params.get("tipo");

  const contenido = {
    femenino: {
      titulo: "Equipos Femeninos",
      descripcion: `
  <p><strong>No importa tu edad ni tu nivel:</strong> ¡estás invitada a formar parte de nuestra gran familia futbolera!<br>
  Ven a conocernos, disfrutar del deporte y sentirte parte de un equipo de verdad.</p><br><br>

  <p>En el <strong>C.D.E. Amistad</strong> llevamos más de <strong>15 años impulsando el fútbol femenino</strong>, contando con jugadoras y entrenadoras desde nuestros inicios.</p><br><br>

  <p>Actualmente, somos el <strong>único club de Alcorcón</strong> con equipos femeninos en todas las categorías, sumando más de <strong>250 jugadoras</strong> repartidas en <strong>15 equipos</strong>.</p><br><br>

  <p>Ofrecemos una <strong>formación continua, personalizada y de calidad</strong>, adaptada a todas las edades y niveles. Nuestro cuerpo técnico cuenta con amplia experiencia en el <strong>fútbol femenino profesional</strong> y trabaja bajo un proyecto estable, con pasión y visión de futuro.</p><br><br>

  <p>Nuestro objetivo es <strong>acercar el deporte y sus valores</strong> a la vida de las niñas y jóvenes de Alcorcón, fomentando el crecimiento personal a través del fútbol.</p><br><br>

  <p><strong>¿Quieres formar parte de este sueño?</strong><br>
  Rellena el formulario y te contactaremos para que vengas a probar. <strong>¡Te estamos esperando!</strong></p>
`,
      imagen: "../img/cde-femenino.jpg"
    },
    f7: {
      titulo: "Equipos de Fútbol 7",
      descripcion: `
<p><strong>¿Quieres unirte a la familia verde?</strong> Te invitamos a nuestras Jornadas de Puertas Abiertas para que nos conozcas de cerca y vivas la experiencia de entrenar con nosotros sin compromiso.</p>

<p>Una vez más, abrimos las puertas de nuestra escuela para que puedas venir, divertirte, entrenar y sentirte parte de un grupo que apuesta por la formación deportiva de calidad. En el <strong>C.D.E. Amistad</strong> contamos con profesionales experimentados que te guiarán y acompañarán en tu crecimiento como deportista y persona, con un ambiente cercano y amigable.</p><br><br>

<p>Somos el <strong>único club de Alcorcón</strong> con equipos masculinos y femeninos en todas las categorías, desde los 3 años, para que crezcas con nosotros paso a paso. El propósito de estas Jornadas es que puedas conocernos, descubrir cómo trabajamos y, si te gusta, formar parte de esta gran familia verde.</p><br><br>

<p>Si tienes entre 3 y 12 años y te apasiona el fútbol o quieres aprender, no dudes en venir a conocernos. <strong>No tienes nada que perder y mucho por ganar.</strong> Solo necesitas rellenar el formulario que aparece abajo, y nos pondremos en contacto contigo por email para indicarte los días y horarios de entrenamiento.</p><br><br>

<p>Las plazas son limitadas y su asignación corresponde exclusivamente al <strong>C.D.E. Amistad Alcorcón</strong>. <strong>¡Prepárate para disfrutar del fútbol con nosotros!</strong></p>

`,
      imagen: "../img/cde-f7.jpg"
    },
    f11: {
      titulo: "Equipos de Fútbol 11",
      descripcion: `<p><strong>¿Quieres formar parte del C.D.E. Amistad?</strong> ¡Esta es tu oportunidad!</p><br>

<p>En el <strong>C.D.E. Amistad</strong> te brindamos la mejor formación deportiva con profesionales experimentados. Contamos con entrenadores titulados, preparador físico, fisioterapia, nutrición y psicología deportiva, la fórmula perfecta para una experiencia completa.</p>

<p>Más allá de la profesionalidad y compromiso, ofrecemos un ambiente cercano y acogedor donde podrás crecer como deportista y persona. Actualmente, somos el único club de Alcorcón con equipos femeninos y masculinos en todas las categorías.</p><br><br>

<p>Nuestros equipos llevan varias temporadas cosechando ascensos: el Juvenil «A» está en Preferente, el Cadete «A» pelea por subir a Autonómica y el Infantil «A» acaba de ascender a Preferente.</p>

<p>Buscamos jugadores comprometidos que amen competir y disfrutar del fútbol. Si tienes más de 14 años y quieres unirte al C.D.E. Amistad la próxima temporada, esta es tu oportunidad. Solo tienes que rellenar el formulario y nos pondremos en contacto contigo por email para indicarte día y hora de tu prueba.</p><br><br>

<p>Las plazas son limitadas y su asignación depende exclusivamente del <strong>C.D.E. Amistad</strong>. <strong>¡Te estamos esperando!</strong></p>
`,
      imagen: "../img/cde-f11.jpg"
    }
  };

  const data = contenido[tipo];

  if (data) {
    document.getElementById("contenido-dinamico").innerHTML = `
      <div class="equipo-section">
        <h1>${data.titulo}</h1>
        <img src="${data.imagen}" alt="${data.titulo}" class="equipo-img"/>
        <p>${data.descripcion}</p>
      </div>
    `;
  } else {
    document.getElementById("contenido-dinamico").innerHTML = `
      <p style="color: red;">Tipo de equipo no válido.</p>
    `;
  }
});
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
window.addEventListener("scroll", () => {
  const header = document.getElementById("fixedHeader");
  if (window.scrollY > 50) {
    header.classList.add("scrolled");
  } else {
    header.classList.remove("scrolled");
  }
});
