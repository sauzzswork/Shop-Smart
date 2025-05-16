package sg.edu.nus.iss.otp_service.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class SmtpService {
    Logger logger = LoggerFactory.getLogger(SmtpService.class);

    private final JavaMailSender mailSender;

    @Autowired
    public SmtpService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendOtp(String email, String otp) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            logger.info("Sending OTP to email: " + email);
            message.setTo(email);
            message.setSubject("Your OTP Code");
            message.setText("Your OTP is: " + otp);
            mailSender.send(message);
            logger.info("OTP sent to email: " + email);
        }catch (Exception e){
            logger.error("Error sending OTP to email: " + email);
            throw new RuntimeException("Error sending OTP to email: " + email, e);
        }

    }
}