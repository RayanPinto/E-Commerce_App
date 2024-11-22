import 'dart:convert';

import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/order.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart ' as http;

class AccountController {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orders = [];

    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/myorders"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.user.token,
        },
      );
    

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orders.add(Order.fromJson(jsonEncode(jsonDecode(res.body)[i])));
             
            }
            
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orders;
  }


  Future<void> updateUserType(String userId, String newType, BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
    http.Response res = await http.post(
        Uri.parse("$uri/api/switch-to-seller"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.user.token,
        },
        body: jsonEncode({
          'userId': userId,
          'newType': newType,
        }),
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          // Handle success if needed
           ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'User type updated to $newType successfully.',),backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );

        // Optionally, update the user type in your provider if needed
        userProvider.user.type = newType; 
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
