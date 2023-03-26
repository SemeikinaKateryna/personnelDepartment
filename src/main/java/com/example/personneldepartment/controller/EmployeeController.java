package com.example.personneldepartment.controller;

import com.example.personneldepartment.entity.Department;
import com.example.personneldepartment.entity.Employee;
import com.example.personneldepartment.entity.History;
import com.example.personneldepartment.entity.Position;
import com.example.personneldepartment.repository.DepartmentRepository;
import com.example.personneldepartment.repository.EmployeeRepository;
import com.example.personneldepartment.repository.HistoryRepository;
import com.example.personneldepartment.repository.PositionRepository;
import com.example.personneldepartment.util.ManagerComparator;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.*;
import java.util.function.Function;

import static java.util.Collections.reverseOrder;
import static java.util.Comparator.comparing;

@Controller
@AllArgsConstructor
public class EmployeeController {
    private EmployeeRepository employeeRepository;
    private DepartmentRepository departmentRepository;
    private HistoryRepository historyRepository;
    private PositionRepository positionRepository;

    @GetMapping("/employees")
    public String employees(Model model) {
        List<Employee> employees = employeeRepository.findAll();
        model.addAttribute("employees", employees);
        return "employees";
    }


    @GetMapping("/employee")
    public String employee(@RequestParam int id, Model model) {
        Optional<Employee> foundEmployee = employeeRepository.findById(id);
        if (foundEmployee.isEmpty()) {
            return "employees";
        }
        List<History> historiesByEmployee = historyRepository.findHistoriesByEmployee(foundEmployee.get());
        model.addAttribute("employee", foundEmployee.get());
        model.addAttribute("histories", historiesByEmployee);
        return "employee";
    }

    @GetMapping("/employees_by_department")
    public String employeesByDepartment(@RequestParam int id, Model model) {
        Optional<Department> foundDepartment = departmentRepository.findById(id);
        if (foundDepartment.isEmpty()) {
            return "departments";
        }
        List<Employee> findedEmployees = employeeRepository.
                findAllByDepartment(foundDepartment.get());
        model.addAttribute("department", foundDepartment.get());
        model.addAttribute("employees", findedEmployees);
        return "employees_by_department";
    }

    @GetMapping("/searchByManSurname")
    public String searchEmployeesByManagerSurname(@RequestParam("param") String param, Model model) {
        List<Employee> foundEmps;
        foundEmps = employeeRepository.findAllByManagerSurnameLikeIgnoreCase(param);
        if (foundEmps.isEmpty()) {
            return "redirect:/employees";
        }
        model.addAttribute("parameter", param);
        model.addAttribute("employees", foundEmps);
        return "found_employees";
    }

    @GetMapping("/searchByCity")
    public String searchEmployeesByCity(@RequestParam("param") String param, Model model) {
        List<Employee> foundEmps;
        foundEmps = employeeRepository.findAllByDepartmentLocationCityLikeIgnoreCase(param);
        if (foundEmps.isEmpty()) {
            return "redirect:/employees";
        }
        model.addAttribute("parameter", param);
        model.addAttribute("employees", foundEmps);
        return "found_employees";
    }

    @GetMapping("/searchByDepartment")
    public String searchEmployeesByDepartment(@RequestParam("param") String param, Model model) {
        List<Employee> foundEmps;
        foundEmps = employeeRepository.findAllByDepartmentDepartmentNameLikeIgnoreCase(param);
        if (foundEmps.isEmpty()) {
            return "redirect:/employees";
        }
        model.addAttribute("parameter", param);
        model.addAttribute("employees", foundEmps);
        return "found_employees";
    }

    @GetMapping("/searchByPosition")
    public String searchEmployeesByPosition(@RequestParam("param") String param, Model model) {
        List<Employee> foundEmps;
        foundEmps = employeeRepository.findAllByPositionPositionNameLikeIgnoreCase(param);
        if (foundEmps.isEmpty()) {
            return "redirect:/employees";
        }
        model.addAttribute("parameter", param);
        model.addAttribute("employees", foundEmps);
        return "found_employees";
    }

    @GetMapping("/add_employee")
    public String addEmployee(Model model) {
        List<Position> positions = positionRepository.findAll();
        List<Department> departments = departmentRepository.findAll();
        List<Employee> employees = employeeRepository.findAll();
        List<Employee> headsOfDepartments = employees.stream()
                .filter(empl -> empl.getPosition().getPositionName().equals("Head of department"))
                .toList();

        List<Employee> deputyDirectors = employeeRepository.
                findAllByPositionPositionNameLikeIgnoreCase("Deputy director");

        List<Employee> directors = employeeRepository.findAllByPositionPositionNameLikeIgnoreCase
                ("Director");

        List<Employee> managers = new ArrayList<>();
        managers.addAll(headsOfDepartments);
        managers.addAll(deputyDirectors);
        managers.addAll(directors);

        model.addAttribute("positions", positions);
        model.addAttribute("departments", departments);
        model.addAttribute("managers", managers);
        return "add_employee";
    }

    @PostMapping("add_employee_finish")
    public String addEmployeeFinish(@RequestParam String empSurname,
                                    @RequestParam String empName,
                                    @RequestParam int empAge,
                                    @RequestParam LocalDate empHireDate,
                                    @RequestParam int empPosition,
                                    @RequestParam int empDepartment,
                                    @RequestParam int empSalary,
                                    @RequestParam String empEmail,
                                    @RequestParam String empPhone,
                                    @RequestParam(required = false) int empManager) {
        Employee newEmp = new Employee();
        newEmp.setSurname(empSurname);
        newEmp.setName(empName);
        newEmp.setAge(empAge);
        newEmp.setHireDate(empHireDate);
        newEmp.setPosition(positionRepository.findById(empPosition).get());
        newEmp.setDepartment(departmentRepository.findById(empDepartment).get());
        newEmp.setSalary(empSalary);
        String concatEmail = empEmail.concat("@gmail.com");
        newEmp.setEmail(concatEmail);
        newEmp.setPhoneNumber(empPhone);
        Optional<Employee> manager = employeeRepository.findById(empManager);
        manager.ifPresent(newEmp::setManager);
        employeeRepository.save(newEmp);
        History history = new History();
        Optional<Employee> employee = employeeRepository.findById(newEmp.getId());
        if (employee.isPresent()) {
            Employee empHis = employee.get();
            history.setEmployee(empHis);
            history.setStartDate(empHis.getHireDate());
            history.setPosition(empHis.getPosition());
            history.setDepartment(empHis.getDepartment());
            historyRepository.save(history);
        }
        return "redirect:/employees";
    }

    @GetMapping("/delete_employee")
    public String deleteEmployee(@RequestParam int id) {
        Optional<Employee> deletedEmployee = employeeRepository.findById(id);
        if (deletedEmployee.isPresent()) {
            List<History> deletedHistory =
                    historyRepository.findHistoriesByEmployee(deletedEmployee.get());
            for (History h : deletedHistory) {
                historyRepository.deleteById(h.getId());
            }
        }
        employeeRepository.deleteById(id);
        return "redirect:/employees";
    }

    @GetMapping("/update_employee")
    public String updateEmployee(@RequestParam int id, Model model) {
        Optional<Employee> foundEmployee = employeeRepository.findById(id);
        if (foundEmployee.isEmpty()) {
            return "employees";
        }
        model.addAttribute("employee", foundEmployee.get());
        List<Position> positions = positionRepository.findAll();
        List<Department> departments = departmentRepository.findAll();
        List<Employee> employees = employeeRepository.findAll();
        List<Employee> headsOfDepartments = employees.stream()
                .filter(empl -> empl.getPosition().getPositionName().equals("Head of department"))
                .toList();

        List<Employee> deputyDirectors = employeeRepository.
                findAllByPositionPositionNameLikeIgnoreCase("Deputy director");

        List<Employee> directors = employeeRepository.findAllByPositionPositionNameLikeIgnoreCase
                ("Director");

        List<Employee> managers = new ArrayList<>();
        managers.addAll(headsOfDepartments);
        managers.addAll(deputyDirectors);
        managers.addAll(directors);

        model.addAttribute("positions", positions);
        model.addAttribute("departments", departments);
        model.addAttribute("managers", managers);
        return "update_employee";
    }

    @PostMapping("/update_employee_finish")
    public String updateEmployeeFinish(@RequestParam int id,
                                       @RequestParam String empSurname,
                                       @RequestParam String empName,
                                       @RequestParam int empAge,
                                       @RequestParam LocalDate empHireDate,
                                       @RequestParam int empPosition,
                                       @RequestParam int empDepartment,
                                       @RequestParam int empSalary,
                                       @RequestParam String empEmail,
                                       @RequestParam String empPhone,
                                       @RequestParam(required = false) int empManager) {
        Optional<Employee> employeeFound = employeeRepository.findById(id);

        if (employeeFound.isEmpty()) {
            return "employees";
        }
        Employee employee = employeeFound.get();
        List<History> historiesFound = historyRepository.findHistoriesByEmployee(employee);
        employee.setSurname(empSurname);
        employee.setName(empName);
        employee.setAge(empAge);
        if (!employee.getHireDate().equals(empHireDate)) {
            employee.setHireDate(empHireDate);
            int minId = 0;
            for (History history : historiesFound) {
                if (history.getId() < minId) {
                    minId = history.getId();
                }
            }
            historiesFound.get(minId).setStartDate(empHireDate);
        }

        Position position = positionRepository.findById(empPosition).get();
        Department department = departmentRepository.findById(empDepartment).get();
        if (!employee.getPosition().getId().equals(empPosition)
                || !employee.getDepartment().getId().equals(empDepartment)) {
            employee.setPosition(position);
            employee.setDepartment(department);
            History history = new History();
            history.setEmployee(employee);
            history.setStartDate(LocalDate.now());
            for (History h : historiesFound) {
                if (h.getEndDate() == null) {
                    h.setEndDate(LocalDate.now());
                }
            }
            history.setPosition(position);
            history.setDepartment(department);
            historyRepository.save(history);
        }
        employee.setSalary(empSalary);
        employee.setEmail(empEmail);
        employee.setPhoneNumber(empPhone);
        Optional<Employee> manager = employeeRepository.findById(empManager);
        if (manager.isPresent()) {
            employee.setManager(manager.get());
        } else {
            employee.setManager(null);
        }
        employeeRepository.save(employee);
        return "redirect:/employees";
    }

    @GetMapping("/sortBySurnameAndName")
    public String sortBySurnameAndName(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(Employee::getSurname)
                .thenComparing(Employee::getName));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortBySurnameAndNameDesc")
    public String sortBySurnameAndNameDesc(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(reverseOrder(Comparator.comparing(Employee::getSurname)
                .thenComparing(Employee::getName)));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByAge")
    public String sortByAge(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(Employee::getAge));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByAgeDesc")
    public String sortByAgeDesc(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(reverseOrder(Comparator.comparing(Employee::getAge)));
        model.addAttribute("employees", all);
        return "employees";
    }
    @GetMapping("/sortByPosition")
    public String sortByPosition(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(a -> a.getPosition().getPositionName()));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByPositionDesc")
    public String sortByPositionDesc(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(reverseOrder(Comparator.comparing(a -> a.getPosition().getPositionName())));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByDepartment")
    public String sortByDepartment(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(a -> a.getDepartment().getDepartmentName()));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByDepartmentDesc")
    public String sortByDepartmentDesc(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(reverseOrder(Comparator.comparing(a -> a.getDepartment().getDepartmentName())));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByManager")
    public String sortByManager(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(new ManagerComparator());
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByManagerDesc")
    public String sortByManagerDesc(Model model) {
        List<Employee> all = employeeRepository.findAll();
        all.sort(new ManagerComparator().reversed());
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByHireDate")
    public String sortByHireDate(Model model){
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(Employee::getHireDate));
        model.addAttribute("employees", all);
        return "employees";
    }

    @GetMapping("/sortByHireDateDesc")
    public String sortByHireDateDesc(Model model){
        List<Employee> all = employeeRepository.findAll();
        all.sort(comparing(Employee::getHireDate).reversed());
        model.addAttribute("employees", all);
        return "employees";
    }

}