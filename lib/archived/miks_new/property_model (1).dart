// property_model.dart

class PropertyModel {
  final dynamic propertyID;
  final String propertyOwner;
  final String propertyName;
  final String description;
  final String locationAddress;
  final dynamic rentPrice;
  final String? tenant;
  final int minStay; // Add this line

  PropertyModel({
    required this.propertyID,
    required this.propertyOwner,
    required this.propertyName,
    required this.description,
    required this.locationAddress,
    required this.rentPrice,
    required this.tenant,
    required this.minStay, // Add this line
  });
}
