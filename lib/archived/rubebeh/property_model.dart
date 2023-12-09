// property_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentease_kb/archived/rubebeh/review_model.dart';

class PropertyModel {
  final dynamic propertyID;
  final String propertyOwner;
  final String propertyName;
  final String description;
  final GeoPoint location;
  final dynamic rentPrice;
  final String? tenant; // Added tenant field
   List<ReviewModel>? reviews; //added for reviews

  PropertyModel({
    required this.propertyID,
    required this.propertyOwner,
    required this.propertyName,
    required this.description,
    required this.location,
    required this.rentPrice,
    required this.tenant,
    required this.reviews,
  });
}
