// property_details_UI.dart

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:rentease_kb/archived/miks/property_controller.dart';
import 'package:rentease_kb/archived/miks/property_model.dart';

class PropertyDetailsUI extends StatefulWidget {
  final PropertyModel property;

  const PropertyDetailsUI({super.key, required this.property});

  @override
  _PropertyDetailsUIState createState() => _PropertyDetailsUIState();
}

class _PropertyDetailsUIState extends State<PropertyDetailsUI> {
  bool _isEditing = false;

  late TextEditingController _propertyNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationAddressController; // Updated from _latitudeController and _longitudeController
  late TextEditingController _rentPriceController;

  late PropertyController _propertyController;

  @override
  void initState() {
    super.initState();

    _propertyNameController =
        TextEditingController(text: widget.property.propertyName);
    _descriptionController =
        TextEditingController(text: widget.property.description);
    _locationAddressController =
        TextEditingController(text: widget.property.locationAddress);
    _rentPriceController =
        TextEditingController(text: widget.property.rentPrice.toString());
    _propertyController = PropertyController(lessorId: widget.property.propertyOwner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Property Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: _isEditing ? Icon(Icons.visibility) : Icon(Icons.edit),
            onPressed: _toggleEditMode,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetail('Property Name', _propertyNameController),
              _buildDetail('Description', _descriptionController),
              _buildDetail('Location Address', _locationAddressController), // Updated label
              _buildDetail('Rent Price', _rentPriceController),
              SizedBox(height: 20),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        _isEditing
            ? TextField(
                controller: controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
              )
            : Text(
                controller.text,
                style: TextStyle(fontSize: 16),
              ),
        SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSaveButton() {
    return _isEditing
        ? ElevatedButton(
            onPressed: _saveChanges,
            child: Text('Save Changes'),
          )
        : Container();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() async {
    String locationAddress = _locationAddressController.text;
    
    await _propertyController.updateProperty(
      propertyID: widget.property.propertyID,
      propertyName: _propertyNameController.text,
      description: _descriptionController.text,
      locationAddress: locationAddress,
      rentPrice: double.parse(_rentPriceController.text),
    );

    _toggleEditMode();
  }
}
