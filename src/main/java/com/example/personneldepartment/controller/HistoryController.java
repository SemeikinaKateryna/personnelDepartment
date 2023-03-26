package com.example.personneldepartment.controller;

import com.example.personneldepartment.entity.Employee;
import com.example.personneldepartment.entity.History;
import com.example.personneldepartment.repository.EmployeeRepository;
import com.example.personneldepartment.repository.HistoryRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@AllArgsConstructor
@Controller
public class HistoryController {
    private HistoryRepository historyRepository;
    private EmployeeRepository employeeRepository;
    private List<History> foundedHistories;
    @GetMapping("/histories")
    public String histories(Model model){
        List<History> histories = historyRepository.findAll();
        model.addAttribute("histories", histories);
        return "histories";
    }

    @GetMapping("/searchHistory")
    public String searchHistory(@RequestParam String param, Model model){
        if(!searchHistoryByPosition(param)){
            if(!searchHistoryByDepartment(param)){
                if(!searchHistoryBySurname(param)){
                    return "redirect:/histories";
                }
            }
        }
        model.addAttribute("parameter", param);
        model.addAttribute("histories", foundedHistories);
        return "found_histories";
    }

    private boolean searchHistoryByPosition(String param){
        foundedHistories = historyRepository.findAllByPositionPositionName(param);
        return !foundedHistories.isEmpty();
    }
    private boolean searchHistoryByDepartment(String param) {
        foundedHistories = historyRepository.findAllByDepartmentDepartmentName(param);
        return !foundedHistories.isEmpty();
    }
    private boolean searchHistoryBySurname(String param) {
        foundedHistories = historyRepository.findAllByEmployeeSurname(param);
        return !foundedHistories.isEmpty();
    }
}
