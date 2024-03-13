// // ignore_for_file: prefer_const_constructors, camel_case_types

// import 'package:flutter/material.dart';

// class addingPage extends StatefulWidget {
//   const addingPage({Key? key}) : super(key: key);

//   @override
//   State<addingPage> createState() => _addingPageState();
// }

// class _addingPageState extends State<addingPage> with SingleTickerProviderStateMixin {
//   // Sample data for passengers
//   final List<Map<String, String>> passengers = [
//     {
//       'name': 'John Doe',
//       'state': 'California',
//       'country': 'USA',
//       'address': '123 Main St, Los Angeles',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Passenger Details'),
//       ),
//       body: ListView.builder(
//         itemCount: passengers.length,
//         itemBuilder: (context, index) {
//           final passenger = passengers[index];
//           return ListTile(
//             title: Text(passenger['name']!),
//             subtitle: Column( 
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('State: ${passenger['state']}'),
//                 Text('Country: ${passenger['country']}'),
//                 Text('Address: ${passenger['address']}'),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
          
          
//         },
//         child: Icon(Icons.add_a_photo_outlined),
//       ),
//     );
//   }
// }
