<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <!DOCTYPE html>
                         <html lang="en">
                         <g:Head title="Login Store" isSweetAlert="true"></g:Head>

                         <body>
                              <div class="auth-wrapper">
                                   <div class="auth-content text-center">
                                        <h:Card classe="borderless">
                                             <h:Row classe="align-items-center">
                                                  <h:Col md="12">
                                                       <h:CardBody>
                                                            <h4 class="mb-3 f-w-400">Login Vendeur point de vente</h4>
                                                            <hr>
                                                            <form action="/store/login" method="post" id="form">
                                                                 <h:Input id="username" name="username" placeholder="username"
                                                                      value="vendeur2">
                                                                 </h:Input>
                                                                 <h:Input id="password" name="password" type="password"
                                                                      value="vendeur2">
                                                                 </h:Input>
                                                                 <h:Button color="primary" classe="btn-block mb-4"
                                                                      type="submit">Login
                                                                 </h:Button>
                                                                 <hr>

                                                            </form>
                                                            <p class="mb-0 text-muted"><a href="/admin/login" class="f-w-400">Connection admin</a></p>
                                                       </h:CardBody>
                                                  </h:Col>
                                             </h:Row>
                                        </h:Card>
                                   </div>
                              </div>
                              <script src="/assets/js/ajaxG.js"></script>
                              <script type="text/javascript">
                                   const url = "/store/login";
                                   const form = document.querySelector("#form");
                                   form.addEventListener("submit", function (e) {
                                        e.preventDefault();

                                        const username = document.querySelector("#username").value;
                                        const password = document.querySelector("#password").value;

                                        const data = {
                                             username: username,
                                             password: password
                                        };
                                        call(url, "POST", data, function (response) {
                                             console.log(response);
                                             Swal.fire({
                                                  title: 'Login reussi',
                                                  icon: 'success',
                                                  confirmButtonText: 'OK'
                                             });
                                             window.location.href = "/store/sales";


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
