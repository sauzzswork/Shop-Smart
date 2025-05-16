package sg.edu.nus.iss.otp_service.model;


import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document(collection = "otp")  // MongoDB Collection
public class Otp {

    @Id
    private String id;  // Unique identifier for MongoDB
    @Indexed(unique = true)
    private String email;  // Unique email to identify each user
    private String code;  // OTP code
    private LocalDateTime expirationTime;  // Expiration time for the OTP
    private int attemptCount;  // Tracks the number of invalid attempts
    private boolean blocked;  // Blocked status after maximum attempts
    private LocalDateTime blockedUntil;  // Time until which the user is blocked

    // Constructors
    public Otp() {}

    public Otp(String email, String code, LocalDateTime expirationTime) {
        this.email = email;
        this.code = code;
        this.expirationTime = expirationTime;
        this.attemptCount = 0;  // Initialize attempts count to 0
        this.blocked = false;  // Not blocked initially
        this.blockedUntil = null;  // No block time initially
    }

    // Getters and setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public LocalDateTime getExpirationTime() {
        return expirationTime;
    }

    public void setExpirationTime(LocalDateTime expirationTime) {
        this.expirationTime = expirationTime;
    }

    public int getAttemptCount() {
        return attemptCount;
    }

    public void setAttemptCount(int attemptCount) {
        this.attemptCount = attemptCount;
    }

    public boolean isBlocked() {
        return blocked;
    }

    public void setBlocked(boolean blocked) {
        this.blocked = blocked;
    }

    public LocalDateTime getBlockedUntil() {
        return blockedUntil;
    }

    public void setBlockedUntil(LocalDateTime blockedUntil) {
        this.blockedUntil = blockedUntil;
    }

    // Helper methods
    public boolean isExpired() {
        return LocalDateTime.now().isAfter(this.expirationTime);
    }

    public boolean isCurrentlyBlocked() {
        return this.blockedUntil != null && LocalDateTime.now().isBefore(this.blockedUntil);
    }

    public void incrementAttempts() {
        this.attemptCount++;
        if (this.attemptCount >= 3) {
            this.blocked = true;
            this.blockedUntil = LocalDateTime.now().plusMinutes(15);  // Block user for 15 minutes
        }
    }

    public void reset() {
        this.attemptCount = 0;
        this.blocked = false;
        this.blockedUntil = null;
    }
}