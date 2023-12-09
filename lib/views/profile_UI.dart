// // profile_ui.dart

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rentease_kb/controllers/profile_controller.dart';
// import 'package:rentease_kb/views/edit_profile_ui.dart';
// import 'package:rentease_kb/views/manage_properties_ui.dart';
// import 'package:rentease_kb/views/notifications_ui.dart';
// import 'package:rentease_kb/views/payment_ui.dart';
// import 'package:rentease_kb/views/rent_history_ui.dart';
// import 'package:rentease_kb/views/reservation_requests_ui.dart';
// import 'package:rentease_kb/views/settings_ui.dart';
// import 'package:rentease_kb/views/view_tenants_ui.dart';

// class ProfileUI extends StatefulWidget {
//   ProfileUI({super.key});

//   @override
//   _ProfileUIState createState() => _ProfileUIState();
// }

// class _ProfileUIState extends State<ProfileUI> {
//   final user = FirebaseAuth.instance.currentUser!;
//   late ProfileController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = ProfileController();
//     _controller.fetchUserData(user.uid);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (_controller.currentUser != null) ...[
//               Text(
//                 'Hello, ${_controller.currentUser!.firstname} ${_controller.currentUser!.lastname}!',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 20),
//               ListTile(
//                 title: Text('Edit Profile'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => EditProfileUI(),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('Notifications'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => NotificationsUI(),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 title: Text('Settings'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SettingsUI(),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               if (_controller.currentUser!.userType == 0) ...{
//                 _buildLessorMenu(),
//               } else {
//                 _buildTenantMenu(),
//               },
//             ] else {
//               // Handle the case where _currentUser is null
//               Container(),
//             },
//                 child: CircularProgressIndicator(),
//               ),
//             },
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConditionalMenu() {
//     if (_controller.currentUser.userType == 0) {
//       // Lessor
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             title: Text('Manage Properties'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ManagePropertiesUI(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Manage Reservation Requests'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ReservationRequestsUI(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('View Tenants'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ViewTenantsUI(),
//                 ),
//               );
//             },
//           ),
//         ],
//       );
//     } else {
//       // Tenant
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           ListTile(
//             title: Text('Payment'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PaymentUI(),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             title: Text('Rent History'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => RentHistoryUI(),
//                 ),
//               );
//             },
//           ),
//         ],
//       );
//     }
//   }
// }
