import 'package:flutter/material.dart';
import 'package:login/components/my_button.dart';
import 'package:login/components/my_textfield.dart';
import 'package:login/components/square_tile.dart';
import './api_service.dart';
import 'dart:convert'; 

/*
Steph: I mainly change code from here to connect our backend and frontend
because of this only the login1 page of the frontend connects to our backend

*/

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  
  // needed for api
  final ApiService apiService = ApiService();

  
  
  // sign user in method
  void signUserIn(BuildContext context) async {
    print('signUserIn called'); //this will print signUserIn called in the debug menu to test if the frontend flutter side works
    String username = usernameController.text;
    String password = passwordController.text;

    // api for username and password
    final response = await apiService.login(username, password);

    // error messages
    if (response != null) {
      print('Login successful: ${jsonEncode(response)}');
      
      Navigator.pushNamed(context, '/petdashboard');
    } else {
      
      print('Login failed.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.pets,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Text(
                'Welcome!',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 50),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'username',
                obscureText: false,
              ),

              const SizedBox(height: 15),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),

              const SizedBox(height: 15),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              ElevatedButton(
                child: const Text("Sign in"),
                onPressed: () {
                  signUserIn(context); 
                },
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[100],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Google + Apple sign-in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Google button
                  SquareTile(imagePath: 'lib/images/google.png'),

                  SizedBox(width: 25),

                  // Apple button
                  SquareTile(imagePath: 'lib/images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // Not a member? Register now
              ElevatedButton(
                child: const Text("Register now"),
                onPressed: () {
                  Navigator.pushNamed(context, '/registrationpage');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
