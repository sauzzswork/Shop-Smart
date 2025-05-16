package sg.edu.nus.iss.otp_service.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import static org.mockito.Mockito.*;

class SmtpServiceTest {

    @Mock
    private JavaMailSender mailSender;

    @InjectMocks
    private SmtpService smtpService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void sendOtp() {
        String email = "test@example.com";
        String otp = "123456";

        smtpService.sendOtp(email, otp);

        verify(mailSender, times(1)).send(any(SimpleMailMessage.class));
    }
}
