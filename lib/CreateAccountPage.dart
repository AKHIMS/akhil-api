// ignore: file_names
// ignore_for_file: unused_import, avoid_print, library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/api_service.dart';
import 'package:flutter_application_1/model/json.dart';
import 'employee.dart';
import 'employee_api.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    try {
      await EmployeeAPI.getEmployees();
      setState(() {});
    } catch (e) {
      print("Error loading employees: $e");
    }
  }

  Future<void> _addEmployee() async {
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    String phone = phoneController.text;
    String place = placeController.text;

    if (name.isNotEmpty && age > 0 && phone.isNotEmpty && place.isNotEmpty) {
      try {
        await EmployeeAPI.addEmployee(Employee(name: name, age: age, phone: phone, place: place));
        setState(() {
          nameController.clear();
          ageController.clear();
          phoneController.clear();
          placeController.clear();
        });
      } catch (e) {
        print("Error adding employee: $e");
      }
    }
  }

  Future<void> _deleteEmployee(Employee employee) async {
    try {
      await EmployeeAPI.deleteEmployee(employee);
      setState(() {});
    } catch (e) {
      print("Error deleting employee: $e");
    }
  }

  void _editEmployee(Employee employee) {
    nameController.text = employee.name;
    ageController.text = employee.age.toString();
    phoneController.text = employee.phone;
    placeController.text = employee.place;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              TextField(
                controller: placeController,
                decoration: InputDecoration(labelText: 'Place'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateEmployee(employee);
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateEmployee(Employee employee) async {
    String name = nameController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    String phone = phoneController.text;
    String place = placeController.text;

    if (name.isNotEmpty && age > 0 && phone.isNotEmpty && place.isNotEmpty) {
      try {
        await EmployeeAPI.updateEmployee(employee, Employee(name: name, age: age, phone: phone, place: place));
        setState(() {
          nameController.clear();
          ageController.clear();
          phoneController.clear();
          placeController.clear();
        });
      } catch (e) {
        print("Error updating employee: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    title: Text('Employee List'),
  ),
  body: Stack(
    children: [
      // Background image
      Positioned.fill(
        child: Image.asset(
          'assets/image3.png', // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover,
        ),
      ),
      // Employee List
      ListView.builder(
        itemCount: EmployeeAPI.employees.length,
        itemBuilder: (context, index) {
          final employee = EmployeeAPI.employees[index];
          return ListTile(
            title: Text(employee.name),
            subtitle: Text('Age: ${employee.age}, Phone: ${employee.phone}, Place: ${employee.place}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editEmployee(employee),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteEmployee(employee),
                ),
              ],
            ),
          );
        },
      ),
    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            
            title: Text('Add Employee'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: 'Phone'),
                ),
                TextField(
                  controller: placeController,
                  decoration: InputDecoration(labelText: 'Place'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _addEmployee();
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
    child: Icon(Icons.add),
  ),
);
  }
}
