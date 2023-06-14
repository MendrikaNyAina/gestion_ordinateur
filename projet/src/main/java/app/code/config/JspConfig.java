package app.code.config;

import javax.servlet.jsp.JspApplicationContext;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import org.springframework.boot.web.servlet.ServletContextInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
public class JspConfig extends WebMvcConfigurerAdapter {
     @Override
     public void addResourceHandlers(ResourceHandlerRegistry registry) {
          registry.addResourceHandler("/resources/**")
                    .addResourceLocations("/resources/");
          registry.addResourceHandler("/WEB-INF/**")
                    .addResourceLocations("/WEB-INF/");
          registry.addResourceHandler("/META-INF/**")
                    .addResourceLocations("/META-INF/");
     }
}
