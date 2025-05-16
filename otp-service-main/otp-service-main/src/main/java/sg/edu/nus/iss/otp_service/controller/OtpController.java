package sg.edu.nus.iss.otp_service.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sg.edu.nus.iss.otp_service.service.OtpService;

@RestController
@RequestMapping("/otp")
public class OtpController {

    Logger logger = LoggerFactory.getLogger(OtpController.class);

    @Autowired
    private OtpService otpService;

    @PostMapping("/generate")
    public ResponseEntity<String> generateOtp(@RequestParam String email) {

        try {
            logger.info("{\"message\": \"Generating OTP for email: {}\"}", email);
            return ResponseEntity.ok(otpService.generateAndStoreOtp(email));
        }catch (Exception e){
            logger.error("{\"message\": \"Error generating OTP for email: {}\"}", email);
            return ResponseEntity.internalServerError().body("Error generating OTP");
        }

    }

    @PostMapping("/validate")
    public ResponseEntity<String> validateOtp(@RequestParam String email, @RequestParam String otp) {
        try{
            logger.info("{\"message\": \"Validating OTP for email: {}\"}", email);
            return ResponseEntity.ok(otpService.validateOtp(email, otp));
        }catch (Exception e){
            logger.error("{\"message\": \"Error validating OTP for email: {}\"}", email);
            return ResponseEntity.internalServerError().body("Error validating OTP");
        }
    }
}
