// // available_property_details_UI.dart

// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:rentease_kb/models/property_model.dart';
// import 'reservation_form_UI.dart'; // Import the reservation form page

// class AvailablePropertyDetailsUI extends StatelessWidget {
//   final PropertyModel property;

//   AvailablePropertyDetailsUI({required this.property});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Property Details'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Container for images (replace with ImageSlider)
//             Container(
//               height: 200,
//               color: Colors.grey, // Placeholder color
//               child: Center(
//                 child: Text(
//                   'Images Placeholder', // Replace with ImageSlider
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     property.propertyName,
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   Text('Description: ${property.description}'),
//                   SizedBox(height: 8),
//                   Text('Location: ${property.locationAddress}'),
//                   SizedBox(height: 8),
//                   Text('Rent Price: PHP ${property.rentPrice}'),
//                   SizedBox(height: 8),
//                   Text('Minimum Stay: ${property.minStay} months'), // Add this line
//                   // Add more details as needed
//                   SizedBox(height: 30),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           _navigateToReservationForm(context);
//                         },
//                         child: Text('Reserve'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
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
