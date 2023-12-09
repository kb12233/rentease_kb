// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentease_kb/controllers/reservation_controller.dart';
import 'package:rentease_kb/models/property_model.dart';

class ReservationFormUI extends StatefulWidget {
  final PropertyModel property;

  ReservationFormUI({required this.property});

  @override
  _ReservationFormUIState createState() => _ReservationFormUIState();
}

class _ReservationFormUIState extends State<ReservationFormUI> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late DateTime selectedStartDate;
  late DateTime selectedEndDate;
  bool agreementChecked = false;
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    selectedStartDate = DateTime.now();
    selectedEndDate = selectedStartDate.add(Duration(days: widget.property.minStay * 30));
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reservation for ${widget.property.propertyName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => _selectDate(context, isStartDate: true),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text('Start Date: ${_formattedDate(selectedStartDate)}'),
                ],
              ),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => _selectDate(context, isStartDate: false),
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text('End Date: ${_formattedDate(selectedEndDate)}'),
                ],
              ),
            ),
            SizedBox(height: 16),
            CheckboxListTile(
              title: Text(
                'I agree to the terms of the lessor regarding the minimum duration of stay.',
              ),
              value: agreementChecked,
              onChanged: (value) {
                setState(() {
                  agreementChecked = value!;
                });
              },
              controlAffinity:
                  ListTileControlAffinity.leading, // Move checkbox to the left
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: agreementChecked
                  ? () => _submitReservationRequest(context)
                  : null, // Disable button if agreement not checked
              child: Text('Submit Reservation'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? selectedStartDate : selectedEndDate,
      firstDate: isStartDate ? DateTime.now() : selectedStartDate,
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      if (isStartDate) {
        setState(() {
          selectedStartDate = pickedDate;
          // Calculate end date based on minStay in months
          selectedEndDate = selectedStartDate.add(Duration(
            days: widget.property.minStay * 30,
          ));
        });
      } else {
        // Validate that the selected end date is not less than minStay and current date
        if (pickedDate.isAfter(selectedStartDate) &&
            pickedDate.isAfter(DateTime.now().add(Duration(days: widget.property.minStay * 30)))) {
          setState(() {
            selectedEndDate = pickedDate;
          });
        } else {
          // Show an alert or message indicating the selected end date is invalid
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Invalid End Date'),
                content: Text('End date should be at least ${widget.property.minStay} months after the start date.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  String _formattedDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _submitReservationRequest(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wait for the response from the lessor within 24 hours to proceed for payment.',
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );

    String userID = user.uid;
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String propertyID = widget.property.propertyID;
    String propertyName = widget.property.propertyName;
    String propertyOwner = widget.property.propertyOwner;

    ReservationController reservationController =
        ReservationController(lessorId: propertyOwner);

    await reservationController.submitReservationRequest(
      userID: userID,
      firstName: firstName,
      lastName: lastName,
      propertyID: propertyID,
      propertyName: propertyName,
      propertyOwner: propertyOwner,
      startDate: selectedStartDate,
      endDate: selectedEndDate,
    );
  }
}
