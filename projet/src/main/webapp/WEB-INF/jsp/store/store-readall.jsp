<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="points de vente" isSelect2="true" isSweetAlert="true">
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
                                                       <h:CardTitle>Liste des Magasin</h:CardTitle>
                                                       <h2 class="card-title">Filtre</h2>
                                                       <form action="/admin/stores" method="get">
                                                            <h:Row>
                                                                 <c:choose>
                                                                      <c:when test="${keyword!=null}">
                                                                           <h:Col lg="3" md="3" xs="4">
                                                                                <h:Input label="keyword" name="keyword"
                                                                                     type="text" id="keyword"
                                                                                     value="${keyword}"
                                                                                     placeholder="keyword" />
                                                                           </h:Col>
                                                                      </c:when>
                                                                      <c:otherwise>
                                                                           <h:Col lg="3" md="3" xs="4">
                                                                                <h:Input label="keyword" name="keyword"
                                                                                     type="text" id="keyword"
                                                                                     placeholder="keyword" />
                                                                           </h:Col>
                                                                      </c:otherwise>
                                                                 </c:choose>
                                                            </h:Row>
                                                            <h:Button color="primary" type="submit">Filtrer</h:Button>
                                                       </form>
                                                       <br/>
                                                       <c:choose>
                                                            <c:when test="${not empty stores}">
                                                                 <h:Table column="[\"
                                                                      nom\",\"adress\",\"contact\",\"email\",\"modifier\",\"supprimer\"]"
                                                                      classe="table-bordered">
                                                                      <c:forEach var="elt" items="${stores}">
                                                                           <tr>
                                                                                <input type="hidden" id="id${elt.id}" name="id" value="${elt.id}">
                                                                                <td>

                                                                                     <h:Input name="name"
                                                                                          type="text"
                                                                                          id="name${elt.id}"
                                                                                          value="${elt.name}" />
                                                                                </td>
                                                                                <td>
                                                                                     <h:Input name="address"
                                                                                          type="text"
                                                                                          id="address${elt.id}"
                                                                                          value="${elt.address}" />
                                                                                </td>
                                                                                <td>
                                                                                     <h:Input name="contact"
                                                                                          type="text"
                                                                                          id="contact${elt.id}"
                                                                                          value="${elt.contact}" />
                                                                                </td>
                                                                                <td>
                                                                                     <h:Input name="address"
                                                                                          type="text"
                                                                                          id="email${elt.id}"
                                                                                          value="${elt.email}" />
                                                                                </td>
                                                                                <td>
                                                                                     <h:Button type="button"
                                                                                          onClick="update(${elt.id})"
                                                                                          color="info">Modifier
                                                                                     </h:Button>
                                                                                </td>
                                                                                <td>
                                                                                     <h:Link
                                                                                          href="/admin/store/delete/${elt.id}"
                                                                                          color="danger">Supprimer
                                                                                     </h:Link>
                                                                                </td>
                                                                           </tr>
                                                                      </c:forEach>
                                                                 </h:Table>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <h:Alert color="danger">Aucune donnée de magasin
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
                                        const url="/admin/store/update/"
                                        function update(id) {
                                             const address = document.getElementById('address'+id).value;
                                             const contact = document.getElementById('contact'+id).value;
                                             const name = document.getElementById('name'+id).value;
                                             const ids = Number(document.getElementById('id'+id).value);
                                             const email = document.getElementById('email'+id).value;


                                             const data = {
                                                  "address": address,
                                                  "contact": contact,
                                                  "name": name,
                                                  "id": ids,
                                                  "email": email,
                                             };
                                             call(url + "id", "PUT", data, function (response) {
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
                                        }
                                   </script>


                              </body>

                              </html>
