// property_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentease_kb/archived/rubebeh/property_model.dart';
import 'package:rentease_kb/models/tenant_model.dart';

class PropertyController {
  final String lessorId;

  PropertyController({required this.lessorId});

  Stream<QuerySnapshot> getAvailablePropertiesStream() {
    return FirebaseFirestore.instance
        .collection('properties')
        .where('tenant',
            isEqualTo: 'none') // Filter properties without a tenant
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
    required double latitude,
    required double longitude,
    required dynamic rentPrice,
  }) async {
    try {
      CollectionReference properties =
          FirebaseFirestore.instance.collection('properties');

      LatLng location = LatLng(latitude, longitude);

      // Add a new property with a generated document ID
      await properties.add({
        'propertyOwner': lessorId,
        'propertyName': propertyName,
        'description': description,
        'location': GeoPoint(location.latitude, location.longitude),
        'rentPrice': rentPrice,
        'tenant': 'none',
        'propertyID': '', // This will be updated after document creation
        'reviews': [],
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
    required double latitude,
    required double longitude,
    required dynamic rentPrice,
  }) async {
    try {
      CollectionReference properties =
          FirebaseFirestore.instance.collection('properties');

      LatLng location = LatLng(latitude, longitude);

      // Update the property details
      await properties.doc(propertyID).update({
        'propertyName': propertyName,
        'description': description,
        'location': GeoPoint(location.latitude, location.longitude),
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
          location: GeoPoint(
            data['location'].latitude,
            data['location'].longitude,
          ),
          rentPrice: data['rentPrice'],
          tenant: data['tenant'],
           reviews: data['reviews'],);
    }).toList();
  }

  Stream<List<TenantModel>> getTenantsStream() {
    print('Getting tenants for lessor: $lessorId');

    return FirebaseFirestore.instance
        .collection('properties')
        .where('propertyOwner', isEqualTo: lessorId)
        .where('tenant', isNotEqualTo: 'none')
        .snapshots()
        .asyncMap((snapshot) async {
          print('Properties with tenants: ${snapshot.docs.length}');

          List<TenantModel> tenants = [];
          int tenantCount = 0;

          for (var property in snapshot.docs) {
            var tenantID = property['tenant'];
            print('Processing property with tenant ID: $tenantID');

            if (tenantID != null && tenantID != 'none') {
              // Fetch tenant details from the 'user' collection
              var tenantSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .where('userID', isEqualTo: tenantID)
                  .get();

              var tenantData = tenantSnapshot.docs[0].data();

              // Fetch room name, phone number, and email from the property
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

  Future<void> addReview({
    required String propertyID,
    required String userId,
    required String userName,
    required String comment,
    required double rating,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('properties')
          .doc(propertyID)
          .update({
        'reviews': FieldValue.arrayUnion([
          {
            'userId': userId,
            'userName': userName,
            'comment': comment,
            'rating': rating,
          }
        ]),
      });
    } catch (e) {
      print('Error adding review: $e');
    }
  }

}
