package sg.edu.nus.iss.product_service.repository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import sg.edu.nus.iss.product_service.model.Category;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface CategoryRepository extends JpaRepository<Category, UUID> {

    List<Category> findByDeletedFalse();

    Page<Category> findByDeletedFalse(Pageable pageable);

    Optional<Category> findByCategoryIdAndDeletedFalse(UUID id);

    Optional<Category> findByCategoryNameIgnoreCaseAndDeletedFalse(String categoryName);


}
