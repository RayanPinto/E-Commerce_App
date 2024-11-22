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
    if (email.isEmpty || name.isEmpty || password.isEmpty) {
      showSnackBar(context, "Please fill in all fields");
      return;
    }
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          token: '',
          type: '',
          cart: []);
      http.Response res = await http.post(Uri.parse("$uri/api/signup"),
          body: jsonEncode(user.fromAppToDB()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
          print("Request body: ${jsonEncode(user.fromAppToDB())}");
print("Response status code: ${res.statusCode}");
print("Response body: ${res.body}");


      if (res.statusCode != 201) {
        // Handle non-200 responses
        showSnackBar(context, "Failed to create account. Please try again.");
        return;
      }

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Account Created Successfully! Please login with the same credentials."),
                backgroundColor: Colors.green));
          });
    } catch (e) {
      showSnackBar(context, "Error occured-${e.toString()}");
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
      http.Response res = await http.post(Uri.parse("$uri/api/signin"),
          body: jsonEncode({"email": email, "password": password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');
      print('Email: $email, Password: $password');

      if (res.statusCode != 200) {
        // Handle non-200 responses
        showSnackBar(context, "Failed to sign in. Please try again.");
        return;
      }

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "Welcome User.",
                  textAlign: TextAlign.center,
                ),
                backgroundColor: Colors.green));
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            print("TOKEN VALUE IS HERE");
            print(jsonDecode(res.body)['token']);
            await sharedPreferences.setString(
                "token", jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomNavBar.routeName, (route) => false);
          });
    } catch (e) {
      showSnackBar(context, "Error occured-${e.toString()}");
    }
  }
  Future<String> fetchUserData(BuildContext context) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");

  if (token == null) {
    sharedPreferences.setString("token", "");
    return '{"error": "No token found"}'; // Return error if no token
  }

  try {
    var tokenRes = await http.post(
      Uri.parse("$uri/validateToken"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );

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

        return userRes.body; // Return the user data
      } else {
        return '{"error": "Invalid token"}'; // Handle invalid token case
      }
    } else {
      return '{"error": "Token validation failed"}'; // Handle failed token validation
    }
  } catch (e) {
    print("Error fetching user data: $e"); // Print the error for debugging
    return '{"error": "Unexpected error occurred: ${e.toString()}"}'; // Return error message
  }
}

}
