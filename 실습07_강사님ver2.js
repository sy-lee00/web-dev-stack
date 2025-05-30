const signup = document.querySelector("#signup");
const fields = [
  {
    id: "userId",
    exp: /^[a-zA-Z][a-zA-Z0-9]{3,11}$/,
    message: "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내",
  },
  {
    id: "password",
    exp: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/,
    message: "영문자, 숫자, 특수문자 조합으로 8~15자 이내",
  },
  {
    id: "passwordCheck",
    message: "위 비밀번호와 동일하게",
  },
  {
    id: "userName",
    exp: /^[가-힣]{2,}$/,
    message: "한글 2자 이상",
  },
  {
    id: "userEmail",
    exp: /^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$/,
    message: "이메일 형식",
  },
  {
    id: "userNumber",
    exp: /^010-\d{4}-\d{4}$/,
    message: "전화번호 형식",
  },
];

const validCheck = () => {
  let check = true; // 모든 필드가 유효하다고 가정
  const passwordCheckSpan = document.querySelector("#passwordCheck+span");
  fields.forEach(({ id, exp }) => {
    const input = document.querySelector(`#${id}`);
    if (input.value === "") {
      check = false;
    } else if (id !== "passwordChexk" && !exp.test(input.value)) {
      check = false;
    }
  });
  return check;
};

if (id === "password" && passwordCheck !== input.value)
  fields.forEach(({ id, exp, message, check }) => {
    const input = document.querySelector(`#${id}`);
    const span = document.querySelector(`#${id}+span`);
    const regExp = exp;
    input.addEventListener("input", (e) => {
      if (
        id === "passwordCheck" &&
        regExp.test(e.target.value) &&
        e.target.value === ""
      ) {
        span.innerHTML = "OK!";
        span.style.color = "green";
      } else if (true) {
        if (regExp.test(e.target.value)) {
          span.innerHTML = "OK!";
          span.style.color = "green";
        } else if (e.target.value === "") {
          span.innerHTML = message;
          span.style.color = "black";
        } else {
          span.innerHTML = message;
          span.style.color = "red";
        }
        signup.disabled = !(
          fields[0].check &&
          fields[1].check &&
          fields[2].check &&
          fields[3].check &&
          fields[4].check &&
          fields[5].check
        );
      }
    });
  });

let check1 = false; // userId
let check2 = false; // password
let check3 = false; // passwordCheck
let check4 = false; // userName
let check5 = false; // userEmail
let check6 = false; // userNumber

const userId = document.querySelector("#userId");
const userSpan = document.querySelector("#userId+span");
const userRegExp = /^[a-zA-Z][a-zA-Z0-9]{3,11}$/;
userId.addEventListener("input", (e) => {
  if (userRegExp.test(e.target.value)) {
    userSpan.innerHTML = "OK!";
    userSpan.style.color = "green";
    check1 = true;
  } else if (e.target.value === "") {
    userSpan.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
    userSpan.style.color = "black";
    check1 = false;
  } else {
    userSpan.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
    userSpan.style.color = "red";
    check1 = false;
  }
  /*
  if (check1 && check2 && check3 && check4 && check5 && check6) {
    signup.disabled = false;
  }
    */
  // every: 배열 안에 특정 조건이 모두 만족할 경우
  signup.disabled = !fields.every((field) => field.check === true);
  signup.disabled = !(check1 && check2 && check3 && check4 && check5 && check6);
});

const password = document.querySelector("#password");
const passwordSpan = document.querySelector("#password+span");
const passwordCheck = document.querySelector("#passwordCheck");
const passwordCheckSpan = document.querySelector("#passwordCheck+span");

const passRegExp =
  /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,15}$/;
password.addEventListener("input", (e) => {
  if (exp !== undefined && passRegExp.test(e.target.value)) {
    passwordSpan.innerHTML = "OK!";
    passwordSpan.style.color = "green";
    check2 = true;
  } else if (e.target.value === "") {
    passwordSpan.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    passwordSpan.style.color = "black";
    check2 = false;
  } else {
    passwordSpan.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
    passwordSpan.style.color = "red";
    check2 = false;
  }
});

passwordCheck.addEventListener("input", (e) => {
  if (passRegExp.test(password.value) && password.value === e.target.value) {
    passwordCheckSpan.innerHTML = "OK!";
    passwordCheckSpan.style.color = "green";
    check3 = true;
  } else if (e.target.value === "") {
    passwordCheckSpan.innerHTML = "위 비밀번호와 동일하게";
    passwordCheckSpan.style.color = "black";
    check3 = false;
  } else {
    passwordCheckSpan.innerHTML = "위 비밀번호와 동일하게";
    passwordCheckSpan.style.color = "red";
    check3 = false;
  }
  signup.disabled = !validCheck();
});

const userNumber = document.querySelector("#userNumber");
const userNumberSpan = document.querySelector("#userNumber+span");
const userNumberRegExp = /^010-\d{4}-\d{4}$/;
userNumber.addEventListener("input", (e) => {
  if (puserNumberRegExp.test(e.target.value)) {
    userNumberSpan.innerHTML = "OK!";
    userNumberSpan.style.color = "green";
    check6 = true;
  } else if (e.target.value === "") {
    userNumberSpan.innerHTML = "전화번호 형식";
    userNumberSpan.style.color = "black";
    check6 = false;
  } else {
    userNumberSpan.innerHTML = "전화번호 형식";
    userNumberSpan.style.color = "red";
    check6 = false;
  }
  signup.disabled = !(check1 && check2 && check3 && check4 && check5 && check6);
});

const cancel = document.querySelector("#cancel");
cancel.addEventListener("click", () => {
  fields;
  userSpan.innerHTML = "영문자로 시작하고 영문자와 숫자 조합으로 4~12자 이내";
  userSpan.style.color = "black";
  passwordSpan.innerHTML = "영문자, 숫자, 특수문자 조합으로 8~15자 이내";
  passwordSpan.style.color = "black";
  passwordCheckSpan.innerHTML = "위 비밀번호와 동일하게";
  passwordCheckSpan.style.color = "black";
  userNameSpan.innerHTML = "한글 2자 이상";
  userNameSpan.style.color = "black";
  userEmailSpan.innerHTML = "이메일 형식";
  userEmailSpan.style.color = "black";
  userNumberSpan.innerHTML = "전화번호 형식";
  userNumberSpan.style.color = "black";
});
