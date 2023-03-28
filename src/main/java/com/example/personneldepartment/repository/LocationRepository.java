
package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Location;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Class LocationRepository is simple a Spring Data Repository
 */

public interface LocationRepository extends JpaRepository<Location, Integer> {
}