import 'dart:convert';

import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/userModel.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_rayan/constant/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amazon_rayan/utils/bottom_nav_bar.dart';

class AuthController {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String password}) async {
    // Enhanced validation
    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      showSnackBar(context, "Please fill in all fields");
      return;
    }

    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      showSnackBar(context, "Please enter a valid email address");
      return;
    }

    // Password length validation
    if (password.length < 8) {
      showSnackBar(context, "Password must be at least 8 characters long");
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      User user = User(
          id: '',
          email: email.trim(),
          name: name.trim(),
          password: password,
          address: '',
          token: '',
          type: 'user',
          cart: []);

      print("🌐 Attempting to connect to: $uri/api/signup");
      print("📤 Request data: ${jsonEncode(user.fromAppToDB())}");

      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: jsonEncode(user.fromAppToDB()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(Duration(seconds: 10)); // Add timeout

      // Close loading indicator
      Navigator.of(context).pop();

      print("📥 Response status code: ${res.statusCode}");
      print("📥 Response body: ${res.body}");
      print("📥 Response headers: ${res.headers}");

      if (res.statusCode == 201) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Account Created Successfully! Please login with the same credentials."),
            backgroundColor: Colors.green));
      } else if (res.statusCode == 400) {
        // Bad request - user already exists or validation error
        try {
          var errorData = jsonDecode(res.body);
          showSnackBar(context, errorData['msg'] ?? "Account creation failed");
        } catch (e) {
          showSnackBar(context, "Account creation failed. Please try again.");
        }
      } else if (res.statusCode == 500) {
        // Server error
        try {
          var errorData = jsonDecode(res.body);
          showSnackBar(
              context, "Server error: ${errorData['msg'] ?? 'Unknown error'}");
        } catch (e) {
          showSnackBar(
              context, "Server error occurred. Please try again later.");
        }
      } else {
        // Other errors
        showSnackBar(
            context, "Failed to create account. Status: ${res.statusCode}");
      }
    } catch (e) {
      // Close loading indicator if still showing
      Navigator.of(context).pop();

      print("❌ Error during signup: $e");

      if (e.toString().contains('SocketException')) {
        showSnackBar(context,
            "Cannot connect to server. Please check your internet connection and try again.");
      } else if (e.toString().contains('TimeoutException')) {
        showSnackBar(context, "Request timed out. Please try again.");
      } else {
        showSnackBar(context, "Error occurred: ${e.toString()}");
      }
    }
  }

  Future<void> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(context, "Please fill in all fields");
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      print("🌐 Attempting to sign in at: $uri/api/signin");

      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({"email": email.trim(), "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(Duration(seconds: 10));

      // Close loading indicator
      Navigator.of(context).pop();

      print('📥 Response status: ${res.statusCode}');
      print('📥 Response body: ${res.body}');

      if (res.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome User."), backgroundColor: Colors.green));

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);

        var tokenData = jsonDecode(res.body);
        await sharedPreferences.setString("token", tokenData['token']);

        Navigator.pushNamedAndRemoveUntil(
            context, BottomNavBar.routeName, (route) => false);
      } else if (res.statusCode == 400) {
        // Bad request - wrong credentials
        try {
          var errorData = jsonDecode(res.body);
          showSnackBar(context, errorData['msg'] ?? "Sign in failed");
        } catch (e) {
          showSnackBar(context, "Invalid email or password");
        }
      } else {
        showSnackBar(context, "Sign in failed. Please try again.");
      }
    } catch (e) {
      // Close loading indicator if still showing
      Navigator.of(context).pop();

      print("❌ Error during signin: $e");

      if (e.toString().contains('SocketException')) {
        showSnackBar(context,
            "Cannot connect to server. Please check your internet connection and try again.");
      } else if (e.toString().contains('TimeoutException')) {
        showSnackBar(context, "Request timed out. Please try again.");
      } else {
        showSnackBar(context, "Error occurred: ${e.toString()}");
      }
    }
  }

  Future<String> fetchUserData(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");

    if (token == null || token.isEmpty) {
      return '{"error": "No token found"}';
    }

    try {
      var tokenRes = await http.post(
        Uri.parse("$uri/validateToken"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
      ).timeout(Duration(seconds: 5));

      print("Token validation response: ${tokenRes.body}");

      if (tokenRes.statusCode == 200) {
        var response = jsonDecode(tokenRes.body);

        if (response == true) {
          http.Response userRes = await http.get(
            Uri.parse("$uri/"),
            headers: <String, String>{
              'Content-Type': 'application/json;charset=UTF-8',
              'token': token,
            },
          );

          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(userRes.body);

          return userRes.body;
        } else {
          return '{"error": "Invalid token"}';
        }
      } else {
        return '{"error": "Token validation failed"}';
      }
    } catch (e) {
      print("Error fetching user data: $e");
      return '{"error": "Unexpected error occurred: ${e.toString()}"}';
    }
  }
}
