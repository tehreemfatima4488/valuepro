import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:valuepro/Screens/dashboard/dashboard.dart';

import '../../ResponsiveLayout/responsive_layout.dart';
import '../../Service/auth_service.dart';
import 'SignUpPage.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController(text: "hali07112@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "Password1@@");
  final AuthService _authService = AuthService();
  bool _obscureText = true;
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithEmailAndPassword(
          emailController.text.trim(),
          passwordController.text.trim()
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in'))
      );
      print("logged in");
      // Navigate to home screen or next page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashboard()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.toString()}'))
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
        mobileView: _loginMobile(), desktopView: _loginDesktop());
  }

  Widget _loginMobile() {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Welcome to ValuePro AI",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 30),
              _buildLoginButton(),
              const SizedBox(height: 30,),
              _buildSignupField(Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildSignupField(Color textColor) {
    // var textColor = Colors.black87;
    return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupPage(),));
                },
                child: Center(child: Text("Dont have account?",style: TextStyle(color: textColor),)));
  }

  Widget _loginDesktop() {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pink,
              child: const Center(
                child: Text(
                  "ValuePro AI",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEmailField(),
                    const SizedBox(height: 20),
                    _buildPasswordField(),
                    const SizedBox(height: 30),
                    _buildLoginButton(),
                    const SizedBox(height: 30,),
                    _buildSignupField(Colors.black87)

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: const Icon(Icons.email),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.pink,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: _isLoading
          ? const CircularProgressIndicator()
          : const Text(
          "Sign In",
          style: TextStyle(fontSize: 18)
      ),
    );
  }
}