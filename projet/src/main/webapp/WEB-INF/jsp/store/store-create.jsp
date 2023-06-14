<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                              <!DOCTYPE html>
                              <html lang="en">
                              <g:Head title="Ajouter point de vente" isSelect2="true" isSweetAlert="true">
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
                                                       <h:CardTitle>Ajouter Magasin</h:CardTitle>
                                                       <form action="store" method="post" id="form">
                                                            <h:Input label="name" name="name" type="text" id="name"
                                                                 placeholder="name" />
                                                            <h:Input label="address" name="address" type="text"
                                                                 id="address" placeholder="address" />
                                                            <h:Input label="contact" name="contact" type="text"
                                                                 id="contact" placeholder="contact" />
                                                            <h:Input label="email" name="email" type="text" id="email"
                                                                 placeholder="email" />
                                                            <h:Textarea label="description" name="description"
                                                                 id="description" placeholder="description"
                                                                  />
                                                            <h:Button color="danger" type="submit">Enregistrer
                                                            </h:Button>
                                                       </form>
                                                  </h:CardBody>
                                             </h:Card>
                                        </div>
                                   </div>
                                   <script src="/assets/js/ajaxG.js"></script>
                                   <script type="text/javascript">
                                        const url = "/admin/store";
                                        const form = document.querySelector("#form");
                                        form.addEventListener("submit", function (e) {
                                             e.preventDefault();
                                             const address = document.getElementById('address').value;
                                             const contact = document.getElementById('contact').value;
                                             const name = document.getElementById('name').value;
                                             const description = document.getElementById('description').value;
                                             const email = document.getElementById('email').value;


                                             const data = {
                                                  "address": address,
                                                  "contact": contact,
                                                  "name": name,
                                                  "description": description,
                                                  "email": email,
                                             };
                                             call(url, "POST", data, function (response) {
                                                  console.log(response);
                                                  Swal.fire({
                                                       title: 'Insertion reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "/admin/stores";
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
