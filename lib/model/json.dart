class Employee {
  final String name;
  final int age;
  final String phone;
  final String place;

  Employee({required this.name, required this.age, required this.phone, required this.place});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      place: json['place'],
    );
  }
}
