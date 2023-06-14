<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Add lawyer" isSelect2="true">
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
                                                       <h:CardTitle>Liste des sales</h:CardTitle>
                                                       <h2 class="card-title">Filtre</h2>
                                                       <form action="/store/sales" method="get">
                                                            <h:Row>
                                                                 <c:if test="${filter!=null}">
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="reference" name="reference"
                                                                                type="text" id="reference"
                                                                                value="${filter.reference}"
                                                                                placeholder="reference" />
                                                                      </h:Col>
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="Prix min" name="prix_min"
                                                                                type="number" id="prix_min" step="0.01"
                                                                                value="${filter.priceMin}"
                                                                                placeholder="prix_min" />
                                                                      </h:Col>
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="Prix max" name="prix_max"
                                                                                type="number" id="prix_max" step="0.01"
                                                                                value="${filter.priceMax}"
                                                                                placeholder="prix_max" />
                                                                      </h:Col>
                                                                 </c:if>
                                                            </h:Row>
                                                            <h:Button color="primary" type="submit">Filtrer</h:Button>
                                                       </form>
                                                       <c:choose>
                                                            <c:when test="${not empty sales}">
                                                                 <h:Table column="[\"date\",\"reference
                                                                      \",\"Reference vente\",\"details\",\"quantite\", \"prix_total\"]"
                                                                      classe="table-bordered">
                                                                      <c:forEach var="elt" items="${sales}">
                                                                           <tr>
                                                                                <td>${elt.dateSale}</td>
                                                                                <td>${elt.reference}</td>
                                                                                <td>${elt.client}</td>
                                                                                <td>${elt.laptop.romSize} Go,${elt.laptop.ramSize}Go </td>
                                                                                <td>${elt.quantity}</td>
                                                                                <td>${elt.totalPrice}</td>
                                                                           </tr>
                                                                      </c:forEach>
                                                                 </h:Table>
                                                                 <h:Pagination nbr="${totalPage}" current="${page}" link="/store/sales">
                                                                 </h:Pagination>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <br>
                                                                 <h:Alert color="danger">Aucune donnée de vente</h:Alert>
                                                            </c:otherwise>
                                                       </c:choose>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/main.js"></script>

                              </body>

                              </html>
