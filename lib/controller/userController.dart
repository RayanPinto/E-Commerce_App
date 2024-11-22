import 'dart:convert';

import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../constant/global.dart';
import '../model/userModel.dart';

class UserController {
  void addToCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse("$uri/api/add-to-cart"),
          headers: {
            "Content-type": 'application/json;charset=UTF-8',
            'token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id,
          }));
     

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Your Item Has Been Added To Cart."),
                backgroundColor: Colors.green));
            if (res.statusCode == 200) {
              final cartData = jsonDecode(res.body)['cart'];
              if (cartData != null) {
                User user = userProvider.user
                    .copyWith(cart: jsonDecode(res.body)['cart']);
                userProvider.setUserFromModel(user);
              } else {
                showSnackBar(context, "Cart data is not available.");
              }
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }






   void removeFromCart(
      {required BuildContext context, required Product product}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(Uri.parse("$uri/api/remove-from-cart/${product.id}"),
          headers: {
            "Content-type": 'application/json;charset=UTF-8',
            'token': userProvider.user.token
          },
          );
     

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            if (res.statusCode == 200) {
              final cartData = jsonDecode(res.body)['cart'];
              if (cartData != null) {
                User user = userProvider.user
                    .copyWith(cart: jsonDecode(res.body)['cart']);
                userProvider.setUserFromModel(user);
              } else {
                showSnackBar(context, "Cart data is not available.");
              }
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
