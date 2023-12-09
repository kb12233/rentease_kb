// property_model.dart


class PropertyModel {
  final dynamic propertyID;
  final String propertyOwner;
  final String propertyName;
  final String description;
  final String locationAddress; // Changed from GeoPoint to String
  final dynamic rentPrice;
  final String? tenant;

  PropertyModel({
    required this.propertyID,
    required this.propertyOwner,
    required this.propertyName,
    required this.description,
    required this.locationAddress,
    required this.rentPrice,
    required this.tenant,
  });
}
