package com.example.personneldepartment.controller;

import com.example.personneldepartment.entity.Department;
import com.example.personneldepartment.entity.Employee;
import com.example.personneldepartment.entity.History;
import com.example.personneldepartment.entity.Location;
import com.example.personneldepartment.repository.DepartmentRepository;
import com.example.personneldepartment.repository.EmployeeRepository;
import com.example.personneldepartment.repository.HistoryRepository;
import com.example.personneldepartment.repository.LocationRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

/**
 * Class DepartmentController is designed for department's (and location's) requests
 */

@AllArgsConstructor
@Controller
public class DepartmentController {
    private DepartmentRepository departmentRepository;
    private LocationRepository locationRepository;
    private EmployeeRepository employeeRepository;
    private HistoryRepository historyRepository;

    @GetMapping("/departments")
    public String departments(Model model){
        List<Department> departments = departmentRepository.findAll();
        model.addAttribute("departments", departments);
        return "departments";
    }

    @GetMapping("/department_by_employee")
    public String departmentByEmployee(@RequestParam("id") int id, Model model){
        Optional<Employee> foundEmployee = employeeRepository.findById(id);
        if(foundEmployee.isEmpty()) {
            return "employees";
        }
        Optional<Department> findedDepartment = departmentRepository.
                findById(foundEmployee.get().getDepartment().getId());
        List<History> foundHistory = historyRepository
                .findHistoriesByEmployee(foundEmployee.get());
        List<History> histories = foundHistory.stream().filter(h -> h.getDepartment().equals(findedDepartment.get())).toList();
        LocalDate dateOfBeginWorkInDept;
        if(histories.size() == 1){
            dateOfBeginWorkInDept = histories.get(0).getStartDate();
        }else{
            int minId = 0;
            for (History history : histories) {
                if (history.getId() < minId) {
                    minId = history.getId();
                }
            }
            dateOfBeginWorkInDept = histories.get(minId).getStartDate();
        }
        LocalDate localDate = LocalDate.now();
        Duration duration = Duration.between(localDate.atStartOfDay(), dateOfBeginWorkInDept.atStartOfDay());
        model.addAttribute("employee",foundEmployee.get());
        model.addAttribute("department", findedDepartment.get());
        model.addAttribute("duration",duration.abs());
        return "department_by_employee";
    }

    @GetMapping("/locations")
    public String locations(Model model){
        List<Location> locations = locationRepository.findAll();
        model.addAttribute("locations", locations);
        return "locations";
    }

}
