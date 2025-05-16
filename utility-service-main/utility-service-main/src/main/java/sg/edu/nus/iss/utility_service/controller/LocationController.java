package sg.edu.nus.iss.utility_service.controller;

import com.google.maps.model.LatLng;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sg.edu.nus.iss.utility_service.service.LocationService;

@RestController
@RequestMapping("/location")
@Tag(name = "Location", description = "Get location coordinates via APIs")
public class LocationController {

    @Autowired
    private LocationService locationService;
    Logger logger = LoggerFactory.getLogger(LocationController.class);

    @GetMapping("/coordinates")
    @Operation(summary = "Get coordinates from pincode")
    public ResponseEntity<?> getCoordinates(@RequestParam String pincode) {

        try {
            logger.info("{\"message\": \"Fetching Coordinates for Pincode: " + pincode + "\"}");
            LatLng coordinates = locationService.getCoordinatesFromPincode(pincode);
            return new ResponseEntity<>(coordinates, HttpStatus.OK);
        } catch (Exception e) {
            logger.error("{\"message\": \"Error Fetching Coordinates for Pincode: " + pincode + "\"}");
            return new ResponseEntity<>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}