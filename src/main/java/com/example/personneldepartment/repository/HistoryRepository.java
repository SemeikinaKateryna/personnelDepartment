package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Employee;
import com.example.personneldepartment.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface HistoryRepository extends JpaRepository<History, Integer> {
    List<History> findHistoriesByEmployee(Employee employee);

    List<History> findAllByPositionPositionName(String param);

    List<History> findAllByDepartmentDepartmentName(String param);

    List<History> findAllByEmployeeSurname(String param);
}