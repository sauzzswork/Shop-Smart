package sg.edu.nus.iss.utility_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(exclude = {org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration.class})
public class UtilityServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(UtilityServiceApplication.class, args);
	}

}
