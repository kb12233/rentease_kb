// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rentease_kb/views/auth_page.dart';
import 'package:rentease_kb/views/available_properties_UI.dart';
import 'package:rentease_kb/views/edit_profile_UI.dart';
import 'package:rentease_kb/views/forgotpassword_page.dart';
import 'package:rentease_kb/views/get_started.dart';
import 'package:rentease_kb/views/home.dart';
import 'package:rentease_kb/views/home_page.dart';
import 'package:rentease_kb/views/login_UI.dart';
import 'package:rentease_kb/views/manage_properties_UI.dart';
import 'package:rentease_kb/views/register_UI.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:rentease_kb/views/reservation_requests_UI.dart';
import 'package:rentease_kb/views/select_user_type.dart';
import 'package:rentease_kb/views/view_properties.dart';
import 'package:rentease_kb/views/view_tenants_UI.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xFF532D29), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      routes: {
        '/auth': (context) => AuthPage(),
        '/home': (context) => HomePage(),
        '/homeui': (context) => HomeUI(),
        '/login': (context) => LoginUI(),
        '/register': (context) => RegisterUI(),
        '/forgotpassword': (context) => ForgotPasswordPage(),
        '/getstarted': (context) => GetStarted(),
        '/selectusertype': (context) => UserType(),
        '/manageproperties': (context) => ManagePropertiesUI(),
        '/reservations': (context) => ReservationRequestsUI(),
        '/availableproperties': (context) => AvailablePropertiesUI(),
        '/viewtenants': (context) => ViewTenantsUI(),
        '/viewproperties': (context) => ViewProperties(),
        '/edit_profile': (context) => EditProfileUI()
        // '/tenant_home':(context) => TenantHomeUI()
      },
    );
  }
}
