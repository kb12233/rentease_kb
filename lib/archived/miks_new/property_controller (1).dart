// // property_controller.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:rentease_kb/models/property_model.dart';
// import 'package:rentease_kb/models/tenant_model.dart';

// class PropertyController {
//   final String lessorId;

//   PropertyController({required this.lessorId});

//   Stream<QuerySnapshot> getAvailablePropertiesStream() {
//     return FirebaseFirestore.instance
//         .collection('properties')
//         .where('tenant', isEqualTo: 'none')
//         .orderBy('propertyName', descending: false)
//         .snapshots();
//   }

//   Stream<QuerySnapshot> getPropertyStream() {
//     return FirebaseFirestore.instance
//         .collection('properties')
//         .where('propertyOwner', isEqualTo: lessorId)
//         .orderBy('propertyName', descending: false)
//         .snapshots();
//   }

//   Future<void> addProperty({
//     required String propertyName,
//     required String description,
//     required String locationAddress,
//     required dynamic rentPrice,
//     required int minStay, // Add this line
//   }) async {
//     try {
//       CollectionReference properties =
//           FirebaseFirestore.instance.collection('properties');

//       await properties.add({
//         'propertyOwner': lessorId,
//         'propertyName': propertyName,
//         'description': description,
//         'locationAddress': locationAddress,
//         'rentPrice': rentPrice,
//         'tenant': 'none',
//         'propertyID': '',
//         'minStay': minStay, // Add this line
//       }).then((newProperty) async {
//         await newProperty.update({'propertyID': newProperty.id});
//       });
//     } catch (e) {
//       print('Error adding property: $e');
//     }
//   }

//   Future<void> removeProperty(PropertyModel property) async {
//     try {
//       await FirebaseFirestore.instance
//           .collection('properties')
//           .doc(property.propertyID)
//           .delete();
//     } catch (e) {
//       print('Error deleting property: $e');
//     }
//   }

//   Future<void> updateProperty({
//     required String propertyID,
//     required String propertyName,
//     required String description,
//     required String locationAddress,
//     required dynamic rentPrice,
//   }) async {
//     try {
//       CollectionReference properties =
//           FirebaseFirestore.instance.collection('properties');

//       // Update the property details
//       await properties.doc(propertyID).update({
//         'propertyName': propertyName,
//         'description': description,
//         'locationAddress': locationAddress, // Add a null check here
//         'rentPrice': rentPrice,
//       });
//     } catch (e) {
//       print('Error updating property: $e');
//     }
//   }

//   List<PropertyModel> mapProperties(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc) {
//       var data = doc.data() as Map<String, dynamic>;
//       return PropertyModel(
//           propertyID: data['propertyID'],
//           propertyOwner: data['propertyOwner'],
//           propertyName: data['propertyName'],
//           description: data['description'],
//           locationAddress: data['locationAddress'] ?? '',
//           rentPrice: data['rentPrice'],
//           tenant: data['tenant'],
//           minStay: data['minStay'] ?? 0, // Add this line
//       );
//     }).toList();
//   }

//   Stream<List<TenantModel>> getTenantsStream() {
//     return FirebaseFirestore.instance
//         .collection('properties')
//         .where('propertyOwner', isEqualTo: lessorId)
//         .where('tenant', isNotEqualTo: 'none')
//         .snapshots()
//         .asyncMap((snapshot) async {
//           List<TenantModel> tenants = [];

//           for (var property in snapshot.docs) {
//             var tenantID = property['tenant'];

//             if (tenantID != null && tenantID != 'none') {
//               // Fetch tenant details from the 'user' collection
//               var tenantSnapshot = await FirebaseFirestore.instance
//                   .collection('users')
//                   .where('userID', isEqualTo: tenantID)
//                   .get();

//               var tenantData = tenantSnapshot.docs[0].data();

//               // Fetch room name, phone number, and email from the property
//               var roomName = property['propertyName'] ?? 'Unknown Room';
//               var phoneNumber = tenantData['phoneNum'] ?? 'No phone number';
//               var email = tenantData['email'] ?? 'No email';

//               tenants.add(TenantModel(
//                 userID: tenantData['userID'],
//                 firstName: tenantData['firstname'],
//                 lastName: tenantData['lastname'],
//                 roomName: roomName,
//                 phoneNumber: phoneNumber,
//                 email: email,
//               ));
//             }
//           }

//           return tenants;
//         });
//   }
// }
