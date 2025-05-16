package sg.edu.nus.iss.utility_service.controller;

import com.google.maps.model.LatLng;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import sg.edu.nus.iss.utility_service.service.LocationService;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

public class LocationControllerTest {

    private MockMvc mockMvc;

    @Mock
    private LocationService locationService;

    @InjectMocks
    private LocationController locationController;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
        mockMvc = MockMvcBuilders.standaloneSetup(locationController).build();
    }

    @Test
    public void testGetCoordinatesSuccess() throws Exception {
        // Mock the LocationService to return a LatLng object
        LatLng mockLatLng = new LatLng(12.9716, 77.5946);  // Example lat/lng values
        when(locationService.getCoordinatesFromPincode(anyString())).thenReturn(mockLatLng);

        // Perform the GET request and check the response
        mockMvc.perform(get("/location/coordinates")
                        .param("pincode", "560001")  // Example pincode
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(content().json("{\"lat\":12.9716,\"lng\":77.5946}"));
    }

    @Test
    public void testGetCoordinatesFailure() throws Exception {
        // Mock the LocationService to throw an exception
        when(locationService.getCoordinatesFromPincode(anyString())).thenThrow(new RuntimeException("Error Fetching Coordinates"));

        // Perform the GET request and expect an error
        mockMvc.perform(get("/location/coordinates")
                        .param("pincode", "999999")  // Example invalid pincode
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isInternalServerError())
                .andExpect(content().string("Error Fetching Coordinates"));
    }
}