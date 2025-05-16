package sg.edu.nus.iss.utility_service.service;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.GeocodingApiRequest;
import com.google.maps.model.GeocodingResult;
import com.google.maps.model.LatLng;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;
import org.springframework.beans.factory.annotation.Value;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

class LocationServiceTest {

    private LocationService locationService;

    @BeforeEach
    void setUp() {
        locationService = new LocationService();
    }

    @Test
    void testGetCoordinatesFromPincodeSuccess() throws Exception {
        // Arrange
        String pincode = "560001";  // Example pincode
        LatLng expectedLatLng = new LatLng(12.9716, 77.5946);  // Mocked coordinates

        // Mock the GeocodingResult
        GeocodingResult mockResult = new GeocodingResult();
        mockResult.geometry = new com.google.maps.model.Geometry();
        mockResult.geometry.location = expectedLatLng;
        GeocodingResult[] mockResults = { mockResult };

        // Mock the GeocodingApiRequest and its method chain
        GeocodingApiRequest mockRequest = mock(GeocodingApiRequest.class);
        when(mockRequest.await()).thenReturn(mockResults);  // Mock await() to return the results

        // Mock the static method call for GeocodingApi to return the mock request
        try (MockedStatic<GeocodingApi> mockedGeocodingApi = mockStatic(GeocodingApi.class)) {
            mockedGeocodingApi.when(() -> GeocodingApi.geocode(any(GeoApiContext.class), eq(pincode)))
                    .thenReturn(mockRequest);

            // Act
            LatLng result = locationService.getCoordinatesFromPincode(pincode);

            // Assert
            assertEquals(expectedLatLng, result);
        }
    }

    @Test
    void testGetCoordinatesFromPincodeNotFound() throws Exception {
        // Arrange
        String pincode = "000000";  // Invalid pincode example

        // Mock an empty result from Geocoding API
        GeocodingResult[] mockResults = new GeocodingResult[0];  // Empty result array

        // Mock the GeocodingApiRequest and its method chain
        GeocodingApiRequest mockRequest = mock(GeocodingApiRequest.class);
        when(mockRequest.await()).thenReturn(mockResults);

        // Mock the static method call for GeocodingApi to return the mock request
        try (MockedStatic<GeocodingApi> mockedGeocodingApi = mockStatic(GeocodingApi.class)) {
            mockedGeocodingApi.when(() -> GeocodingApi.geocode(any(GeoApiContext.class), eq(pincode)))
                    .thenReturn(mockRequest);

            // Act & Assert
            Exception exception = assertThrows(Exception.class, () -> {
                locationService.getCoordinatesFromPincode(pincode);
            });

            assertEquals("Coordinates not found for pincode: 000000", exception.getMessage());
        }
    }

    @Test
    void testGetCoordinatesFromPincodeApiThrowsException() throws Exception {
        // Arrange
        String pincode = "123456";  // Example pincode

        // Mock the GeocodingApiRequest and have it throw an exception
        GeocodingApiRequest mockRequest = mock(GeocodingApiRequest.class);
        when(mockRequest.await()).thenThrow(new RuntimeException("API Error"));

        // Mock the static method call for GeocodingApi to return the mock request
        try (MockedStatic<GeocodingApi> mockedGeocodingApi = mockStatic(GeocodingApi.class)) {
            mockedGeocodingApi.when(() -> GeocodingApi.geocode(any(GeoApiContext.class), eq(pincode)))
                    .thenReturn(mockRequest);

            // Act & Assert
            Exception exception = assertThrows(Exception.class, () -> {
                locationService.getCoordinatesFromPincode(pincode);
            });

            // Check the message of the exception directly, since getCause() is null
            assertEquals("API Error", exception.getMessage());
        }
    }

    @Test
    void testGetCoordinatesFromPincodeWithNull() throws Exception {
        // Act & Assert
        Exception exception = assertThrows(Exception.class, () -> {
            locationService.getCoordinatesFromPincode(null);
        });

        assertEquals("Pincode cannot be null or empty", exception.getMessage());
    }

    @Test
    void testGetCoordinatesFromPincodeWithEmptyString() throws Exception {
        // Arrange
        String pincode = "";  // Empty string pincode

        // Mock an empty result from Geocoding API
        GeocodingResult[] mockResults = new GeocodingResult[0];  // Empty result array

        // Mock the GeocodingApiRequest and its method chain
        GeocodingApiRequest mockRequest = mock(GeocodingApiRequest.class);
        when(mockRequest.await()).thenReturn(mockResults);

        // Mock the static method call for GeocodingApi to return the mock request
        try (MockedStatic<GeocodingApi> mockedGeocodingApi = mockStatic(GeocodingApi.class)) {
            mockedGeocodingApi.when(() -> GeocodingApi.geocode(any(GeoApiContext.class), eq(pincode)))
                    .thenReturn(mockRequest);

            // Act & Assert
            Exception exception = assertThrows(Exception.class, () -> {
                locationService.getCoordinatesFromPincode(pincode);
            });

            assertEquals("Pincode cannot be null or empty", exception.getMessage());
        }
    }
}