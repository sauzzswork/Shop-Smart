package sg.edu.nus.iss.utility_service.service;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class LocationService {

    @Value("${google.maps.api.key}")
    private String apiKey;

    public LatLng getCoordinatesFromPincode(String pincode) throws Exception {

        if (pincode == null || pincode.trim().isEmpty()) {
            throw new IllegalArgumentException("Pincode cannot be null or empty");
        }

        GeoApiContext context = new GeoApiContext.Builder()
                .apiKey(apiKey)
                .build();

        GeocodingResult[] results = GeocodingApi.geocode(context, pincode).await();

        if (results != null && results.length > 0) {
            return results[0].geometry.location;
        } else {
            throw new Exception("Coordinates not found for pincode: " + pincode);
        }
    }
}
