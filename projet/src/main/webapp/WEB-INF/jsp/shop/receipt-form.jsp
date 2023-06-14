<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Receiption shop" isSelect2="true" isSweetAlert="true">
                                   <link rel="stylesheet" href="/assets/css/form-multistep.css">
                                   <link rel="stylesheet" href="/assets/css/my-select2-style.css">
                              </g:Head>

                              <body>
                                   <jsp:include page="../common/nav/navigationSideBar.jsp" />
                                   <jsp:include page="../common/nav/navigationHead.jsp" />

                                   <div class="pcoded-main-container">
                                        <div class="pcoded-content">
                                             <h:Card>
                                                  <h:CardBody>
                                                       <h:CardTitle>Liste des Transfert attendu</h:CardTitle>
                                                       <h2 class="card-title">Choisir la date</h2>
                                                       <form action="/store/receipt" method="get">
                                                            <h:Row>
                                                                 <h:Col lg="3" md="3" xs="4">
                                                                      <h:Input name="date" type="date" id="date"
                                                                           value="${date}" />
                                                                 </h:Col>
                                                                 <h:Col lg="3" md="3" xs="4">
                                                                      <h:Button color="primary" type="submit">ok
                                                                      </h:Button>
                                                                 </h:Col>
                                                            </h:Row>
                                                       </form>
                                                       <br />
                                                       <c:choose>
                                                            <c:when test="${not empty transferts}">
                                                                 <form action="/store/receipt" method="post" id="form">
                                                                      <h:Table column="[\" reference\", \"
                                                                           marque\",\"quantite attendu\",\"quantite
                                                                           recu\"]" classe="table-bordered">
                                                                           <c:forEach var="elt" items="${transferts}">
                                                                                <tr>
                                                                                     <input type="hidden" id="laptop_id"
                                                                                          value="${elt.laptop.id}">
                                                                                     <input type="hidden"
                                                                                          id="transfert_id"
                                                                                          value="${elt.id}">

                                                                                     <td>${elt.laptop.reference}</td>
                                                                                     <td>${elt.laptop.brand.name}</td>
                                                                                     <td>${elt.quantity}</td>
                                                                                     <td>
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.receipt != null}">
                                                                                                    <h:Input
                                                                                                         name="quantity"
                                                                                                         type="number"
                                                                                                         id="quantity"
                                                                                                         value="${elt.receipt.quantity}" />
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                    <h:Input
                                                                                                         name="quantity"
                                                                                                         type="number"
                                                                                                         id="quantity" />
                                                                                               </c:otherwise>
                                                                                          </c:choose>
                                                                                     </td>
                                                                                     <td>
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.receipt != null}">
                                                                                                    <h:Input
                                                                                                         name="date_receive"
                                                                                                         type="date"
                                                                                                         id="date_receive"
                                                                                                         value="${elt.receipt.dateReceive}" />
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                    <h:Input
                                                                                                         name="date_receive"
                                                                                                         type="date"
                                                                                                         id="date_receive" />
                                                                                               </c:otherwise>
                                                                                          </c:choose>
                                                                                     </td>
                                                                                </tr>
                                                                           </c:forEach>
                                                                      </h:Table>
                                                                      <h:Button type="submit">Enregistrer</h:Button>
                                                                 </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <h:Alert color="danger">Aucun transfert
                                                                 </h:Alert>
                                                            </c:otherwise>
                                                       </c:choose>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script src="/assets/js/main.js"></script>
                                   <script type="text/javascript">
                                        const url = "/store/receipt";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const laptop_id = Array.from(document.querySelectorAll("#laptop_id")).map((laptop) => {
                                                  return laptop.value;
                                             });;
                                             const quantity = Array.from(document.querySelectorAll("#quantity")).map((quantity) => {
                                                  if (quantity.value == "") {
                                                       return -1;
                                                  }
                                                  return Number(quantity.value);
                                             });
                                             const idtransfert = Array.from(document.querySelectorAll("#transfert_id")).map((quantity) => {
                                                  return Number(quantity.value);
                                             });
                                             const datetransfert = new Date(document.querySelector("#date_receive").value);
                                             var data = [];
                                             for (var i = 0; i < laptop_id.length; i++) {
                                                  if (quantity[i] != -1) {
                                                       data.push({
                                                            laptop: { id: laptop_id[i] },
                                                            quantity: quantity[i],
                                                            dateReceive: datetransfert,
                                                            transfert: { "id": idtransfert[i] }
                                                       });
                                                  }
                                             }
                                             call(url , "post", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Modification reussi',
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
                                             }
                                             );
                                        });
                                   </script>


                              </body>

                              </html>
