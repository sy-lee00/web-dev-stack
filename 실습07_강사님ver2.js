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
    id: "email",
    exp: /^[\w.-]+@[\w.-]+\.[A-Za-z]{2,}$/,
    message: "이메일 형식",
  },
  {
    id: "phone",
    exp: /^010-\d{4}-\d{4}$/,
    message: "전화번호 형식",
  },
];

const validCheck = () => {
  let check = true; // 모든 필드가 유효하다고 가정
  const passwordCheck = document.querySelector("#passwordCheck");
  fields.forEach(({ id, exp }) => {
    const input = document.querySelector(`#${id}`);

    if (input.value === "") {
      console.log(`id1 : `, id);
      check = false;
    } else if (id !== "passwordCheck" && !exp?.test(input.value)) {
      console.log(`id2 : `, id);
      check = false;
    }
    // password : passwordCheck.value !== e.target.value
    if (id === "password" && passwordCheck.value !== input.value) {
      console.log(`id3 : `, id);
      check = false;
    }
  });
  console.log("-----------");
  return check;
};

fields.forEach(({ id, exp, message }) => {
  const input = document.querySelector(`#${id}`);
  const span = document.querySelector(`#${id}+span`);
  const regExp = exp;
  const password = document.querySelector("#password");
  const passRegExp = fields[1].exp;
  input.addEventListener("input", (e) => {
    if (
      (id === "passwordCheck" &&
        passRegExp.test(password.value) &&
        password.value === e.target.value) ||
      regExp?.test(e.target.value)
    ) {
      span.innerHTML = "OK!";
      span.style.color = "green";
    } else if (e.target.value === "") {
      span.innerHTML = message;
      span.style.color = "black";
    } else {
      span.innerHTML = message;
      span.style.color = "red";
    }

    // password
    const passwordCheck = document.querySelector("#passwordCheck");
    const passwordCheckSpan = document.querySelector("#passwordCheck+span");
    if (id === "password") {
      if (passwordCheck.value === e.target.value) {
        passwordCheckSpan.innerHTML = "OK";
        passwordCheckSpan.style.color = "green";
      } else {
        passwordCheckSpan.innerHTML = "위 비밀번호와 동일하게";
        passwordCheckSpan.style.color = "red";
      }
    }

    signup.disabled = !validCheck();
  });
});

const cancel = document.querySelector("#cancel");
cancel.addEventListener("click", () => {
  fields.forEach(({ id, message }) => {
    const span = document.querySelector(`#${id}+span`);
    span.innerHTML = message;
    span.style.color = "black";
  });
});
