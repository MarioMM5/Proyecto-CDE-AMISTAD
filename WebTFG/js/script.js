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
const canvas = document.getElementById("penaltyCanvas");
const ctx = canvas.getContext("2d");
const buttons = document.querySelectorAll(".controls button");
const resultMessage = document.getElementById("resultMessage");

const goalWidth = 300;
const goalHeight = 150;
const goalX = (canvas.width - goalWidth) / 2;
const goalY = 50;

function drawGoal() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);

  ctx.strokeStyle = "#ecf0f1";
  ctx.lineWidth = 5;
  ctx.beginPath();
  ctx.rect(goalX, goalY, goalWidth, goalHeight);
  ctx.stroke();

  drawKeeper(0);
}

function drawKeeper(offsetX) {
  const keeperX = canvas.width / 2 + offsetX;
  const keeperY = goalY + goalHeight / 2;
  const radius = 30;

  ctx.fillStyle = "#e74c3c";
  ctx.beginPath();
  ctx.arc(keeperX, keeperY, radius, 0, Math.PI * 2);
  ctx.fill();

  // Ojos del portero
  ctx.fillStyle = "white";
  ctx.beginPath();
  ctx.arc(keeperX - 10, keeperY - 5, 5, 0, Math.PI * 2);
  ctx.arc(keeperX + 10, keeperY - 5, 5, 0, Math.PI * 2);
  ctx.fill();

  ctx.fillStyle = "black";
  ctx.beginPath();
  ctx.arc(keeperX - 10, keeperY - 5, 2, 0, Math.PI * 2);
  ctx.arc(keeperX + 10, keeperY - 5, 2, 0, Math.PI * 2);
  ctx.fill();
}

function animateKeeper(direction, callback) {
  let offsetX = 0;
  let targetOffset = 0;

  switch (direction) {
    case "left":
      targetOffset = -goalWidth / 4;
      break;
    case "center":
      targetOffset = 0;
      break;
    case "right":
      targetOffset = goalWidth / 4;
      break;
  }

  const frames = 20;
  let currentFrame = 0;

  function step() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    ctx.strokeStyle = "#ecf0f1";
    ctx.lineWidth = 5;
    ctx.beginPath();
    ctx.rect(goalX, goalY, goalWidth, goalHeight);
    ctx.stroke();

    offsetX = (targetOffset / frames) * currentFrame;
    drawKeeper(offsetX);

    currentFrame++;
    if (currentFrame <= frames) {
      requestAnimationFrame(step);
    } else {
      callback();
    }
  }
  step();
}

function shoot(direction) {
  const options = ["left", "center", "right"];
  const keeperChoice = options[Math.floor(Math.random() * options.length)];

  animateKeeper(keeperChoice, () => {
    if (direction === keeperChoice) {
      resultMessage.textContent = "¡El portero la PARA! 😱";
      resultMessage.style.color = "#e74c3c";
    } else {
      resultMessage.textContent = "¡GOLAZO! 🎉";
      resultMessage.style.color = "#2ecc71";
    }
  });
}

drawGoal();

buttons.forEach((button) => {
  button.addEventListener("click", () => {
    resultMessage.textContent = "Tirando...";
    resultMessage.style.color = "white";
    shoot(button.getAttribute("data-dir"));
  });
});
