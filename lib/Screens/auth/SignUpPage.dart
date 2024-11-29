import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../ResponsiveLayout/responsive_layout.dart';
import '../../Service/auth_service.dart';
import 'LoginScreen.dart';



class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  void _signup() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Attempt to create user
      await _authService.signUp(
          _emailController.text.trim(),
          _passwordController.text.trim(),
          _nameController.text.trim()
      );

      // Show success message or navigate to next screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully')),
      );

      // TODO: Navigate to home or login screen
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(builder: (_) => HomeScreen()),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: _buildMobileSignup(),
      desktopView: _buildDesktopSignup(),
    );
  }

  Widget _buildMobileSignup() {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _buildSignupForm(),
        ),
      ),
    );
  }

  Widget _buildDesktopSignup() {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pink,
              child: const Center(
                child: Text(
                  "ValuePro AI\nSignup",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  child: _buildSignupForm(platform: "web"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm({var platform = "mobile"}) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Text(
            "Create Your Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: platform == "mobile"? Colors.white: Colors.pink,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Name Field
          _buildTextFormField(
            controller: _nameController,
            labelText: "Full Name",
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Email Field
          _buildTextFormField(
            controller: _emailController,
            labelText: "Email",
            prefixIcon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // Basic email validation
              final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Password Field
          _buildPasswordField(
            controller: _passwordController,
            labelText: "Password",
            obscureText: _obscurePassword,
            onToggleVisibility: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),

          // Confirm Password Field
          _buildPasswordField(
            controller: _confirmPasswordController,
            labelText: "Confirm Password",
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),

          // Signup Button
          ElevatedButton(
            onPressed: _isLoading ? null : _signup,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.pink,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.pink)
                : const Text(
              "Sign Up",
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 15),

          // Login redirect
          _buildLoginRedirect(textColor: platform == "mobile"?Colors.white:Colors.black87),
        ],
      ),
    );
  }

  Row _buildLoginRedirect({Color textColor = Colors.black87}) {
    return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: TextStyle(color: textColor),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginPage()),
                );
              },
              child:  Text(
                "Login",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationColor: textColor
                ),
              ),
            ),
          ],
        );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggleVisibility,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: validator,
    );
  }
}