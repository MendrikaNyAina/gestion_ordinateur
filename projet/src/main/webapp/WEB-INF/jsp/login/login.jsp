<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <!DOCTYPE html>
                         <html lang="en">
                         <g:Head title="Add lawyer" isSweetAlert="true"></g:Head>

                         <body>
                              <div class="auth-wrapper">
                                   <div class="auth-content text-center">
                                        <h:Card classe="borderless">
                                             <h:Row classe="align-items-center">
                                                  <h:Col md="12">
                                                       <h:CardBody>
                                                            <h4 class="mb-3 f-w-400">Login</h4>
                                                            <hr>
                                                            <form action="" method="" id="form">
                                                                 <h:Input id="email" name="email" placeholder="email">
                                                                 </h:Input>
                                                                 <h:Input id="password" name="password" type="password">
                                                                 </h:Input>
                                                                 <h:Button color="primary" classe="btn-block mb-4" type="submit">Login
                                                                 </h:Button>
                                                                 <hr>
                                                                 <p class="mb-0 text-muted">pas de compte?
                                                                      <a href="auth-signup.html"
                                                                           class="f-w-400">S'inscrire</a>
                                                                 </p>
                                                            </form>
                                                       </h:CardBody>
                                                  </h:Col>
                                             </h:Row>
                                        </h:Card>
                                   </div>
                              </div>
                              <script src="/assets/js/ajaxG.js"></script>
                              <script type="text/javascript">
                                   const url = "/login";
                                   const form = document.querySelector("#form");
                                   form.addEventListener("submit", function (e) {
                                        e.preventDefault();

                                        const email = document.querySelector("#email").value;
                                        const password = document.querySelector("#password").value;

                                        const data = {
                                             email: email,
                                             password: password
                                        };
                                        ajaxG(url, "POST", data, function (response) {
                                             console.log(response);
                                                  Swal.fire({
                                                       title: 'Login reussi',
                                                       icon: 'success',
                                                       confirmButtonText: 'OK'
                                                  });
                                                  window.location.href = "{{link_list}}";
                                            
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
