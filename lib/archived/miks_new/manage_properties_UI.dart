// // manage_properties_UI.dart

// // ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, file_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rentease_kb/controllers/property_controller.dart';
// import 'package:rentease_kb/models/property_model.dart';
// import 'package:rentease_kb/views/property_details_UI.dart';

// class ManagePropertiesUI extends StatefulWidget {
//   const ManagePropertiesUI({super.key});

//   @override
//   _ManagePropertiesUIState createState() => _ManagePropertiesUIState();
// }

// class _ManagePropertiesUIState extends State<ManagePropertiesUI> {
//   late Stream<QuerySnapshot> _propertyStream;
//   late PropertyController _propertyController;
//   final user = FirebaseAuth.instance.currentUser!;

//   final TextEditingController _propertyNameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _locationAddressController =
//       TextEditingController();
//   final TextEditingController _rentPriceController = TextEditingController();
//   final TextEditingController _minStayController = TextEditingController(); // Add this line

//   @override
//   void initState() {
//     super.initState();
//     _propertyController = PropertyController(lessorId: user.uid);
//     _propertyStream = _propertyController.getPropertyStream();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _propertyStream,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             var properties = _propertyController.mapProperties(snapshot.data!);

//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView.builder(
//                 itemCount: properties.length,
//                 itemBuilder: (context, index) {
//                   var property = properties[index];

//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 3.0),
//                     child: Card(
//                       elevation: 2,
//                       child: ListTile(
//                         title: Text(property.propertyName),
//                         subtitle: Text('Rent Price: PHP ${property.rentPrice}'),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete),
//                           onPressed: () => _deleteProperty(property),
//                           color: Colors.red,
//                         ),
//                         onTap: () => _navigateToPropertyDetails(property),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddPropertyDialog(context),
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   void _showAddPropertyDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add New Property'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: _propertyNameController,
//                 decoration: InputDecoration(labelText: 'Property Name'),
//               ),
//               TextField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//               ),
//               TextField(
//                 controller: _locationAddressController,
//                 decoration: InputDecoration(labelText: 'Address'),
//               ),
//               TextField(
//                 controller: _rentPriceController,
//                 decoration: InputDecoration(labelText: 'Rent Price'),
//                 keyboardType: TextInputType.number,
//               ),
//               TextField(
//                 controller: _minStayController, // Add this block for Minimum Stay
//                 decoration: InputDecoration(labelText: 'Minimum Stay'),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _propertyController.addProperty(
//                   propertyName: _propertyNameController.text,
//                   description: _descriptionController.text,
//                   locationAddress: _locationAddressController.text,
//                   rentPrice: double.parse(_rentPriceController.text),
//                   minStay: int.parse(_minStayController.text), // Add this line
//                 );

//                 _propertyNameController.clear();
//                 _descriptionController.clear();
//                 _locationAddressController.clear();
//                 _rentPriceController.clear();
//                 _minStayController.clear(); // Add this line

//                 Navigator.pop(context);
//               },
//               child: Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _deleteProperty(PropertyModel property) async {
//     setState(() {
//       _propertyController.removeProperty(property);
//     });

//     await FirebaseFirestore.instance
//         .collection('properties')
//         .doc(property.propertyID)
//         .delete();
//   }

//   void _navigateToPropertyDetails(PropertyModel property) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PropertyDetailsUI(property: property),
//       ),
//     );
//   }
// }

