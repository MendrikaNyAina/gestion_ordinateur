package app.code.auth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class AuthentificationInterceptorPointVente implements HandlerInterceptor {

     @Override
     public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
               throws Exception {
          HttpSession session = request.getSession();
          if (session.getAttribute("store") == null) {
               response.sendRedirect(request.getContextPath() + "/store/login");
               return false;
          }
          return true;
     }

     @Override
     public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
               ModelAndView modelAndView) throws Exception {
          // Ne rien faire ici
     }

     @Override
     public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
               throws Exception {
          // Ne rien faire ici
     }
}
