/*
https://api.upbit.com/v1/market/all
{
    "market": "KRW-BTC",
    "korean_name": "비트코인",
    "english_name": "Bitcoin"
  },
*/
// async function dataFetch() {}
// const dataFetch = async function () {};
// async는 function 앞에 붙임

const market = document.querySelector("#market");
const dataFetch = async () => {
  const response = await fetch("https://api.upbit.com/v1/market/all");
  const data = await response.json();
  //   for (let i = 0; i < data.length; i++) {
  //     const evenDataMarket =
  //       (upbitInfo.innerHTML += `${data[i].korean_name}(${data[i].market})<br />`);
  //   }
  //   data.forEach((item) => {
  //     // startsWith: 시작하는 단어 여부, includes: 포함 여부
  //     // console.log(item.market, item.market.includes("KRW"));
  //     // console.log(item.korean_name);
  //     if (item.market.includes("KRW")) {
  //       market.innerHTML += `<h3>${item.korean_name}(${item.market})</h3>`;
  //     }
  //   });
  // forEach + 조건문 -> filter
  const krwMarkets = data.filter((item) => item.market.includes("KRW"));

  //   let markets = "";
  //   krwMarkets.forEach((item) => {
  //     markets += item.market + ",";
  //   console.log(markets.slice(0, -1)); 마지막 문자(",") 제거
  //   });
  // forEach + 내가 원하는 형태로 가공하고자 할 때 -> map
  const markets = krwMarkets.map((item) => item.market).join(",");

  const tickerResponse = await fetch(
    `https://api.upbit.com/v1/ticker?markets=${markets}`
  );
  const tickerData = await tickerResponse.json();
  // console.log(tickerData);

  krwMarkets.forEach((item) => {
    const ticker = tickerData.find((ticker) => ticker.market === item.market);
    market.innerHTML += `<h3>${item.korean_name}(${item.market})</h3>
        <p>현재가: ${ticker.trade_price.toLocaleString()}원</p>
        <p>24시간 거래량: ${ticker.acc_trade_volume_24h.toFixed(2)}</p>
        <p>전일 대비: ${
          ticker.change === "RISE"
            ? "상승"
            : ticker.change === "FALL"
            ? "하락"
            : "보합"
        } (${(ticker.change_rate * 100).toFixed(2)}%)</p>
    `;
  });
  /*
    toLocaleString(): 이거 쓰면 1000 > 1,000
    toFixed(2) > 소수점 2자리만 표시
  */
};
dataFetch();
