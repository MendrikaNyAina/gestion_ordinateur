<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Stock central" isSelect2="true" isSweetAlert="true">
                                   <link rel="stylesheet" href="/assets/css/form-multistep.css">
                                   <link rel="stylesheet" href="/assets/css/my-select2-style.css">
                              </g:Head>

                              <body>
                                   <jsp:include page="../common/nav/navigationSideBar.jsp" />
                                   <jsp:include page="../common/nav/navigationHead.jsp" />

                                   <div class="pcoded-main-container">
                                        <div class="pcoded-content">
                                             <h:Card>
                                                  <h:CardBody lg="6" md="6" xs="8">
                                                       <h:CardTitle>Faire un achat</h:CardTitle>
                                                       <form action="central_stock" method="post" id="form"
                                                            autocomplete="off">
                                                            <h:Input label="date add " name="date_add" type="date"
                                                                 id="date_add" />
                                                            <input type="hidden" name="laptop_id" id="laptop_id">
                                                            <div class="autocomplete">
                                                                 <h:Input label="Laptop" type="text" id="laptshow" />
                                                            </div>
                                                            <h:Input type="number" step="0.01" id="quantity"
                                                                 label="quantity" name="quantity" />
                                                            <h:Button color="danger" type="submit">Enregistrer
                                                            </h:Button>
                                                       </form>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/stock/";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const date_add = new Date(document.getElementById('date_add').value);
                                             const laptop_id = Number(document.getElementById('laptop_id').value);
                                             const quantity = Number(document.getElementById('quantity').value);

                                             const data = {
                                                  "dateAdd": date_add,
                                                  "laptop": { "id": laptop_id },
                                                  "quantity": quantity
                                             };
                                             console.log(data);
                                             call(url, "POST", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Insertion reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "/admin/stocks";
                                             }, function (xhr, status, error) {
                                                  console.log(error);
                                                  Swal.fire({
                                                       title: 'Erreur',
                                                       text: xhr.responseText,
                                                       icon: 'error',
                                                       confirmButtonText: 'OK'
                                                  });
                                             }
                                             );
                                        });
                                        const autoComponent = document.getElementById("laptshow");
                                        autoComponent.addEventListener("input", function (e) {
                                             const str = this.value;
                                             call("/admin/search_laptop?keyword=" + str, "GET", null, function (response) {
                                                  console.log(response);
                                                  const data = [];
                                                  for (let i = 0; i < response.data.length; i++) {
                                                       data.push(response.data[i].brand.name + ", " + response.data[i].reference);
                                                  }
                                                  autocomplete(str, autoComponent, data, response.data);
                                             }, function (xhr, status, error) {
                                                  console.log(error);
                                             }
                                             );
                                        });
                                   </script>

                              </body>

                              </html>
