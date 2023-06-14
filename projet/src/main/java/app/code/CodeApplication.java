package app.code;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.google.gson.Gson;

import app.code.config.CustomUrlRewriter;
import app.util.general.search.SearchService;

@SpringBootApplication
public class CodeApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(CodeApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(CodeApplication.class, args);
        System.out.println("App is Working");
    }

    @Bean
    public FilterRegistrationBean tuckey() {
        final FilterRegistrationBean rb = new FilterRegistrationBean();
        rb.setFilter(new CustomUrlRewriter());
        return rb;
    }

    @Bean
    public <R, F> SearchService<R, F> searchService() {
        return new SearchService<R, F>();
    }

    @Bean
    public Gson gson() {
        return new Gson();
    }
}
