import 'package:flutter/material.dart';
// Assume necessary imports for your sign-up logic (e.g., authentication service)

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _isLoading = false; // To control the display of a loading indicator

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isPasswordCompliant(String password, [int minLength = 8]) {
    if (password.isEmpty) {
      return false;
    }
    bool hasMinLength = password.length >= minLength;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasMinLength && hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) {
      return; // If form is not valid, do nothing
    }
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      // Simulate a sign-up process (e.g., API call)
      await Future.delayed(Duration(seconds: 2)); // Placeholder for your sign-up logic
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SuccessPage())); // Adjust as needed
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Sign up failed. Please try again later.')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Please enter your email' : null,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureTextPassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureTextPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                ),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureTextConfirmPassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureTextConfirmPassword ? Icons.visibility : Icons.visibility_off),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Please confirm your password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  child: _isLoading ? CircularProgressIndicator(color: Colors.white) : Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Success")),
      body: Center(child: Text("You have successfully signed up!")),
    );
  }
}