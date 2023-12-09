// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:rentease_kb/controllers/reservation_controller.dart';
// import 'package:rentease_kb/archived/miks/property_model.dart';

// class ReservationFormUI extends StatefulWidget {
//   final PropertyModel property;

//   ReservationFormUI({required this.property});

//   @override
//   _ReservationFormUIState createState() => _ReservationFormUIState();
// }

// class _ReservationFormUIState extends State<ReservationFormUI> {
//   late TextEditingController firstNameController;
//   late TextEditingController lastNameController;
//   late DateTime selectedDate;
//   bool agreementChecked = false; // New variable for checkbox
//   final user = FirebaseAuth.instance.currentUser!;

//   @override
//   void initState() {
//     super.initState();
//     firstNameController = TextEditingController();
//     lastNameController = TextEditingController();
//     selectedDate = DateTime.now();
//   }

//   @override
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reservation Form'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Reservation for ${widget.property.propertyName}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 TextButton(
//                   onPressed: () => _selectDate(context),
//                   child: Row(
//                     children: [
//                       Icon(Icons.calendar_today),
//                       SizedBox(width: 8),
//                       Text('Start Date: $selectedDate'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             CheckboxListTile(
//               title: Text(
//                 'I agree to the terms of the lessor regarding the minimum duration of stay.',
//               ),
//               value: agreementChecked,
//               onChanged: (value) {
//                 setState(() {
//                   agreementChecked = value!;
//                 });
//               },
//               controlAffinity:
//                   ListTileControlAffinity.leading, // Move checkbox to the left
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: agreementChecked
//                   ? () => _submitReservationRequest(context)
//                   : null, // Disable button if agreement not checked
//               child: Text('Submit Reservation'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2101),
//     );
//     if (pickedDate != null && pickedDate != selectedDate)
//       setState(() {
//         selectedDate = pickedDate;
//       });
//   }

//   String _formattedDate(DateTime date) {
//     return '${date.day}/${date.month}/${date.year}';
//   }

//   void _submitReservationRequest(BuildContext context) async {
//     // Show a dialog with a message and an 'OK' button
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Wait for the response from the lessor within 24 hours to proceed for payment.',
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Close the dialog
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     // Obtain the necessary data for the reservation request
//     String userID =
//         user.uid; // Replace with your actual way of getting the user ID
//     String firstName = firstNameController.text.trim();
//     String lastName = lastNameController.text.trim();
//     String propertyID = widget.property.propertyID;
//     String propertyName = widget.property.propertyName;
//     String propertyOwner = widget.property.propertyOwner;

//     // Create an instance of ReservationController
//     ReservationController reservationController =
//         ReservationController(lessorId: propertyOwner);

//     // Call the submitReservationRequest method
//     await reservationController.submitReservationRequest(
//       userID: userID,
//       firstName: firstName,
//       lastName: lastName,
//       propertyID: propertyID,
//       propertyName: propertyName,
//       propertyOwner: propertyOwner,
//       startDate: selectedDate,
//     );

//     // You can handle navigation or display a confirmation message here
//     // You may also want to show a confirmation dialog or navigate to a success page
//   }
// }
