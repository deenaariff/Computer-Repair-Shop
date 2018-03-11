package hello;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;

@SpringBootApplication
@RestController
public class Application {

    @RequestMapping("/greeting")
    public String home() {
        return "Welcome to the Kubernetes for Developer Tutorial";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}
