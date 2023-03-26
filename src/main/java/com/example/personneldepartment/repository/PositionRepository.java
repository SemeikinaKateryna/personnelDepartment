package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Position;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PositionRepository extends JpaRepository<Position, Integer> {
}