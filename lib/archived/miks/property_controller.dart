// property_controller.dart
// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentease_kb/archived/miks/property_model.dart';
import 'package:rentease_kb/models/tenant_model.dart';

class PropertyController {
  final String lessorId;

  PropertyController({required this.lessorId});

  Stream<QuerySnapshot> getAvailablePropertiesStream() {
    return FirebaseFirestore.instance
        .collection('properties')
        .where('tenant', isEqualTo: 'none')
        .snapshots();
  }

  Stream<QuerySnapshot> getPropertyStream() {
    return FirebaseFirestore.instance
        .collection('properties')
        .where('propertyOwner', isEqualTo: lessorId)
        .snapshots();
  }

  Future<void> addProperty({
    required String propertyName,
    required String description,
    required String locationAddress,
    required dynamic rentPrice,
  }) async {
    try {
      CollectionReference properties =
          FirebaseFirestore.instance.collection('properties');

      // Add a new property with a generated document ID
      await properties.add({
        'propertyOwner': lessorId,
        'propertyName': propertyName,
        'description': description,
        'locationAddress': locationAddress,
        'rentPrice': rentPrice,
        'tenant': 'none',
        'propertyID': '',
      }).then((newProperty) async {
        // Update the propertyID field with the document ID
        await newProperty.update({'propertyID': newProperty.id});
      });
    } catch (e) {
      print('Error adding property: $e');
    }
  }

  Future<void> removeProperty(PropertyModel property) async {
    try {
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(property.propertyID)
          .delete();
    } catch (e) {
      print('Error deleting property: $e');
    }
  }

  Future<void> updateProperty({
    required String propertyID,
    required String propertyName,
    required String description,
    required String locationAddress,
    required dynamic rentPrice,
  }) async {
    try {
      CollectionReference properties =
          FirebaseFirestore.instance.collection('properties');

      // Update the property details
      await properties.doc(propertyID).update({
        'propertyName': propertyName,
        'description': description,
        'locationAddress': locationAddress, // Add a null check here
        'rentPrice': rentPrice,
      });
    } catch (e) {
      print('Error updating property: $e');
    }
  }

  List<PropertyModel> mapProperties(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return PropertyModel(
        propertyID: data['propertyID'],
        propertyOwner: data['propertyOwner'],
        propertyName: data['propertyName'],
        description: data['description'],
        locationAddress: data['locationAddress'] ?? '', // Add a null check here
        rentPrice: data['rentPrice'],
        tenant: data['tenant'],
      );
    }).toList();
  }

  Stream<List<TenantModel>> getTenantsStream() {
    return FirebaseFirestore.instance
        .collection('properties')
        .where('propertyOwner', isEqualTo: lessorId)
        .where('tenant', isNotEqualTo: 'none')
        .snapshots()
        .asyncMap((snapshot) async {
      List<TenantModel> tenants = [];
      int tenantCount = 0;

      for (var property in snapshot.docs) {
        var tenantID = property['tenant'];

        if (tenantID != null && tenantID != 'none') {
          var tenantSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('userID', isEqualTo: tenantID)
              .get();

          var tenantData = tenantSnapshot.docs[0].data();

          var roomName = property['propertyName'] ?? 'Unknown Room';
          var phoneNumber = tenantData['phoneNum'] ?? 'No phone number';
          var email = tenantData['email'] ?? 'No email';

          tenants.add(TenantModel(
            userID: tenantData['userID'],
            firstName: tenantData['firstname'],
            lastName: tenantData['lastname'],
            roomName: roomName,
            phoneNumber: phoneNumber,
            email: email,
          ));

          tenantCount++;

          print(tenants.last);
        }
      }

      return tenants;
    });
  }
}
