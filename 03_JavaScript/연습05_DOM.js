// 1번 문제
// 안녕하세요를 result에 출력
const rst1 = document.querySelector("#result1");
function printText() {
  rst1.innerHTML = "안녕하세요";
}

// 2번 문제
const input1 = document.querySelector("#customer");
const rst2 = document.querySelector("#result2");
function printInputValue() {
  rst2.innerHTML = input1.value;
  input1.value = "";
}

// 3번 문제
const div = document.querySelector(".div-test");
function changeColor() {
  div.style.background = "green";
}

// 4번 문제
const input2 = document.querySelector("#text");
const rst4 = document.querySelector("#result4");
function stringLength() {
  rst4.innerHTML = `${input2.value.length} 글자`;
  text.value = "";
}

// 5번 문제
const la = document.querySelector("#la");
const rst5 = document.querySelector("#result5");
const fruitArr = la.textContent.split(", ");
const ul = document.createElement("ul");
rst5.appendChild(ul);
function stringSplit() {
  for (i = 0; i < fruitArr.length; i++) {
    const li = document.createElement("li");
    li.innerHTML = fruitArr[i];
    // ul.appendChild(li);
    ul.innerHTML += `<li> ${fruitArr[i]} </li>`;
  }
}

// 6번 문제
function arrayTest() {
  const prv = document.querySelector("#preview");
  const remove = document.querySelector("#remove");
  const add = document.querySelector("#add");
  const prvArr = prv.innerHTML.split(" ");
  // 내가 한 것
  //   for (let i = 0; i < prvArr.length; i++) {
  //     if (prvArr[i] == remove.value) prvArr.splice(i, 1);
  //   }
  // 2번째 방법
  const delIdx = prvArr.indexOf(remove.value);
  console.log(delIdx);
  if (delIdx !== -1) prvArr.splice(delIdx, 1);

  // +)
  //   console.log(prvArr.includes(remove.value));
  //   if (prvArr.includes(remove.value)) prvArr.splice(delIdx, 1);

  // 추가 -> 배열에 해당 값 추가! push
  prvArr.push(add.value);

  prv.textContent = prvArr.join(" ");
}
// 7번 문제: prompt로 이름, 나이, 주소 순으로 입력받아서 출력(총 3명)
const names = document.querySelectorAll(".name");
const ages = document.querySelectorAll(".age");
const addrs = document.querySelectorAll(".addr");
function addStudent() {
  console.log(names);
  for (let i = 0; i < 3; i++) {
    names[i].textContent = prompt(`${i}번째 학생 이름 입력(차례로)`);
    ages[i].textContent = prompt(`${i}번째 학생 나이 입력(차례로)`);
    addrs[i].textContent = prompt(`${i}번째 학생 주소 입력(차례로)`);
  }
}

// 8번
const list = document.querySelector("#list");
function addItem() {
  // 1. li 태그를 만들어서 추가하는 방식
  const li = document.createElement("li");
  li.textContent = "테스트";
  list.appendChild(li);

  // 2. innerHTML로 문자로 추가하는 방식
  list.innerHTML += "<li>테스트</li>";
}

function removeItem() {
  // 1. 부모에서 제거
  //   console.log(list.childNodes);
  //   list.removeChild(list.childNodes[0]);
  // 2. 본인이 제거
  const li = document.querySelector("#list li"); // All 빼면 첫번째 하나만 가져옴
  li.remove();
}

// 9번
const rst9 = document.querySelector("#result9");
function toggleClass() {
  rst9.classList.toggle("active");
}

// 10번
const item = document.querySelector("#item");
const price = document.querySelector("#price");
const cart = document.querySelector("#cart");
const total = document.querySelector("#total span");
let sum = 0;
function addToCart() {
  cart.innerHTML += `<li>${item.value} - ${price.value}</li>`;

  console.log(isNaN(Number(price.value))); // NaN
  if (!isNaN(Number(price.value))) {
    sum += Number(price.value);
    total.innerHTML = sum;
  }

  item.value = "";
  price.value = "";
}
