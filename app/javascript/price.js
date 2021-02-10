function price() {
  const inputPrice = document.getElementById("item-price");
  inputPrice.addEventListener("keyup", () => {
    const itemPrice = inputPrice.value; 
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    addTaxPrice.innerHTML=`${parseInt(itemPrice*0.1)}`;
    profit.innerHTML=`${parseInt(itemPrice*0.9)}`;
  });
}
window.addEventListener('load', price);
