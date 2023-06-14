package app.code.config;

import java.io.InputStream;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.tuckey.web.filters.urlrewrite.Conf;
import org.tuckey.web.filters.urlrewrite.UrlRewriteFilter;
import org.tuckey.web.filters.urlrewrite.UrlRewriter;

public class CustomUrlRewriter extends UrlRewriteFilter {
     private UrlRewriter urlRewriter;

     @Autowired
     Environment env;

     @Override
     public void loadUrlRewriter(FilterConfig f) throws ServletException {
          try {
               ClassPathResource classPathRessource = new ClassPathResource("urlrewrite.xml");
               System.out.println(classPathRessource.getPath());
               InputStream input = classPathRessource.getInputStream();
               Conf conf1 = new Conf(f.getServletContext(), input, "urlrewrite.xml", "");
               urlRewriter = new UrlRewriter(conf1);
          } catch (Exception e) {
               e.printStackTrace();
               throw new ServletException(e);
          }
     }

     @Override
     public UrlRewriter getUrlRewriter(ServletRequest req, ServletResponse res, FilterChain chain) {
          return urlRewriter;
     }

     @Override
     public void destroyUrlRewriter() {
          if (urlRewriter != null) {
               urlRewriter.destroy();
          }
     }
}
