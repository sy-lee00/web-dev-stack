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

signCheck = () => {
  sign.addEventListener("click", (e) => {
    if ((id.innerHTML = "OK!")) {
      if ((pw.innerHTML = "OK!")) {
        if ((pwCheck.innerHTML = "비밀번호를 다시 확인해주세요.")) {
          if ((nick.innerHTML = "OK!")) {
            if ((mail.innerHTML = "OK!")) {
              if ((num.innerHTML = "OK!")) {
                alert("회원가입 완료!");
                e.stopImmediatePropagation();
              }
            }
          }
        }
      }
    }
  });
};

input[0].addEventListener("input", (e) => {
  if (petternId.test(input[0].value) === true) {
    id.innerHTML = "OK!";
    id.style.color = "lightgreen";
  } else if (petternId.test(input[0].value) === false) {
    id.style.color = "red";
    id.innerHTML = "아이디를 입력해주세요";
  }
  if (e.target.value === "") {
    id.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
    id.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
});

input[1].addEventListener("input", (e) => {
  if (petternPw.test(input[1].value) === true) {
    pw.innerHTML = "OK!";
    pw.style.color = "lightgreen";
  } else if (petternPw.test(input[1].value) === false) {
    pw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    pw.style.color = "red";
  }
  switch (petternPw.test(input[1].value)) {
    case false:
      if (input[2].value !== "") {
        pwCheck.innerHTML = "위 비밀번호와 동일하게";
        pwCheck.style.color = "red";
      }
      break;
    case true:
      if (input[2].value === input[1].value) {
        pwCheck.innerHTML = "비밀번호가 확인되었습니다.";
        pwCheck.style.color = "lightgreen";
      }
      break;
  }
  if (e.target.value === "") {
    pw.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    pw.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
});

input[2].addEventListener("input", (e) => {
  if (input[1].value === "") {
    pwCheck.innerHTML = "위 비밀번호와 동일하게";
    pwCheck.style.color = "red";
  }
  switch (petternPw.test(input[1].value)) {
    case false:
      pwCheck.innerHTML = "위 비밀번호와 동일하게";
      pwCheck.style.color = "red";
      break;
    case true:
      if (e.target.value === input[1].value) {
        console.log(e.target.value);
        console.log(input[1].value);
        pwCheck.innerHTML = "비밀번호가 일치합니다.";
        pwCheck.style.color = "lightgreen";
      } else {
        pwCheck.innerHTML = "비밀번호를 다시 확인해주세요.";
        pwCheck.style.color = "red";
      }
      break;
  }
  if (e.target.value === "") {
    pwCheck.innerHTML = "위 비밀번호와 동일하게";
    pwCheck.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
});

input[3].addEventListener("input", (e) => {
  if (petternNick.test(input[3].value) === true) {
    nick.innerHTML = "OK!";
    nick.style.color = "lightgreen";
  } else if (petternNick.test(input[3].value) === false) {
    nick.style.color = "red";
    nick.innerHTML = "이름을 입력해주세요";
  }
  if (e.target.value === "") {
    nick.innerHTML = "한글 2자 이상";
    nick.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
});

input[4].addEventListener("input", (e) => {
  if (petternMail.test(input[4].value) === true) {
    mail.innerHTML = "OK!";
    mail.style.color = "lightgreen";
  } else if (petternMail.test(input[4].value) === false) {
    mail.style.color = "red";
    mail.innerHTML = "이메일을 입력해주세요";
  }
  if (e.target.value === "") {
    mail.innerHTML = "이메일 형식";
    mail.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
});

input[5].addEventListener("input", (e) => {
  if (petternNum.test(input[5].value) === true) {
    num.innerHTML = "OK!";
    num.style.color = "lightgreen";
  } else if (petternNum.test(input[5].value) === false) {
    num.style.color = "red";
    num.innerHTML = "전화번호를 입력해주세요";
  }
  if (e.target.value === "") {
    num.innerHTML = "전화번호 형식";
    num.style.color = "rgba(0, 0, 0, 0.2)";
  }
  signCheck();
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
