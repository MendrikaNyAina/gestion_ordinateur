<%@page contentType="text/html;charset=UTF-8" language="java" %>
     <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
          <%@taglib prefix="h" uri="http://www.front.org/html.tags" %>
               <%@taglib prefix="g" uri="http://www.front.org/page.tags" %>
                    <%@page import="java.util.ArrayList, app.code.model.*" %>
                         <!DOCTYPE html>
                         <html lang="en">
                         <g:Head title="Add lawyer"></g:Head>
                         <body>
                              <div class="auth-wrapper">
                                   <div class="auth-content text-center">
                                        <h:Card classe="borderless">
                                             <h:Row classe="align-items-center">
                                                  <h:Col md="12">
                                                       <h:CardBody>
                                                            <h4 class="mb-3 f-w-400">Inscription</h4>
                                                            <hr>
                                                            <form action="" method="">
                                                                 <h:Input id="username" name="username" placeholder="username"></h:Input>
                                                                 <h:Input id="email" name="email" placeholder="email">
                                                                 </h:Input>
                                                                 <h:Input id="password" name="password" type="password">
                                                                 </h:Input>
                                                                 <h:Button color="primary" class="btn-block mb-4">S'inscrire
                                                                 </h:Button>
                                                                 <hr>
                                                                 <p class="mb-0 text-muted">Possède déjà un compte?
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
                         </body>
                         </html>
