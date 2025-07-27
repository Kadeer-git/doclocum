import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this file exists
import 'screens/auth/registration_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'screens/profile/profile_setup_screen.dart'; // coming next

MaterialApp(
  ...
  routes: {
    '/otp': (context) => const OTPVerificationScreen(
          mobileNumber: '', role: '',
        ), // placeholder
    '/profile_setup': (context) => const ProfileSetupScreen(), // next screen
  },
)

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocLocum',
      debugShowCheckedModeBanner: false,
      home: const RegistrationScreen(),
    );
  }
}
