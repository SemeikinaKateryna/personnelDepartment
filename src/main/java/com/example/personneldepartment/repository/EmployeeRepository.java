package com.example.personneldepartment.repository;

import com.example.personneldepartment.entity.Department;
import com.example.personneldepartment.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    List<Employee> findAllByDepartment(Department findedDepartment);

    List<Employee> findAllByManagerSurnameLikeIgnoreCase(String param);

    List<Employee> findAllByDepartmentLocationCityLikeIgnoreCase(String param);

    List<Employee> findAllByDepartmentDepartmentNameLikeIgnoreCase(String param);

    List<Employee> findAllByPositionPositionNameLikeIgnoreCase(String param);

    List<Employee> findAllBySurname(String param);

}