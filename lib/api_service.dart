// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';
import 'package:flutter_application_1/model/json.dart';

import 'employee.dart';

class EmployeeAPI {
  static List<Employee> employees = [];

  static Future<void> getEmployees() async {
    // Simulating fetching data from the API
    await Future.delayed(Duration(seconds: 1));
    employees = [
      Employee(name: '', age: 30, phone: '', place: ''),
      Employee(name: '', age: 25, phone: '', place: ''),
    ];
  }

  static Future<void> addEmployee(Employee employee) async {
    // Simulating adding data to the API
    await Future.delayed(Duration(seconds: 1));
    employees.add(employee);
  }

  static Future<void> deleteEmployee(Employee employee) async {
    // Simulating deleting data from the API
    await Future.delayed(Duration(seconds: 1));
    employees.remove(employee);
  }

  static Future<void> updateEmployee(Employee oldEmployee, Employee newEmployee) async {
    // Simulating updating data in the API
    await Future.delayed(Duration(seconds: 1));
    final index = employees.indexOf(oldEmployee);
    if (index != -1) {
      employees[index] = newEmployee;
    }
  }
}
