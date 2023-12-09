// // available_property_details_UI.dart

// import 'package:flutter/material.dart';
// import 'package:rentease_kb/archived/miks/property_model.dart';
// import 'package:rentease_kb/archived/miks/reservation_form_UI.dart'; // Import the reservation form page

// class AvailablePropertyDetailsUI extends StatelessWidget {
//   final PropertyModel property;

//   AvailablePropertyDetailsUI({required this.property});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Property Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               property.propertyName,
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text('Description: ${property.description}'),
//             SizedBox(height: 8),
//             Text('Location: ${property.locationAddress}'), // Display locationAddress
//             SizedBox(height: 8),
//             Text('Rent Price: PHP ${property.rentPrice}'),
//             SizedBox(height: 8),
//             // Add more details as needed
//             ElevatedButton(
//               onPressed: () {
//                 _navigateToReservationForm(context);
//               },
//               child: Text('Reserve'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _navigateToReservationForm(BuildContext context) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ReservationFormUI(
//           property: property,
//         ),
//       ),
//     );
//   }
// }
