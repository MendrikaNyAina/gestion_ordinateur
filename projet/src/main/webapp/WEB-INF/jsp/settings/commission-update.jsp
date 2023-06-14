<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Commission" isSelect2="true" isSweetAlert="true" isDynamicForm="true">
                                   <link rel="stylesheet" href="/assets/css/form-multistep.css">
                                   <link rel="stylesheet" href="/assets/css/my-select2-style.css">
                              </g:Head>

                              <body>
                                   <jsp:include page="../common/nav/navigationSideBar.jsp" />
                                   <jsp:include page="../common/nav/navigationHead.jsp" />

                                   <div class="pcoded-main-container">
                                        <div class="pcoded-content">

                                             <br />
                                             <h:Card>
                                                  <h:CardBody>
                                                       <h:CardTitle>Commissions</h:CardTitle>

                                                       <c:choose>
                                                            <c:when test="${not empty commission}">
                                                                 <button type="button" class="btn btn-primary"
                                                                      onClick="add()">
                                                                      Ajouter ligne</button>
                                                                 <form action="" id="form" method="post">
                                                                      <table class="table table-bordered">
                                                                           <thead>
                                                                                <tr>
                                                                                     <th>Total min</th>
                                                                                     <th>Total Max</th>
                                                                                     <th>Commission</th>
                                                                                     <th></th>
                                                                                </tr>

                                                                           </thead>
                                                                           <tbody id="tableau">
                                                                                <c:forEach var="elt"
                                                                                     items="${commission}">
                                                                                     <tr>
                                                                                          <td>
                                                                                               <h:Input type="number"
                                                                                                    step="0.01"
                                                                                                    id="total_min"
                                                                                                    name="total_min"
                                                                                                    value="${elt.totalMin}" />
                                                                                          </td>
                                                                                          <td>
                                                                                               <h:Input type="number"
                                                                                                    step="0.01"
                                                                                                    id="total_max"
                                                                                                    name="total_max"
                                                                                                    value="${elt.totalMax}" />
                                                                                          </td>
                                                                                          

                                                                                          <td>
                                                                                               <h:Input type="number"
                                                                                                    step="0.01"
                                                                                                    id="commission"
                                                                                                    name="commission"
                                                                                                    min="0" max="1"
                                                                                                    value="${elt.commission}" />

                                                                                          </td>
                                                                                          <td>
                                                                                               <button type="button"
                                                                                                    class="btn btn-danger"
                                                                                                    onClick="remove(this)">
                                                                                                    Remove</button>
                                                                                          </td>
                                                                                     </tr>
                                                                                </c:forEach>
                                                                           </tbody>

                                                                      </table>
                                                                      <h:Button type="submit" color="warning">modifier</h:Button>
                                                                 </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <h:Alert color="danger">Aucune donnée de commission
                                                                 </h:Alert>
                                                            </c:otherwise>
                                                       </c:choose>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/commission/update";
                                        const form = document.querySelector("#form");
                                        $(document).ready(function () {
                                             var dynamicForms = new DynamicForms();
                                             dynamicForms.automaticallySetupForm();

                                        });
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const total_max = Array.from(document.querySelectorAll("#total_max")).map((laptop) => {
                                                  return Number(laptop.value);
                                             });;
                                             const total_min = Array.from(document.querySelectorAll("#total_min")).map((quantity) => {
                                                  return Number(quantity.value);
                                             });
                                             const commission = Array.from(document.querySelectorAll("#commission")).map((quantity) => {
                                                  return Number(quantity.value);
                                             });
                                             var data = [];
                                             for (var i = 0; i < total_max.length; i++) {
                                                  data.push({
                                                       totalMax: total_max[i],
                                                       totalMin: total_min[i],
                                                       commission: commission[i]
                                                  });
                                             }
                                             call(url, "PUT", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Insertion reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "/admin/commission/update";
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
                                        function remove(e) {
                                             e.parentNode.parentNode.remove();
                                        }
                                        function add() {
                                             var table = document.getElementById("tableau");
                                             var row = table.insertRow(-1);
                                             var cell1 = row.insertCell(0);
                                             var cell2 = row.insertCell(1);
                                             var cell3 = row.insertCell(2);
                                             var cell4 = row.insertCell(3);
                                             var cell5 = row.insertCell(4);
                                             cell1.innerHTML = "<input type='number' step='0.01' class='form-control' id='total_min' name='total_min'  />";
                                             cell2.innerHTML = "<input type='number' step='0.01' class='form-control' id='total_max' name='total_max'  />";
                                             cell3.innerHTML = "<input type='number' step='0.01' class='form-control' id='commission' name='commission' min='0' max='1' value='0' />";
                                             cell4.innerHTML = "<button type='button' class='btn btn-danger' onClick='remove(this)'>Remove</button>";
                                        }
                                   </script>

                              </body>

                              </html>
