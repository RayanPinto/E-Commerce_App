import 'dart:convert';

import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchControllerService {
  Future<List<Product>> fetchSearchedProduct(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(Uri.parse("$uri/api/products/search/$searchQuery"), headers: {
        "Content-type": 'application/json;charset=UTF-8',
        'token': userProvider.user.token
      });

      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
              Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
