import 'dart:convert';

import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/userModel.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressController {
  Future<void> saveUserAddress(
      {required BuildContext context, required String address}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse("$uri/api/save-user-address"),
              headers: {
                'Content-Type': 'application/json;charset=UTF-8',
                'token': userProvider.user.token
              },
              body: jsonEncode({'address': address}));

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Your Address Has Been Saved."),
              backgroundColor: Colors.green));
          // Corrected the closing parenthesis in the copyWith method
          User updatedUser = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          // Update the user in the provider
          userProvider.setUserFromModel(updatedUser);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double total,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'token': userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'total': total
          }));

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Your Item Has Been Added To Cart."),
                backgroundColor: Colors.green));
          });
      User user = userProvider.user.copyWith(cart: []);
      userProvider.setUserFromModel(user);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
