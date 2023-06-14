<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="stock central" isSelect2="true">
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
                                                       <h:CardTitle>Stock du magasin</h:CardTitle>
                                                       <h2 class="card-title">Filtre</h2>
                                                       <form action="/admin/stocks" method="get">
                                                            <h:Row>

                                                                 <c:if test="${v_stock!=null}">

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="keyword" name="keyword"
                                                                                type="text" id="keyword"
                                                                                value="${v_stock.keyword}"
                                                                                placeholder="keyword" />
                                                                      </h:Col>
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:MultiSelect name="brand_id" label="brand"
                                                                                id="brand_id">
                                                                                <c:if test="${brand!=null}">
                                                                                     <c:forEach items="${brand}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${v_stock.brand!=null}">
                                                                                                    <c:forEach
                                                                                                         items="${v_stock.brand}"
                                                                                                         var="elt2">
                                                                                                         <c:choose>
                                                                                                              <c:when
                                                                                                                   test="${elt.id==elt2}">
                                                                                                                   <option
                                                                                                                        value="${elt.id}"
                                                                                                                        selected>
                                                                                                                        ${elt.name}
                                                                                                                   </option>
                                                                                                              </c:when>
                                                                                                              <c:otherwise>
                                                                                                                   <option
                                                                                                                        value="${elt.id}">
                                                                                                                        ${elt.name}
                                                                                                                   </option>
                                                                                                              </c:otherwise>
                                                                                                         </c:choose>
                                                                                                    </c:forEach>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                    <option
                                                                                                         value="${elt.id}">
                                                                                                         ${elt.name}
                                                                                                    </option>
                                                                                               </c:otherwise>
                                                                                          </c:choose>
                                                                                     </c:forEach>
                                                                                </c:if>
                                                                           </h:MultiSelect>
                                                                      </h:Col>
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="price size max"
                                                                                name="priceMax" type="number"
                                                                                id="priceMax"
                                                                                value="${v_stock.priceMax}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="price size min"
                                                                                name="priceMin" type="number"
                                                                                id="price_min"
                                                                                value="${v_stock.priceMin}" step="1" />
                                                                      </h:Col>
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="ram size min" name="ramMin"
                                                                                type="number" id="ramMin"
                                                                                value="${v_stock.ramMin}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="ram size max" name="ramMax"
                                                                                type="number" id="ramMax"
                                                                                value="${v_stock.ramMax}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="rom size min" name="romMin"
                                                                                type="number" id="rom_min"
                                                                                value="${v_stock.romMin}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="rom size max" name="romMax"
                                                                                type="number" id="rom_max"
                                                                                value="${v_stock.romMax}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="screen size min"
                                                                                name="screenSizeMin" type="number"
                                                                                id="screenSize_min"
                                                                                value="${v_stock.screenSizeMin}"
                                                                                step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Input label="screen size max"
                                                                                name="screenSizeMax" type="number"
                                                                                id="screenSize_max"
                                                                                value="${v_stock.romMax}" step="1" />
                                                                      </h:Col>

                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:MultiSelect name="processor_id"
                                                                                label="processor" id="processor_id">
                                                                                <c:if test="${processor!=null}">
                                                                                     <c:forEach items="${processor}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${v_stock.processor!=null}">
                                                                                                    <c:forEach
                                                                                                         items="${v_stock.processor}"
                                                                                                         var="elt2">
                                                                                                         <c:choose>
                                                                                                              <c:when
                                                                                                                   test="${elt.id==elt2}">
                                                                                                                   <option
                                                                                                                        value="${elt.id}"
                                                                                                                        selected>
                                                                                                                        ${elt.name}
                                                                                                                   </option>
                                                                                                              </c:when>
                                                                                                              <c:otherwise>
                                                                                                                   <option
                                                                                                                        value="${elt.id}">
                                                                                                                        ${elt.name}
                                                                                                                   </option>
                                                                                                              </c:otherwise>
                                                                                                         </c:choose>
                                                                                                    </c:forEach>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                    <option
                                                                                                         value="${elt.id}">
                                                                                                         ${elt.name}
                                                                                                    </option>
                                                                                               </c:otherwise>
                                                                                          </c:choose>
                                                                                     </c:forEach>
                                                                                </c:if>
                                                                           </h:MultiSelect>
                                                                      </h:Col>
                                                                      
                                                                      <h:Col lg="3" md="3" xs="4">
                                                                           <h:Select name="romType" label="rom Type"
                                                                                id="romType">
                                                                                <c:if test="${romType!=null}">
                                                                                     <c:forEach items="${romType}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.id==v_stock.romType}">
                                                                                                    <option
                                                                                                         value="${elt.id}"
                                                                                                         selected>
                                                                                                         ${elt.name}
                                                                                                    </option>
                                                                                               </c:when>
                                                                                               <c:otherwise>
                                                                                                    <option
                                                                                                         value="${elt.id}">
                                                                                                         ${elt.name}
                                                                                                    </option>
                                                                                               </c:otherwise>
                                                                                          </c:choose>
                                                                                     </c:forEach>
                                                                                </c:if>
                                                                           </h:Select>
                                                                      </h:Col>
                                                                 </c:if>
                                                            </h:Row>
                                                            <h:Button color="primary" type="submit">Filtrer</h:Button>
                                                       </form>
                                                       <br/>
                                                       <c:choose>
                                                            <c:when test="${not empty stocks}">
                                                                 <h:Table column="[\"
                                                                      reference\",\"marque\",\"quantite\",\"prix
                                                                      \",\"ram\",\"rom
                                                                      \",\"processor\",\"ecran\"]"
                                                                      classe="table-bordered">
                                                                      <c:forEach var="elt" items="${stocks}">
                                                                           <tr>
                                                                                <td>${elt.reference}</td>
                                                                                <td>${elt.brand.name}</td>
                                                                                <td>${elt.quantity}</td>
                                                                                <td>${elt.price}</td>
                                                                                <td>${elt.ramSize} Go</td>
                                                                                <td>${elt.romSize}Go,
                                                                                     ${elt.romType.name}</td>
                                                                                <td>${elt.processor.name}</td>
                                                                                <td>${elt.screenType.name}</td>

                                                                                
                                                                           </tr>
                                                                      </c:forEach>
                                                                 </h:Table>
                                                                 <h:Pagination nbr="${totalPage}" current="${page}"
                                                                      link="/admin/stocks"></h:Pagination>
                                                            </c:when>
                                                            <c:otherwise>
                                                                 <br/>
                                                                 <h:Alert color="danger">Aucune donnée de stock
                                                                 </h:Alert>
                                                            </c:otherwise>
                                                       </c:choose>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/main.js"></script>
                                   <script src="/assets/js/select2/select2.min.js"></script>
                                   <script src="/assets/js/select2.js"></script>
                              </body>

                              </html>
