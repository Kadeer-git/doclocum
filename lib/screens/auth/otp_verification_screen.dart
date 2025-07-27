import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String mobileNumber;
  final String role; // 'Doctor' or 'Locum'

  const OTPVerificationScreen({
    super.key,
    required this.mobileNumber,
    required this.role,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void verifyOTP() {
    String otp = otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      // TODO: Add real verification logic here
      Navigator.pushNamed(
        context,
        '/profile_setup',
        arguments: {'role': widget.role},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter complete 6-digit OTP")),
      );
    }
  }

  Widget buildOTPField(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: otpControllers[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: AppColors.secondaryText),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Text(
              'OTP sent to ${widget.mobileNumber}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.primaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => buildOTPField(index)),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: verifyOTP,
              child: const Text(
                'Verify',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // TODO: handle resend
              },
              child: const Text(
                "Resend OTP",
                style: TextStyle(color: AppColors.accent1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
