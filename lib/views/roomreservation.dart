//RESERVATION WITH FIREBASE

// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class RoomRentalForm extends StatefulWidget {
  const RoomRentalForm({Key? key}) : super(key: key);

  @override
  _RoomRentalFormState createState() => _RoomRentalFormState();
}

class _RoomRentalFormState extends State<RoomRentalForm> {
  // Ensure that Firebase is initialized
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  CollectionReference reservation =
      FirebaseFirestore.instance.collection('reservation');
  final _formKey = GlobalKey<FormState>();
  bool _submissionAcknowledged = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _dueDateOption;

  // Controllers for text form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _roomAddressController = TextEditingController();
  final TextEditingController _monthlyRentController = TextEditingController();
  bool _submissionSuccessful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Reservation Form'),
      ),
      body: FutureBuilder(
        // Use the FutureBuilder widget to wait for Firebase initialization
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tenant Information:'),
                      // Text form fields with controllers
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(labelText: 'Phone'),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      SizedBox(height: 20),
                      Text('Rental Property Details:'),
                      TextFormField(
                        controller: _roomAddressController,
                        decoration:
                            InputDecoration(labelText: 'Address of the Room'),
                      ),
                      SizedBox(height: 20),
                      Text('Lease Term:'),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _selectStartDate(context),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 8),
                                Text(
                                    'Start Date: ${_startDate != null ? _formattedDate(_startDate!) : 'Not selected'}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => _selectEndDate(context),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today),
                                SizedBox(width: 8),
                                Text(
                                    'End Date: ${_endDate != null ? _formattedDate(_endDate!) : 'Not selected'}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text('Financial Terms:'),
                      TextFormField(
                        controller: _monthlyRentController,
                        decoration: InputDecoration(labelText: 'Monthly Rent'),
                      ),
                      SizedBox(height: 10),
                      Text('Due Date:'),
                      DropdownButtonFormField<String>(
                        value: _dueDateOption,
                        onChanged: (value) {
                          setState(() {
                            _dueDateOption = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'end_of_month',
                            child: Text('Monthly Due Date'),
                          ),
                          DropdownMenuItem(
                            value: '15th_of_month',
                            child: Text('Semi-Monthly Due Date'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'Select Due Date Option',
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Submission Acknowledgment:'),
                      Checkbox(
                        value: _submissionAcknowledged,
                        onChanged: (value) {
                          setState(() {
                            _submissionAcknowledged = value!;
                          });
                        },
                      ),
                      Text(
                        'By submitting this form, I acknowledge that the information provided is accurate and agree to the terms of the Room Rental Agreement. I understand that the lessor has the discretion to accept or reject this submission.',
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              _submissionAcknowledged &&
                              _startDate != null &&
                              _endDate != null &&
                              _dueDateOption != null) {
                            // Handle form submission (e.g., send data to the backend)
                            _showSubmissionSuccessDialog();
                          } else {
                            _showSubmissionErrorDialog();
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          // If Firebase initialization is not complete, show a loading indicator
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: _startDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  String _formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showSubmissionSuccessDialog() {
    if (!_submissionSuccessful) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submission Successful'),
            content: Text('Your room rental submission has been sent.'),
            actions: [
              TextButton(
                onPressed: () {
                  _submissionSuccessful = true;
                  // Save form data to Firebase
                  _saveFormDataToFirebase();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _showSubmissionErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Submission Error'),
          content: Text('Please complete the form and acknowledge the terms.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to save form data to Firebase
  Future<void> _saveFormDataToFirebase() async {
    try {
      await reservation.add({
        'Name': _nameController.text,
        'Address': _addressController.text,
        'Phone': int.parse(_phoneController.text), // Convert to number
        'Email': _emailController.text,
        'AddressOfTheRoom': _roomAddressController.text,
        'StartDate':
            _startDate != null ? Timestamp.fromDate(_startDate!) : null,
        'EndDate': _endDate != null ? Timestamp.fromDate(_endDate!) : null,
        'MonthlyRent': _monthlyRentController.text,
        'DueDateOption': _dueDateOption,
        // Add other fields as needed
      });
      _showSubmissionSuccessDialog();
    } catch (e) {
      print('Error submitting form data to Firebase: $e');
      _showSubmissionErrorDialog();
    }
  }
}
