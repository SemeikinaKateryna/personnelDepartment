package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Position;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Class PositionRepository is simple a Spring Data Repository
 */

public interface PositionRepository extends JpaRepository<Position, Integer> {
}