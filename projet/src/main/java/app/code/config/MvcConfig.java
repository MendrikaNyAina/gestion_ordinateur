package app.code.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import app.code.auth.AuthenticationInterceptor;
import app.code.auth.AuthentificationInterceptorPointVente;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

     @Override
     public void addInterceptors(InterceptorRegistry registry) {
          registry.addInterceptor(new AuthenticationInterceptor())
                    .addPathPatterns("/admin/**")
                    .excludePathPatterns("/admin/login");
          registry.addInterceptor(new AuthentificationInterceptorPointVente())
                    .addPathPatterns("/store/**")
                    .excludePathPatterns("/store/login");
     }

}
