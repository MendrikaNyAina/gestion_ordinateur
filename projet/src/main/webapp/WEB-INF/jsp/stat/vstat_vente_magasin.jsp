<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <!DOCTYPE html>
                    <html lang="en">
                    <g:Head title="Vente par magasin" isChart="true">
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
                                             <h:CardTitle>Vente par mois</h:CardTitle>
                                             <h3>Choisir une année, mois </h3>
                                             <form action="/admin/stat-vente-mois-magasin" method="get">
                                                  <h:Col md="3" xs="3" lg="3">
                                                       <h:Input type="month" name="year" value="${year}" />
                                                  </h:Col>
                                                  <h:Col md="3" xs="3" lg="3">
                                                       <h:Button type="submit">Choisir</h:Button>
                                                  </h:Col>
                                             </form>
                                             <br>
                                             <div id="chart"></div>
                                             <br>
                                             <h:Link href="/admin/stat-vente-mois-magasin/${year}/pdf">Exporter en pdf
                                             </h:Link>
                                        </h:CardBody>
                                   </h:Card>
                                   <h:Card>
                                        <h:CardBody>
                                             <h:CardTitle>Vente par magasin par mois, tableau</h:CardTitle>
                                             <c:choose>
                                                  <c:when test="${not empty table}">
                                                       <h:Table column="[\"magasin\",\" mois\",\"vente\"]" classe="table-bordered">
                                                            <c:forEach var="elt" items="${table}">
                                                                 <tr>
                                                                      <td>${elt.store}</td>    
                                                                      <td>${elt.year}/${elt.month}</td>
                                                                      <td>${elt.total}</td>
                                                                 </tr>
                                                            </c:forEach>
                                                       </h:Table>
                                                  </c:when>
                                                  <c:otherwise>
                                                       <br />
                                                       <h:Alert color="danger">Aucune donnée de stat
                                                       </h:Alert>
                                                  </c:otherwise>
                                             </c:choose>
                                        </h:CardBody>
                                   </h:Card>
                              </div>
                         </div>
                         <script src="/assets/js/chart/basic-line-chart.js"></script>
                         <script type="text/javascript">
                              $(document).ready(function () {
                                   const data = <%= request.getAttribute("data") %>;
                                   const label =<%= request.getAttribute("label") %>;
                                   makePieChart("chart", data, label);
                              });
                         </script>

                    </body>
