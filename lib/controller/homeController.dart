import 'dart:convert';

import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';

import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeController {
  Future<List<Product>> fetchCategory(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'token': userProvider.user.token
      });
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
        name: "",
        description: "",
        quantity: 0,
        images: [],
        category: "",
        price: 0);
    try {
      http.Response res =
          await http.get(Uri.parse("$uri/api/deal-of-day"), headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'token': userProvider.user.token
      });
// De
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            if (res.statusCode==200 &&res.body.isNotEmpty) {
              product = Product.fromJson(res.body);
              print(product);
            } else {
              showSnackBar(context, "No deal available");
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
