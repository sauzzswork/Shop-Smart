package sg.edu.nus.iss.shopsmart_backend.controller;

import com.fasterxml.jackson.databind.JsonNode;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sg.edu.nus.iss.shopsmart_backend.model.DataDynamicObject;
import sg.edu.nus.iss.shopsmart_backend.service.RedisService;

import java.util.Map;

import static org.springframework.http.ResponseEntity.ok;

@RestController
@RequestMapping("/redis-api")
@Tag(name = "Redis APIs", description = "Handle Redis API calls to access redis in a generic way.")
public class RedisController {
    private static final Logger log = LoggerFactory.getLogger(RedisController.class);

    private final RedisService redisService;

    @Autowired
    public RedisController(RedisService redisService) {
        this.redisService = redisService;
    }

    @PostMapping("/ddo/{api-key}")
    public ResponseEntity<String> insertDdoDataInRedis(@PathVariable(name = "api-key") String apiKey, @RequestBody DataDynamicObject requestBody) {
        log.info("Inserting DDO data in Redis for API key: {}", apiKey);
        return ok(redisService.insertDdoDataInRedis(apiKey, requestBody));
    }

    @GetMapping("/ddo/{api-key}")
    public ResponseEntity<JsonNode> getDdoDataFromRedis(@PathVariable(name = "api-key") String apiKey) {
        log.info("Fetching DDO data from Redis for API key: {}", apiKey);
        return ok(redisService.getDdoDataFromRedis(apiKey));
    }

    @PostMapping("/hash/{redis-key}")
    public ResponseEntity<String> insertHashEntry(@PathVariable(name = "redis-key") String redisKey, @RequestBody Map<String, String> requestBody) {
        log.info("Inserting hash entry in Redis for key: {}", redisKey);
        String hashKey = requestBody.get("hashKey");
        String value = requestBody.get("value");
        redisService.setHashValue(redisKey, hashKey, value);
        return ok("Success");
    }

    @GetMapping("/hash/{redis-key}/{hash-key}")
    public ResponseEntity<String> getHashEntry(@PathVariable(name = "redis-key") String redisKey, @PathVariable(name = "hash-key") String hashKey) {
        log.info("Fetching hash entry from Redis for key: {} and hash key: {}", redisKey, hashKey);
        return ok(redisService.getHashValue(redisKey, hashKey));
    }

    @GetMapping("/hash/{redis-key}")
    public ResponseEntity<JsonNode> getHashEntries(@PathVariable(name = "redis-key") String redisKey) {
        log.info("Fetching all hash entries from Redis for key: {}", redisKey);
        return ok(redisService.getHashMap(redisKey));
    }


}
