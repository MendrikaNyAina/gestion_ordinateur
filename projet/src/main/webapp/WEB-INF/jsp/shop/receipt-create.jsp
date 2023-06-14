<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <!DOCTYPE html>
                    <html lang="en">
                    <g:Head title="Add lawyer" isSelect2="true" isJquery="true" isDynamicForm="true" isSweetAlert="true">
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
                                             <h:CardTitle>Reception des Laptop</h:CardTitle>
                                             <form action="" id="form">
                                                  <h:Input type="date" name="date_receive" id="date_receive"
                                                       label="Date de reception" />
                                                  <h:Row>
                                                       <h:Col lg="4" md="4" xs="6">
                                                            <div class="form-group">
                                                                 <label class="floating-label"
                                                                      for="Email">Laptop</label>
                                                            </div>
                                                       </h:Col>
                                                       <h:Col lg="4" md="4" xs="6">
                                                            <div class="form-group">
                                                                 <label class="floating-label"
                                                                      for="Email">Quantite</label>
                                                            </div>
                                                       </h:Col>
                                                  </h:Row>
                                                  <div data-dynamic-form>
                                                       <div data-dynamic-form-template="multi">
                                                            <h:Row>
                                                                 <h:Col lg="4" md="4" xs="6">
                                                                      <select
                                                                           class="js-example-basic-single form-control"
                                                                           id="laptop_id" aria-describedby="emailHelp"
                                                                           type="text" name="multi[ID][foo]"
                                                                           data-dynamic-form-input-id-template="ID">
                                                                           <c:forEach items="${laptops}" var="l">
                                                                                <option value="${l.id}">${l.reference}
                                                                                </option>
                                                                           </c:forEach>
                                                                      </select>
                                                                 </h:Col>
                                                                 <h:Col lg="4" md="4" xs="6">
                                                                      <input type="number" class="form-control"
                                                                           id="quantity" aria-describedby="emailHelp"
                                                                           type="text" name="multi[ID][foo]"
                                                                           data-dynamic-form-input-id-template="ID">
                                                                 </h:Col>
                                                                 <h:Col lg="4" md="4" xs="6">
                                                                      <button type="button" class="btn btn-primary"
                                                                           data-dynamic-form-add>Add</button>
                                                                      <button type="button" class="btn btn-danger"
                                                                           data-dynamic-form-remove>Remove</button>
                                                                 </h:Col>

                                                            </h:Row>
                                                            <br />
                                                       </div>
                                                  </div>
                                                  <h:Button type="submit" color="warning">Transferer</h:Button>
                                             </form>
                                        </h:CardBody>
                                   </h:Card>
                              </div>
                         </div>
                         <script src="/assets/js/ajaxG.js"></script>
                         <script src="/assets/js/select2/select2.min.js"></script>
                         <script src="/assets/js/select2.js"></script>
                         <script type="text/javascript">
                              $(document).ready(function () {
                                   var dynamicForms = new DynamicForms();
                                   dynamicForms.automaticallySetupForm();
                              });
                              const url = "/store/receipt";
                              const form = document.querySelector("#form");
                              form.addEventListener("submit", function (e) {
                                   e.preventDefault();
                                   const laptop_id = Array.from(document.querySelectorAll("#laptop_id")).map((laptop) => {
                                        return laptop.value;
                                   });;
                                   const quantity = Array.from(document.querySelectorAll("#quantity")).map((quantity) => {
                                        return Number(quantity.value);
                                   });
                                   const datetransfert = new Date(document.querySelector("#date_receive").value);
                                   var data = [];
                                   for (var i = 0; i < laptop_id.length; i++) {
                                        data.push({
                                             laptop: { id: laptop_id[i] },
                                             quantity: quantity[i],
                                             dateReceive: datetransfert,
                                        });
                                   }
                                   console.log(data);
                                   call(url, "POST", data, function (response) {
                                        console.log(response);
                                        Swal.fire({
                                             title: 'Transfert reussi',
                                             icon: 'success',
                                             confirmButtonText: 'OK'
                                        });
                                        //window.location.href = "{{link_list}}";
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
