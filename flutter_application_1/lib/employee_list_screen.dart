// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/compontes/drop_down.dart';
import 'package:flutter_application_1/compontes/textfiled.dart';
import 'package:flutter_application_1/employee.dart';
import 'package:flutter_application_1/model/employee.dart';
import 'package:flutter_application_1/model/employee_api.dart';
import 'package:image_picker/image_picker.dart';

class UpdateEmployee extends StatefulWidget {
  final DataModel employee;

  const UpdateEmployee({Key? key, required this.employee}) : super(key: key);

  @override
  State<UpdateEmployee> createState() => _UpdateEmployeeState();
}

class _UpdateEmployeeState extends State<UpdateEmployee> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  String? dropdownValue;
  File? _image;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with employee data
    nameController.text = widget.employee.name;
    emailController.text = widget.employee.email;
    designationController.text = widget.employee.designation;
    addressController.text = widget.employee.address;
    phoneNumberController.text = widget.employee.phoneNumber;
    dropdownValue = widget.employee.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Update Employee Profile",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black, size: 30),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: const Text('Select Image'),
                ),
                _image != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _image!,
                          width: 150.0,
                          height: 150.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                ElevatedButton(
                  onPressed: _clearSelectedImage,
                  child: const Text('Clear Image'),
                ),
                MyTextField(
                  hintText: 'Name',
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  obscureText: false,
                ),
                MyTextField(
                    hintText: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false),
                MyDropdownField(
                  items: ["Male", "Female", "Other"],
                  hintText: "Gender",
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                ),
                MyTextField(
                    hintText: 'Designation',
                    controller: designationController,
                    keyboardType: TextInputType.text,
                    obscureText: false),
                MyTextField(
                    hintText: 'Address',
                    controller: addressController,
                    keyboardType: TextInputType.streetAddress,
                    obscureText: false),
                MyTextField(
                    hintText: 'Phone Number',
                    controller: phoneNumberController,
                    keyboardType: TextInputType.number,
                    obscureText: false),
                ElevatedButton(
                  onPressed: () {
                    _updateEmployee(); // Call _updateEmployee function here
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  },
                  child: Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearSelectedImage() {
    setState(() {
      _image = null;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> _updateEmployee() async {
    String? updatedImageUrl;

    if (_image != null) {
      updatedImageUrl = _image!.path;
    } else {
      updatedImageUrl = widget.employee.imageUrl;
    }

    DataModel updatedEmployee = DataModel(
      id: widget.employee.id,
      name: nameController.text,
      email: emailController.text,
      designation: designationController.text,
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      gender: dropdownValue ?? '',
      imageUrl: updatedImageUrl,
    );

    try {
      await _apiService.updateEmployee(widget.employee.id!, updatedEmployee);

      _showSuccessMessage();
    } catch (e) {
      _showErrorMessage("Failed to update employee: $e");
    }
  }

  void _showSuccessMessage() {
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text('Employee information updated successfully.'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.green,
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }

  void _showErrorMessage(String message) {
    _scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
