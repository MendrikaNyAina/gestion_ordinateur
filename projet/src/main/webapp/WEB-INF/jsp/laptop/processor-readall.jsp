<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Gestion processor" isSelect2="true" isSweetAlert="true">
                                   <link rel="stylesheet" href="/assets/css/form-multistep.css">
                                   <link rel="stylesheet" href="/assets/css/my-select2-style.css">
                              </g:Head>

                              <body>
                                   <jsp:include page="../common/nav/navigationSideBar.jsp" />
                                   <jsp:include page="../common/nav/navigationHead.jsp" />

                                   <div class="pcoded-main-container">
                                        <div class="pcoded-content">
                                             <h:Card>
                                                  <h:CardBody lg="4" md="4" xs="6">
                                                       <h:CardTitle>Ajouter un processeur</h:CardTitle>
                                                       <form action="/admin/processor" method="post">
                                                            <h:Input type="text" name="name" id="name" label="name" />
                                                            <h:Button type="submit" color="primary">Ajouter</h:Button>
                                                       </form>
                                                  </h:CardBody>
                                             </h:Card>
                                             <h:Card>
                                                  <h:CardBody>
                                                       <h:CardTitle>Liste des Processeurs</h:CardTitle>
                                                       <h2 class="card-title">Filtre</h2>
                                                       <form action="/admin/processors" method="get">
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
                                                            <c:when test="${not empty processors}">
                                                                 <h:Table column="[\"
                                                                      marque\",\"modifier\",\"supprimer\"]"
                                                                      classe="table-bordered">
                                                                      <c:forEach var="elt" items="${processors}">
                                                                           <tr>
                                                                                <td>
                                                                                     <h:Input name="nameupdate"
                                                                                          type="text"
                                                                                          id="nameupdate${elt.id}"
                                                                                          value="${elt.name}" />
                                                                                </td>
                                                                                <td>
                                                                                     <h:Button type="button"
                                                                                          onClick="update(${elt.id})"
                                                                                          color="info">Modifier
                                                                                     </h:Button>
                                                                                </td>
                                                                                <td>
                                                                                     <h:Link
                                                                                          href="/admin/processor/delete/${elt.id}"
                                                                                          color="danger">Supprimer
                                                                                     </h:Link>
                                                                                </td>
                                                                           </tr>
                                                                      </c:forEach>
                                                                 </h:Table>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <h:Alert color="danger">Aucune donnée de processeur
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
                                        const url="/admin/processor/update/"
                                        function update(id) {
                                             const name = document.getElementById('nameupdate'+id).value;
                                             const data = {
                                                  "name": name,
                                                  "id":id
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
