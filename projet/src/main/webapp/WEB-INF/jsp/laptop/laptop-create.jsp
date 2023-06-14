<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Ajouter laptop" isSelect2="true" isSweetAlert="true">
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
                                                       <h:CardTitle>Ajouter reference de laptop</h:CardTitle>
                                                       <form action="laptop" method="post" id="form">

                                                            <h:Input label="reference" name="reference" type="text"
                                                                 id="reference" placeholder="reference" />
                                                            <h:Select name="brand_id" label="brand" id="brand_id"
                                                                 searchable="true">
                                                                 <c:if test="${brands!=null}">
                                                                      <c:forEach items="${brands}" var="elt">
                                                                           <option value="${elt.id}">${elt.name}
                                                                           </option>
                                                                      </c:forEach>
                                                                 </c:if>
                                                            </h:Select>
                                                            <h:Input label="ram size " name="ram_size" type="number"
                                                                 id="ram_size" step="1" />
                                                            <h:Input label="rom size " name="rom_size" type="number"
                                                                 id="rom_size" step="1" />
                                                            <h:Select name="rom_type_id" label="rom_type"
                                                                 id="rom_type_id">
                                                                 <c:if test="${romTypes!=null}">
                                                                      <c:forEach items="${romTypes}" var="elt">
                                                                           <option value="${elt.id}">${elt.name}
                                                                           </option>
                                                                      </c:forEach>
                                                                 </c:if>
                                                            </h:Select>
                                                            <h:Select name="screen_type_id" label="screen_type"
                                                                 id="screen_type_id">
                                                                 <c:if test="${screenTypes!=null}">
                                                                      <c:forEach items="${screenTypes}" var="elt">
                                                                           <option value="${elt.id}">${elt.name}
                                                                           </option>
                                                                      </c:forEach>
                                                                 </c:if>
                                                            </h:Select>
                                                            <h:Input label="size screen " name="size_screen"
                                                                 type="number" id="size_screen" step="0.01" />
                                                            <h:Select name="processor_id" label="processor"
                                                                 searchable="true" id="processor_id">
                                                                 <c:if test="${processors!=null}">
                                                                      <c:forEach items="${processors}" var="elt">
                                                                           <option value="${elt.id}">${elt.name}
                                                                           </option>
                                                                      </c:forEach>
                                                                 </c:if>
                                                            </h:Select>
                                                            <h:Input label="price " name="price" type="number"
                                                                 id="price" step="0.01" />

                                                            <h:Input label="purchase price " name="purchase_price" type="number"
                                                                 id="purchase_price" step="0.01" />
                                                            <h:Textarea label="description" name="description"
                                                                 id="description" placeholder="description" />
                                                            <h:Button color="danger" type="submit">Enregistrer
                                                            </h:Button>
                                                       </form>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script src="/assets/js/select2/select2.min.js"></script>
                                   <script src="/assets/js/select2.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/laptop";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const reference = document.getElementById('reference').value;
                                             const ram_size = Number(document.getElementById('ram_size').value);
                                             const screen_type_id = Number(document.getElementById('screen_type_id').value);
                                             const rom_type_id = Number(document.getElementById('rom_type_id').value);
                                             const description = document.getElementById('description').value;
                                             const processor_id = Number(document.getElementById('processor_id').value);
                                             const rom_size = Number(document.getElementById('rom_size').value);
                                             const brand_id = Number(document.getElementById('brand_id').value);
                                             const size_screen = Number(document.getElementById('size_screen').value);
                                             const price = Number(document.getElementById('price').value);
                                             const purchase_price = Number(document.getElementById('purchase_price').value);



                                             const data = {
                                                  "reference": reference,
                                                  "ramSize": ram_size,
                                                  "screenType": { "id": screen_type_id },
                                                  "romType": { "id": rom_type_id },
                                                  "description": description,
                                                  "processor": { "id": processor_id },
                                                  "romSize": rom_size,
                                                  "brand": { "id": brand_id },
                                                  "sizeScreen": size_screen,
                                                  "price": price,
                                                  "purchasePrice": purchase_price,
                                             };
                                             console.log(data);
                                             call(url, "POST", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Insertion reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "/admin/laptops";
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

                                   </script>

                              </body>

                              </html>
