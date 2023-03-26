package com.example.personneldepartment.util;

import com.example.personneldepartment.entity.Employee;

import java.util.Comparator;

public class ManagerComparator implements Comparator<Employee> {
      @Override
      public int compare(Employee m1, Employee m2) {
          if(m1.getManager() == null || m2.getManager() == null){
              return 0;
          }
          if (m1.getManager().getSurname().equals(m2.getManager().getSurname())) {
              return m1.getName().compareTo(m2.getName());
          }
          return m1.getManager().getSurname().compareTo(m2.getManager().getSurname());
      }
}
