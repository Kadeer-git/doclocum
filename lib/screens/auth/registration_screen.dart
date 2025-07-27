import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'otp_verification_screen.dart'; // Make sure this file exists

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedRole;
  bool isPasswordVisible = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.alternate],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.tertiary,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    'DocLocum',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryText,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Welcome Back !!',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          TabBar(
            controller: _tabController,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primaryText,
            tabs: const [
              Tab(text: 'Login'),
              Tab(text: 'Register'),
            ],
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Login Tab
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      _buildPasswordField(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("✅ Login Successful (Mock)"),
                              ),
                            );
                            // TODO: Navigate to dashboard or role-based screen
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("❗ Email and password required"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.secondary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 14,
                          ),
                        ),
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Register Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: nameController,
                        label: 'Full Name',
                      ),
                      _buildTextField(
                        controller: mobileController,
                        label: 'Mobile Number',
                        keyboard: TextInputType.phone,
                      ),
                      _buildTextField(
                        controller: emailController,
                        label: 'Email',
                      ),
                      _buildPasswordField(),
                      _buildDropdown(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 14,
                          ),
                        ),
                        onPressed: () {
                          if (nameController.text.isNotEmpty &&
                              emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty &&
                              mobileController.text.isNotEmpty &&
                              selectedRole != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("✅ Registration form submitted!"),
                              ),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPVerificationScreen(
                                  mobileNumber: mobileController.text,
                                  role: selectedRole!,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("❗ Please fill all fields"),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.secondary),
          filled: true,
          fillColor: AppColors.tertiary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: passwordController,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(color: AppColors.secondary),
          filled: true,
          fillColor: AppColors.tertiary,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedRole,
        hint: const Text("What is your Role ?"),
        items: ['Doctor', 'Locum']
            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedRole = value;
          });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.tertiary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondary),
          ),
        ),
      ),
    );
  }
}
