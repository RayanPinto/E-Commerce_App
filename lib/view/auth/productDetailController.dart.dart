import 'dart:convert';

import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailController {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse("$uri/api/rate-product"),
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'token': userProvider.user.token,
          },
          body: jsonEncode({'id': product.id, 'rating': rating}));

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Thank You For Rating This Product."),
                backgroundColor: Colors.green));
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
