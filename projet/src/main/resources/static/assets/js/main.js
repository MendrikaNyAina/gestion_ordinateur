//ici les trucs par ci par la que je vais faire moi meme 
var params = new URLSearchParams(window.location.search);
var page = params.get("page");

var paginationLinks = document.querySelectorAll(".my-pagination a");
console.log(paginationLinks);
paginationLinks.forEach(function (link) {
     //console.log(link);
     const href = window.location.href;
     const param = (new URL(link.href)).searchParams;
     if (page != null && page != undefined) {
          link.href = href.replace(/page=[^&]*/, "page=" + param.get("page"));
     }
     else {
          if (href.includes("?")) {
               link.href = href + "&page=" + param.get("page");
          } else {
               link.href = href + "?page=" + param.get("page");
          }
     }
});

function gestionForm(htmlid, url, urlredirect, method = "POST", content_type = "application/x-www-form-urlencoded") {
     const form = document.querySelector(htmlid);

     form.addEventListener('submit', function (e) {
          e.preventDefault();

          const xhr = new XMLHttpRequest();

          xhr.open(method, url, true);
          xhr.setRequestHeader('Content-Type', content_type);

          const formData = new FormData(form);
          const params = new URLSearchParams(formData).toString();

          xhr.addEventListener('load', function () {
               const response = JSON.parse(xhr.responseText);
               if (response.code == 200) {
                    window.location.href = urlredirect;
               } else {
                    document.getElementById("erreur").textContent = errorMessage
               }
          });

          xhr.send(params);
     });
}

function generatePDF(htmlid, title) {
     var divContents = $("#" + htmlid).html();
     var printWindow = window.open('', '', 'height=400,width=800');
     printWindow.document.write('<html><head><title>' + title + '</title>');
     printWindow.document.write('</head><body >');
     printWindow.document.write(divContents);
     printWindow.document.write('</body></html>');
     printWindow.document.close();
     printWindow.print();
};
function timestamp(date) {
     const year = date.getFullYear();
     const month = (date.getMonth() + 1).toString().padStart(2, '0');
     const day = date.getDate().toString().padStart(2, '0');
     const hours = date.getHours().toString().padStart(2, '0');
     const minutes = date.getMinutes().toString().padStart(2, '0');
     const seconds = date.getSeconds().toString().padStart(2, '0');
     const formattedDate = `${year}-${month}-${day}T${hours}:${minutes}:${seconds}`;
     return formattedDate;
}

function ajoutProduit(user, produit, quantite, unitPrice = 0) {
     let panier = JSON.parse(localStorage.getItem("panier")) || [];
     //verifier si l'utilisateur a deja des produits dans le paniers;
     let indexUser = panier.findIndex(item => item.user.id == user.id);

     //si l'utilisateur a deja des produits dans le panier, ajouter le produit existant ou le creer;
     if (indexUser !== -1) {
          let indexProduit = panier[indexUser].produit.findIndex(item => item.produit.id === produit.id);
          if (indexProduit !== -1) {
               panier[indexUser].produit[indexProduit].quantite += quantite;
          } else {
               panier[indexUser].produit.push({ produit: produit, quantite: quantite, unitPrice: unitPrice });
          }
     } else {
          panier.push({ user: user, produit: [{ produit: produit, quantite: quantite, unitPrice: unitPrice }] });
     }
     localStorage.setItem("panier", JSON.stringify(panier));
}
function changeNbPanier(nb) {
     document.getElementById("panier").innerHTML = nb;
}
function changeNbNotification(nb) {
     document.getElementById("notification").innerHTML = nb;
}
function callPanier(url, method, data) {
     call(url, method, data, function (response) {
          const data = JSON.parse(response);
          changeNbPanier(data.count);
          Swal.fire({
               title: 'Ajout reussi',
               icon: 'success',
               confirmButtonText: 'OK'
          });
     }, function (xhr, status, error) {
          console.log(xhr);
          Swal.fire({
               title: 'Erreur',
               text: xhr.responseText,
               icon: 'error',
               confirmButtonText: 'OK'
          });
     });
}
/*---autocomplete-- */
function autocomplete(str,autoComponent, data,truedata, idEltHandler="laptop_id") { //data est une liste de string
     closeAll();
     var list = document.createElement("DIV");
     list.setAttribute("id", autoComponent.id + "autocomplete-list");
     list.setAttribute("class", "autocomplete-items");

     
     autoComponent.parentNode.appendChild(list);
     addAutocompleteElt(autoComponent, str, data, list, truedata, idEltHandler);
     
     document.addEventListener("click", function (e) {
          closeAll();
     });
}
function addAutocompleteElt(input, str, arr, list, data=[], idEltHandler="laptop_id") {
     var elt = input;
     for (i = 0; i < arr.length; i++) {
          /*create a DIV element for each matching element:*/
          elt = document.createElement("DIV");
          /*make the matching letters bold:*/
          elt.innerHTML = "<strong>" + arr[i].substr(0, str.length) + "</strong>";
          elt.innerHTML += arr[i].substr(str.length);
          /*insert a input field that will hold the current array item's value:*/
          var id=arr[i];
          //console.log(data[i]);
          if(data[i].id != undefined){
               id=data[i].id;
          }
          
          elt.innerHTML += "<input type='hidden' value='" + id + "'>";
          /*execute a function when someone clicks on the item value (DIV element):*/
          elt.addEventListener("click", function (e) {
               /*insert the value for the autocomplete text field:*/
              
               input.value = this.textContent;
               document.getElementById(idEltHandler).value = this.getElementsByTagName("input")[0].value;
               /*close the list of autocompleted values,
               (or any other open lists of autocompleted values:*/
               closeAll()

          });
          list.appendChild(elt);
     }
}
function closeAll(){
     var x = document.getElementsByClassName("autocomplete-items");
     for (var i = 0; i < x.length; i++) {
         x[i].parentNode.removeChild(x[i]);
     }
}
function autocompleteNotCall(str,autoComponent, data,truedata, idEltHandler="laptop_id", action=(elt, value)=>{}) { //data est une liste de string
     closeAll();
     var list = document.createElement("DIV");
     list.setAttribute("id", autoComponent.id + "autocomplete-list");
     list.setAttribute("class", "autocomplete-items");

     
     autoComponent.parentNode.appendChild(list);
     addAutocompleteEltSearch(autoComponent, str, data, list, truedata, idEltHandler, action);
     
     document.addEventListener("click", function (e) {
          closeAll();
     });
}
function addAutocompleteEltSearch(input, str, arr, list, data=[], idEltHandler="laptop_id", action=(elt, value)=>{}) {
     var elt = input;
     for (i = 0; i < arr.length; i++) {
          //checker si contenu dedans
          if(arr[i].toLowerCase().includes(str.toLowerCase()) ){             
          /*create a DIV element for each matching element:*/
               elt = document.createElement("DIV");
               /*make the matching letters bold:*/
               elt.innerHTML = arr[i];
               /*insert a input field that will hold the current array item's value:*/
               var id=arr[i];
               //console.log(data[i]);
               if(data[i].id != undefined){
                    id=data[i].id;
               }
               
               elt.innerHTML += "<input type='hidden' value='" + id + "'>";
               /*execute a function when someone clicks on the item value (DIV element):*/
               elt.addEventListener("click", function (e) {
                    /*insert the value for the autocomplete text field:*/
                   
                    input.value = this.textContent;
                    try{
                         document.getElementById(idEltHandler).value = this.getElementsByTagName("input")[0].value;
                    }catch(e){
                    }   
                    //console.log(e.target.parentNode);               
                    action(e.target, this.getElementsByTagName("input")[0].value);
                    /*close the list of autocompleted values,
                    (or any other open lists of autocompleted values:*/
                    closeAll()
     
               });
               list.appendChild(elt);
          }
          
     }
}
/*---autocomplete-- */
