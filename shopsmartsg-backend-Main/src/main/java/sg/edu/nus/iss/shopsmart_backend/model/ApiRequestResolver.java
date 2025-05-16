package sg.edu.nus.iss.shopsmart_backend.model;

import com.fasterxml.jackson.databind.JsonNode;
import lombok.Data;

import java.util.Map;

@Data
public class ApiRequestResolver {
    private String sessionId;
    private String correlationId;
    private String ipAddress;
    private String apiKey;
    private String additionalUriData;
    private String requestUri;
    private Map<String, String> headers;
    private Map<String, String> queryParams;
    private Map<String, String> cookies;
    private Map<String, String> sessionAttributes;
    private JsonNode requestBody;
    private String loggerString;
    private Map<String, String> jwtClaims;
    private String userId;
    private String jwtToken;
    private boolean isLoggedIn;
}
