<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Modifier un Laptop" isSelect2="true" isSweetAlert="true">
                                   <link rel="stylesheet" href="/assets/css/form-multistep.css">
                                   <link rel="stylesheet" href="/assets/css/my-select2-style.css">
                              </g:Head>

                              <body>
                                   <jsp:include page="../common/nav/navigationSideBar.jsp" />
                                   <jsp:include page="../common/nav/navigationHead.jsp" />

                                   <div class="pcoded-main-container">
                                        <div class="pcoded-content">
                                             <h:Card>
                                                  <h:Row>
                                                       <h:CardBody lg="6" md="6" xs="8">
                                                            <c:choose>
                                                                 <c:when test="${not empty laptop}">
                                                                      <h:CardTitle>Modifier laptop, ${laptop.reference}
                                                                      </h:CardTitle>
                                                                      <form action="laptop/update" method="post"
                                                                           id="form">
                                                                           <input type="hidden" name="id" id="id"
                                                                                value="${laptop.id}" />
                                                                           <h:Input label="reference" name="reference"
                                                                                type="text" id="reference"
                                                                                value="${laptop.reference}"
                                                                                placeholder="reference" />
                                                                           <h:Textarea label="description"
                                                                                name="description" id="description"
                                                                                value="${laptop.description}" />

                                                                           <h:Select name="brand_id" label="brand"
                                                                                id="brand_id" searchable="true">
                                                                                <c:if test="${brands!=null}">
                                                                                     <c:forEach items="${brands}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.id==laptop.brand.id}">
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
                                                                           <h:Input label="size screen "
                                                                                name="size_screen" type="number"
                                                                                id="size_screen"
                                                                                value="${laptop.sizeScreen}"
                                                                                step="0.01" />

                                                                           <h:Input label="ram size " name="ram_size"
                                                                                type="number" id="ram_size"
                                                                                value="${laptop.ramSize}" step="1" />
                                                                           <h:Input label="rom size " name="rom_size"
                                                                                type="number" id="rom_size"
                                                                                value="${laptop.romSize}" step="1" />
                                                                           <h:Select name="screen_type_id"
                                                                                label="screen type" id="screen_type_id">
                                                                                <c:if test="${screenTypes!=null}">
                                                                                     <c:forEach items="${screenTypes}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.id==laptop.screenType.id}">
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
                                                                           <h:Select name="rom_type_id" label="rom_type"
                                                                                id="rom_type_id">
                                                                                <c:if test="${romTypes!=null}">
                                                                                     <c:forEach items="${romTypes}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.id==laptop.romType.id}">
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
                                                                           <h:Select name="processor_id"
                                                                                label="processor" id="processor_id"
                                                                                searchable="true">
                                                                                <c:if test="${processors!=null}">
                                                                                     <c:forEach items="${processors}"
                                                                                          var="elt">
                                                                                          <c:choose>
                                                                                               <c:when
                                                                                                    test="${elt.id==laptop.processor.id}">
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
                                                                           <h:Input label="sale price" name="price"
                                                                                type="number" id="price"
                                                                                value="${laptop.price}" step="0.01" />
                                                                           <h:Input label="purchase price "
                                                                                name="purchase_price" type="number"
                                                                                id="purchase_price" step="0.01" value="${laptop.purchasePrice}" />
                                                                           <h:Button color="danger" type="submit">
                                                                                Modifier
                                                                           </h:Button>
                                                                      </form>
                                                                 </c:when>
                                                                 <c:otherwise>
                                                                      <h:Alert color="danger">Laptop introuvable
                                                                      </h:Alert>
                                                                 </c:otherwise>
                                                            </c:choose>
                                                       </h:CardBody>
                                                       <h:CardBody lg="6" md="6" xs="8">
                                                            <c:if test="${not empty laptop}">
                                                                 <h:CardTitle>Supprimer laptop, ${laptop.reference}
                                                                 </h:CardTitle>
                                                                 <c:choose>
                                                                      <c:when test="${laptop.actif==false}">
                                                                           <h:Alert color="danger">La reference du
                                                                                laptop est
                                                                                actuellement
                                                                                supprimer</h:Alert>

                                                                      </c:when>
                                                                      <c:otherwise>
                                                                           <h:Link
                                                                                href="/admin/laptop/delete/${laptop.id}"
                                                                                color="danger">Suprimer</h:Link>
                                                                      </c:otherwise>
                                                                 </c:choose>
                                                            </c:if>
                                                       </h:CardBody>
                                                  </h:Row>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>

                                   <script src="/assets/js/select2/select2.min.js"></script>
                                   <script src="/assets/js/select2.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/laptop/update/";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const description = document.getElementById('description').value;
                                             const brand_id = Number(document.getElementById('brand_id').value);
                                             const size_screen = Number(document.getElementById('size_screen').value);
                                             const reference = document.getElementById('reference').value;
                                             const ram_size = Number(document.getElementById('ram_size').value);
                                             const screen_type_id = Number(document.getElementById('screen_type_id').value);
                                             const price = Number(document.getElementById('price').value);
                                             const rom_type_id = Number(document.getElementById('rom_type_id').value);
                                             const processor_id = Number(document.getElementById('processor_id').value);
                                             const rom_size = Number(document.getElementById('rom_size').value);
                                             const id = Number(document.getElementById('id').value);
                                             const purchase_price = Number(document.getElementById('purchase_price').value);



                                             const data = {
                                                  "description": description,
                                                  "brand": { "id": brand_id },
                                                  "sizeScreen": size_screen,
                                                  "reference": reference,
                                                  "ramSize": ram_size,
                                                  "screenType": { "id": screen_type_id },
                                                  "price": price,
                                                  "romType": { "id": rom_type_id },
                                                  "processor": { "id": processor_id },
                                                  "romSize": rom_size,
                                                  "id": id,
                                                  "purchasePrice": purchase_price,
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
                                        });

                                   </script>

                              </body>

                              </html>
