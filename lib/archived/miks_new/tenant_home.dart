// //HOME with bottom nav
// // ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, must_be_immutable

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:rentease_kb/models/notification_model.dart';
// import 'package:rentease_kb/views/available_properties_UI.dart';

// // class HomeUI extends StatefulWidget {
// //   const HomeUI({Key? key}) : super(key: key);

// //   @override
// //   _HomeUIState createState() => _HomeUIState();
// // }

// // class _HomeUIState extends State<HomeUI> {
// //   Color navcolor = Color(0xFF532D29);
// //   int _currentIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           "RentEase",
// //           style: TextStyle(
// //             color: navcolor,
// //           ),
// //         ),
// //         elevation: 0,
// //         backgroundColor: Colors.transparent,
// //       ),
// //       drawer: _buildDrawer(),
// //       backgroundColor: Colors.white,
// //       body: _buildBody(),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         items: [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //             backgroundColor: navcolor,
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.payment),
// //             label: 'Payment',
// //             backgroundColor: navcolor,
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.notifications),
// //             label: 'Notifications',
// //             backgroundColor: navcolor,
// //           ),
// //         ],
// //         onTap: (index) {
// //           setState(() {
// //             _currentIndex = index;
// //           });
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildDrawer() {
// //   return Drawer(
// //     child: ListView(
// //       children: [
// //         UserAccountsDrawerHeader(
// //           accountName: Text("Your Name"),
// //           accountEmail: Text("your.email@example.com"),
// //           currentAccountPicture: CircleAvatar(
// //             child: Icon(Icons.person),
// //           ),
// //           decoration: BoxDecoration(
// //             color: navcolor,
// //           ),
// //         ),
// //         ListTile(
// //           title: Text('Edit Profile'),
// //           onTap: () {
// //             // Add your logic for editing profile here
// //             // For example: Navigator.pushNamed(context, '/editprofile');
// //           },
// //         ),
// //         ListTile(
// //           title: Text('Logout'),
// //           onTap: () {
// //             // Add your logic for logging out here
// //             // For example: Navigator.pushNamed(context, '/logout');
// //           },
// //         ),
// //       ],
// //     ),
// //   );
// // }

// //   Widget _buildBody() {
// //     switch (_currentIndex) {
// //       case 0:
// //         return AvailablePropertiesUI();
// //       case 1:
// //         return PaymentScreen();
// //       case 2:
// //         return NotificationScreen();
// //       default:
// //         return Container(); // Placeholder, you can replace it with an appropriate widget
// //     }
// //   }
// // }

// class HomeUI extends StatefulWidget {
//   const HomeUI({Key? key}) : super(key: key);

//   @override
//   _HomeUIState createState() => _HomeUIState();
// }

// class _HomeUIState extends State<HomeUI> {
//   Color navcolor = Color(0xFF532D29);
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "RentEase",
//           style: TextStyle(
//             color: navcolor,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       drawer: _buildDrawer(),
//       backgroundColor: Colors.white,
//       body: _buildBody(),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//             backgroundColor: navcolor,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.payment),
//             label: 'Payment',
//             backgroundColor: navcolor,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notifications',
//             backgroundColor: navcolor,
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }

//   Widget _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text("Your Name"),
//             accountEmail: Text("your.email@example.com"),
//             currentAccountPicture: CircleAvatar(
//               child: Icon(Icons.person),
//             ),
//             decoration: BoxDecoration(
//               color: navcolor,
//             ),
//           ),
//           ListTile(
//             title: Text('Edit Profile'),
//             onTap: () {
//               // Add your logic for editing profile here
//               // For example: Navigator.pushNamed(context, '/editprofile');
//             },
//           ),
//           ListTile(
//             title: Text('Logout'),
//             onTap: () {
//               // Add your logic for logging out here
//               // For example: Navigator.pushNamed(context, '/logout');
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody() {
//     switch (_currentIndex) {
//       case 0:
//         return AvailablePropertiesUI();
//       case 1:
//         return PaymentScreen();
//       case 2:
//         return NotificationScreen();
//       default:
//         return Container(); // Placeholder, you can replace it with an appropriate widget
//     }
//   }
// }

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           //search
//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 border: Border.all(color: Colors.white),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   labelText: '   search here',
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PaymentScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text("Payment Screen"),
//     );
//   }
// }

// // class NotificationScreen extends StatelessWidget {
// //   final String userId = FirebaseAuth.instance.currentUser!.uid;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text('Notifications'),
// //       // ),
// //       body: StreamBuilder<QuerySnapshot>(
// //         stream: FirebaseFirestore.instance
// //             .collection('notifications')
// //             .where('userID', isEqualTo: userId)
// //             .snapshots(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return CircularProgressIndicator();
// //           } else if (snapshot.hasError) {
// //             return Text('Error: ${snapshot.error}');
// //           } else {
// //             var notifications = snapshot.data!.docs.map(
// //               (doc) {
// //                 var data = doc.data() as Map<String, dynamic>;
// //                 return NotificationModel(
// //                   userID: data['userID'],
// //                   message: data['message'],
// //                 );
// //               },
// //             ).toList();

// //             return ListView.builder(
// //               itemCount: notifications.length,
// //               itemBuilder: (context, index) {
// //                 var notification = notifications[index];

// //                 return Card(
// //                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// //                   child: ListTile(
// //                     title: Text(notification.message),
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //     );
// //   }
// // }

// class NotificationScreen extends StatelessWidget {
//   final String userId = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('notifications')
//             .where('userID', isEqualTo: userId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             var notifications = snapshot.data!.docs.map(
//               (doc) {
//                 var data = doc.data() as Map<String, dynamic>;
//                 return NotificationModel(
//                   userID: data['userID'],
//                   message: data['message'],
//                   notificationID: ''
//                 );
//               },
//             ).toList();

//             return ListView.builder(
//               itemCount: notifications.length,
//               itemBuilder: (context, index) {
//                 var notification = notifications[index];

//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     title: Text(notification.message),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
