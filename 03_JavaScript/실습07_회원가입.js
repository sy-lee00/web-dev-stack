const id = document.querySelector("#id");
const pw = document.querySelector("#pw");
const pwCheck = document.querySelector("#pwCheck");
const nick = document.querySelector("#nick");
const mail = document.querySelector("#mail");
const num = document.querySelector("#num");
const petternId = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
const petternPw =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
const petternNick = /^[가-힣]{2,}$/;
const petternMail = /^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$/;
const petternNum = /^010-\d{4}-\d{4}$/;
const input = document.querySelectorAll("input");
const sign = document.querySelector("#sign");
const cancel = document.querySelector("#cancel");
const form = document.querySelector("#form");

input[0].addEventListener("input", (e) => {
  if (petternId.test(input[0].value) === true) {
    id.innerHTML = "OK!";
    id.style.color = "lightgreen";
  } else if (petternId.test(input[0].value) === false) {
    id.innerHTML = "재입력!";
    id.style.color = "red";
  }
  if (e.target.value === "") {
    id.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
    id.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

input[1].addEventListener("input", (e) => {
  if (petternPw.test(input[1].value) === true) {
    pw.innerHTML = "OK!";
    pw.style.color = "lightgreen";
  } else if (petternPw.test(input[1].value) === false) {
    pw.innerHTML = "재입력!";
    pw.style.color = "red";
  }
  if (e.target.value === "") {
    pw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    pw.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

input[2].addEventListener("input", (e) => {
  if (input[2].value !== input[1].value) {
    pwCheck.innerHTML = "비밀번호를 다시 확인해주세요.";
    pwCheck.style.color = "red";
  } else if (input[2].value === input[1].value) {
    pwCheck.innerHTML = "비밀번호가 확인되었습니다.";
    pwCheck.style.color = "lightgreen";
  }
  if (e.target.value === "") {
    pwCheck.innerHTML = "위 비밀번호와 동일하게";
    pwCheck.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

input[3].addEventListener("input", (e) => {
  if (petternNick.test(input[3].value) === true) {
    nick.innerHTML = "OK!";
    nick.style.color = "lightgreen";
  } else if (petternNick.test(input[3].value) === false) {
    nick.innerHTML = "재입력!";
    nick.style.color = "red";
  }
  if (e.target.value === "") {
    nick.innerHTML = "한글 2자 이상";
    nick.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

input[4].addEventListener("input", (e) => {
  if (petternMail.test(input[4].value) === true) {
    mail.innerHTML = "OK!";
    mail.style.color = "lightgreen";
  } else if (petternMail.test(input[4].value) === false) {
    mail.innerHTML = "재입력!";
    mail.style.color = "red";
  }
  if (e.target.value === "") {
    mail.innerHTML = "이메일 형식";
    mail.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

input[5].addEventListener("input", (e) => {
  if (petternNum.test(input[5].value) === true) {
    num.innerHTML = "OK!";
    num.style.color = "lightgreen";
  } else if (petternNum.test(input[5].value) === false) {
    num.innerHTML = "재입력!";
    num.style.color = "red";
  }
  if (e.target.value === "") {
    num.innerHTML = "전화번호 형식";
    num.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

cancel.addEventListener("click", () => {
  for (i = 0; i < input.length; i++) {
    input[i].value = "";
    id.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
    id.style.color = "rgba(0, 0, 0, 0.2)";
    pw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    pw.style.color = "rgba(0, 0, 0, 0.2)";
    pwCheck.innerHTML = "위 비밀번호와 동일하게";
    pwCheck.style.color = "rgba(0, 0, 0, 0.2)";
    nick.innerHTML = "한글 2자 이상";
    nick.style.color = "rgba(0, 0, 0, 0.2)";
    mail.innerHTML = "이메일 형식";
    mail.style.color = "rgba(0, 0, 0, 0.2)";
    num.innerHTML = "전화번호 형식";
    num.style.color = "rgba(0, 0, 0, 0.2)";
  }
});

if (
  id.innerHTML == "Ok!" &&
  pw.innerHTML == "OK!" &&
  pwCheck.innerHTML == "비밀번호가 확인되었습니다." &&
  nick.innerHTML == "OK!" &&
  mail.innerHTML == "OK!" &&
  num.innerHTML == "OK!"
) {
  alert("회원가입 완료!");
  sign.addEventListener("summit", (e) => {
    if (input.innerHTML == "") e.preventDefault();
  });
}
