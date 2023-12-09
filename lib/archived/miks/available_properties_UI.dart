// available_properties_UI.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentease_kb/controllers/property_controller.dart';
import 'package:rentease_kb/models/property_model.dart';
import 'package:rentease_kb/views/available_property_details_UI.dart';

class AvailablePropertiesUI extends StatefulWidget {
  @override
  _AvailablePropertiesUIState createState() => _AvailablePropertiesUIState();
}

class _AvailablePropertiesUIState extends State<AvailablePropertiesUI> {
  late Stream<QuerySnapshot> _availablePropertiesStream;
  late PropertyController _propertyController;
  final String lessorID = 'your_lessor_id_here';

  TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _propertyController = PropertyController(lessorId: lessorID);
    _availablePropertiesStream = _propertyController.getAvailablePropertiesStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Available Properties'),
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by Name or Location',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _updateSearch('');
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  _updateSearch(value);
                },
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _availablePropertiesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  var availableProperties = _propertyController.mapProperties(snapshot.data!)
                      .where((property) =>
                          property.propertyName.toLowerCase().contains(_searchTerm.toLowerCase()) ||
                          property.locationAddress.toLowerCase().contains(_searchTerm.toLowerCase()))
                      .toList();

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: availableProperties.length,
                      itemBuilder: (context, index) {
                        var property = availableProperties[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          child: Card(
                            child: ListTile(
                              title: Text(property.propertyName),
                              subtitle: Text(
                                'Description: ${property.description}\nLocation: ${property.locationAddress}\nRent Price: PHP ${property.rentPrice}',
                              ),
                              onTap: () => _navigateToPropertyDetails(property),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateSearch(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
    });
  }

  void _navigateToPropertyDetails(PropertyModel property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailablePropertyDetailsUI(property: property),
      ),
    );
  }
}
