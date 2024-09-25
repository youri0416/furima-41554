function price (){
  const priceInput = document.getElementById("item-price");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);

    // 利益を計算
    const profit = inputValue - tax;

    // 販売手数料を表示
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = tax;

    // 利益を表示
    const priceProfit = document.getElementById("profit");
    priceProfit.innerHTML = profit;
  })
}

window.addEventListener('turbo:load', price);
window.addEventListener("turbo:render", price);
