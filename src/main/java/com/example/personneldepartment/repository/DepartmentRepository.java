package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Class DepartmentRepository is a simple Spring Data Repository
 */

public interface DepartmentRepository extends JpaRepository<Department, Integer> {
}