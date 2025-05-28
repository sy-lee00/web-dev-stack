const img1 = document.querySelector("#img1");
const img2 = document.querySelector("#img2");
const img3 = document.querySelector("#img3");
const click = document.querySelector("#click");
const restart = document.querySelector("#restart");
const conglate = document.querySelector("#conglate");
let i = 0;
let order = [1, 2, 3];

click.addEventListener("click", (e) => {
  const random1 = Math.floor(Math.random() * 3 + 1);
  const random2 = Math.floor(Math.random() * 3 + 1);
  const random3 = Math.floor(Math.random() * 3 + 1);
  i += 1;
  e.target.textContent = `Click ${i}`;
  img1.style.backgroundImage = `url(./asset/spy${random1}.jpg)`;
  img2.style.backgroundImage = `url(./asset/spy${random2}.jpg)`;
  img3.style.backgroundImage = `url(./asset/spy${random3}.jpg)`;
  if (random1 === random2) {
    if (random2 === random3) {
      conglate.style.visibility = "visible";
      e.preventDefault();
    }
  }
});

restart.addEventListener("click", () => {
  const random1 = Math.floor(Math.random() * 3 + 1);
  const random2 = Math.floor(Math.random() * 3 + 1);
  const random3 = Math.floor(Math.random() * 3 + 1);
  img1.style.backgroundImage = `url(./asset/spy${random1}.jpg)`;
  img2.style.backgroundImage = `url(./asset/spy${random2}.jpg)`;
  img3.style.backgroundImage = `url(./asset/spy${random3}.jpg)`;
  conglate.style.visibility = "hidden";
  click.textContent = "Click";
});
