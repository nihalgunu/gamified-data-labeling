import 'package:boilermakexii_2/create_account.dart';
import 'package:flutter/material.dart';
import 'package:boilermakexii_2/const.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              pink2, // Same pink shade from your profile page
              cyan3, // Soft cyan transition
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo or title
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset('assets/AI_Generated_Logo_2025-02-23_6c928111-f8d5-491b-990e-fc4ecd9387de (2).svg',
                      color: Colors.white,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  Text(
                    'Welcome Back!',
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  // Divider underneath the welcome text
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: Divider(
                      color: darkBlue,
                      thickness: 2,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  // Email input field
                  TextField(
                    style: TextStyle(color: darkBlue),
                    cursorColor: darkBlue,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Password input field
                  TextField(
                    obscureText: true,
                    style: TextStyle(color: darkBlue),
                    cursorColor: darkBlue,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: darkBlue.withOpacity(0.6)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).copyWith(
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        // TODO: Implement login with email and password
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Sign in with Google Button
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        side: BorderSide(color: darkBlue),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).copyWith(
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      // icon: Icon(Icons.g_mobiledata, color: darkBlue),
                      onPressed: () {
                        // TODO: Implement Google sign-in functionality
                      },
                      label: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: darkBlue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Create Account Button
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ).copyWith(
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                          return CreateAccountPage();
                        }));
                      },
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: size.height * 0.022,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  // Forgot Password Link
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: darkBlue,
                    ).copyWith(
                      overlayColor:
                      MaterialStateProperty.all(Colors.transparent),
                      splashFactory: NoSplash.splashFactory,
                    ),
                    onPressed: () {
                      // TODO: Implement forgot password functionality
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: size.height * 0.018,
                        color: darkBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
