const nowTime = document.querySelector(".whatTime");
const leftYear = document.querySelector(".leftYear");
const now = new Date();
console.log(nowTime.className);
setInterval(() => {
  if (nowTime.className == "whatTime") nowTime.innerHTML = Date().split(" ")[4];
  if (leftYear.className == "leftYear")
    leftYear.innerHTML = `${now.getFullYear()}년 0${13 - now.getMonth()}월 0${
      30 - now.getDate()
    }일 ${now.getSeconds()}초`;
}, 1000);
