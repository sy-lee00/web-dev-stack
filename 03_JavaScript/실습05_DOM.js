const nowTime = document.querySelector(".whatTime");
const leftYear = document.querySelector(".leftYear");
const nowDate = document.querySelector(".nowDate");
const body = document.querySelector("body");
let i = 0;
console.log(nowTime.className);
setInterval(() => {
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth();
  const date = now.getDate();
  const hours = now.getHours();
  const minute = now.getMinutes();
  const seconds = now.getSeconds();
  const weeks = ["일", "월", "화", "수", "목", "금", "토"];
  const days = weeks[now.getDay()];

  if (nowDate.className == "nowDate")
    nowDate.innerHTML = `${year}년 ${month + 1}월 ${date}일 (${days})`;
  if (nowTime.className == "whatTime") nowTime.innerHTML = Date().split(" ")[4];
  if (leftYear.className == "leftYear")
    leftYear.innerHTML = `올해 남은 시간 ${365 - (30 * month + date)}일 ${
      24 - hours
    }시간 ${String(60 - minute).padStart(2, "0")}분 ${String(
      60 - seconds
    ).padStart(2, "0")}초`;
  i += 1;
  if (i % 5 == 0)
    body.style.background = `rgba(${Math.floor(
      Math.random() * 256
    )}, ${Math.floor(Math.random() * 256)}, ${Math.floor(
      Math.random() * 256
    )}, 0.4)`;
}, 1000);
