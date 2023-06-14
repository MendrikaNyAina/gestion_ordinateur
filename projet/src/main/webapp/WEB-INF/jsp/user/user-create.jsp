<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Ajouter un utilisateur" isSelect2="true" isSweetAlert="true">
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
                                                       <h:CardTitle>Ajouter utilisateur pour point de vente
                                                       </h:CardTitle>
                                                       <form action="users" method="post" id="form">
                                                            <h:Row>
                                                                 <h:Col lg="3" md="3" xs="3">
                                                                      <h:Input label="password" name="password"
                                                                           type="password" id="password"
                                                                           placeholder="password" />
                                                                 </h:Col>
                                                                 <h:Col lg="3" md="3" xs="3">
                                                                      <h:Input label="username" name="username"
                                                                           type="text" id="username"
                                                                           placeholder="username" />
                                                                 </h:Col>

                                                            </h:Row>
                                                            <h:Button color="danger" type="submit">Enregistrer
                                                            </h:Button>
                                                       </form>
                                                  </h:CardBody>
                                             </h:Card>
                                             <br />
                                             <h:Card>
                                                  <h:CardBody>
                                                       <h:CardTitle>Liste des utilisateurs</h:CardTitle>
                                                       <c:choose>
                                                            <c:when test="${not empty users}">

                                                                 <h:Table column="[\" username\",\"password\",\"store\",
                                                                      \"Affecter\", \"Desaffecter\"]"
                                                                      classe="table-bordered">
                                                                      <c:forEach var="elt" items="${users}">
                                                                           <tr>
                                                                                <td>${elt.password}</td>
                                                                                <td>${elt.username}</td>
                                                                                <td>
                                                                                     <c:choose>
                                                                                          <c:when
                                                                                               test="${elt.store!=null}">
                                                                                               <h:Select name="store_id"
                                                                                                    id="store_id"
                                                                                                    classe="store_id">
                                                                                                    <c:if
                                                                                                         test="${stores!=null}">
                                                                                                         <c:forEach
                                                                                                              items="${stores}"
                                                                                                              var="elt2">
                                                                                                              <c:choose>
                                                                                                                   <c:when
                                                                                                                        test="${elt2.id==elt.store.id}">
                                                                                                                        <option
                                                                                                                             value="${elt2.id}"
                                                                                                                             selected>
                                                                                                                             ${elt2.name}
                                                                                                                        </option>
                                                                                                                   </c:when>
                                                                                                                   <c:otherwise>
                                                                                                                        <option
                                                                                                                             value="${elt2.id}">
                                                                                                                             ${elt2.name}
                                                                                                                        </option>
                                                                                                                   </c:otherwise>
                                                                                                              </c:choose>
                                                                                                         </c:forEach>
                                                                                                    </c:if>
                                                                                               </h:Select>
                                                                                          </c:when>
                                                                                          <c:otherwise>
                                                                                               <h:Select name="store_id"
                                                                                                    id="store_id"
                                                                                                    classe="store_id">
                                                                                                    <c:if
                                                                                                         test="${stores!=null}">

                                                                                                         <option
                                                                                                              value="">
                                                                                                              aucun
                                                                                                         </option>
                                                                                                         <c:forEach
                                                                                                              items="${stores}"
                                                                                                              var="elt2">
                                                                                                              <option
                                                                                                                   value="${elt2.id}">
                                                                                                                   ${elt2.name}
                                                                                                              </option>
                                                                                                         </c:forEach>
                                                                                                    </c:if>
                                                                                               </h:Select>
                                                                                          </c:otherwise>
                                                                                     </c:choose>
                                                                                </td>
                                                                                <td>
                                                                                     <input type="hidden" id="user_id"
                                                                                          value="${elt.id}">
                                                                                     <h:Button color="info"
                                                                                          onClick="affecter(this)">
                                                                                          changer
                                                                                     </h:Button>
                                                                                </td>
                                                                                <td>
                                                                                     <input type="hidden" id="user_id"
                                                                                          value="${elt.id}">
                                                                                     <h:Button color="danger"
                                                                                          onClick="desaffecter(${elt.id})">
                                                                                          Desaffecter
                                                                                     </h:Button>
                                                                                </td>
                                                                           </tr>
                                                                      </c:forEach>
                                                                 </h:Table>
                                                                 <h:Pagination nbr="${totalPage}" current="${page}"
                                                                      link="/admin/store/user">
                                                                 </h:Pagination>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <h:Alert color="danger">Aucune donnée de users
                                                                 </h:Alert>
                                                            </c:otherwise>
                                                       </c:choose>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/store/user";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const password = document.getElementById('password').value;
                                             const username = document.getElementById('username').value;


                                             const data = {
                                                  "password": password,
                                                  "username": username,
                                             };
                                             call(url, "POST", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Insertion reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "/admin/store/user";
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
                                        function affecter(e) {
                                             console.log(e.parentNode.childNodes[1].value);
                                             const storeid = Number(e.parentNode.parentNode.childNodes[5].childNodes[1].childNodes[1].value);
                                             const userid = Number(e.parentNode.childNodes[1].value);

                                             const url = "/admin/store/user/" + userid + "/affecter/store/" + storeid
                                             call(url, "PUT", {}, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Affectation reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  //window.location.href = "{{link_list}}";
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
                                        }
                                        function desaffecter(id) {
                                             call("/admin/store/user/" + id + "/desaffecter", "PUT", {}, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'desaffectation reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  //window.location.href = "{{link_list}}";
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
                                   </script>

                              </body>

                              </html>
