window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const addProfit = document.getElementById("profit");
  console.log(priceInput)
  console.log(addTaxDom)
  console.log(addProfit)
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue)
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)
    addProfit.innerHTML = Math.floor(inputValue * 0.9)
  })
});