package sg.edu.nus.iss.otp_service.service;



import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sg.edu.nus.iss.otp_service.model.Otp;
import sg.edu.nus.iss.otp_service.repository.OtpRepository;

import java.security.SecureRandom;
import java.time.LocalDateTime;

@Service
public class OtpService {

    Logger logger = LoggerFactory.getLogger(OtpService.class);

    private final OtpRepository otpRepository;
    private final SmtpService smtpService;

    @Autowired
    public OtpService(OtpRepository otpRepository, SmtpService smtpService) {
        this.otpRepository = otpRepository;
        this.smtpService = smtpService;
    }

    // Method to generate a 6-digit OTP
    public String generateOtp() {
        logger.info("Generating OTP");
        SecureRandom random = new SecureRandom();
        int otp = random.nextInt(999999);
        return String.format("%06d", otp);  // Generate a 6-digit OTP
    }

    // Generate and store OTP for a given email
    public String generateAndStoreOtp(String email) throws Exception {
        // Check if an OTP already exists for the user
        Otp existingOtp = otpRepository.findByEmail(email);
        try{
            if (existingOtp != null) {
                if (existingOtp.isBlocked()) {
                    logger.error("User is blocked from generating OTP");
                    throw new Exception("You are blocked from generating OTP. Please try after 15 minutes.");
                }
                existingOtp.setCode(generateOtp());
                existingOtp.setExpirationTime(LocalDateTime.now().plusMinutes(3));  // Reset expiration time
                existingOtp.setAttemptCount(0);  // Reset attempts
                existingOtp.setBlocked(false);  // Unblock the user if they were blocked
                existingOtp.setBlockedUntil(null);  // Reset blockedUntil time
                otpRepository.save(existingOtp);  // Update the existing entry
                smtpService.sendOtp(email, existingOtp.getCode());  // Send OTP via email
            } else {
                // Create a new OTP entry if it doesn't exist
                Otp newOtp = new Otp(email, generateOtp(), LocalDateTime.now().plusMinutes(3));
                otpRepository.save(newOtp);
                smtpService.sendOtp(email, newOtp.getCode());  // Send OTP via email
            }
            logger.info("OTP sent to email: " + email);
            return "OTP sent to " + email;
        }catch (Exception e){
            logger.error("Error in generateAndStoreOtp", e.getMessage());
            throw e;
        }
    }

    // Validate OTP for the user
    public String validateOtp(String email, String inputOtp) throws Exception {
        Otp storedOtp = otpRepository.findByEmail(email);  // Retrieve OTP from database

        try{
            if (storedOtp == null) {
                logger.error("No OTP found for the provided email.");
                throw new Exception("No OTP found for the provided email.");
            }

            if (storedOtp.isExpired()) {
                logger.error("OTP has expired.");
                //otpRepository.delete(storedOtp);  // Delete expired OTP
                throw new Exception("OTP has expired.");
            }

            if (storedOtp.isBlocked()) {
                logger.error("User is blocked from validating OTP");
                throw new Exception("You are blocked from validating OTP. Please try after 15 minutes.");
            }

            if (storedOtp.getCode().equals(inputOtp)) {
                otpRepository.delete(storedOtp);  // OTP validated, delete entry
                logger.info("OTP validated successfully.");
                return "OTP validated successfully.";
            } else {
                storedOtp.incrementAttempts();  // Increment attempts for invalid OTP
                otpRepository.save(storedOtp);
                logger.error("Invalid OTP. Attempt " + storedOtp.getAttemptCount() + " of 3.");
                throw new Exception("Invalid OTP. Attempt " + storedOtp.getAttemptCount() + " of 3.");
            }
        }catch (Exception e){
            logger.error("Error in validateOtp", e.getMessage());
            throw e;
        }
    }
}