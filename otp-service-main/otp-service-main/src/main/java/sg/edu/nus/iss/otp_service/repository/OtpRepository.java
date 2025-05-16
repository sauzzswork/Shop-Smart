package sg.edu.nus.iss.otp_service.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import sg.edu.nus.iss.otp_service.model.Otp;


public interface OtpRepository extends MongoRepository<Otp, String> {
    Otp findByEmail(String email);  // Custom query method to find OTP by email
}