import 'dart:io';

import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';

import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:amazon_rayan/constant/global.dart';
import 'dart:convert';
import 'package:amazon_rayan/model/product.dart'; // Add this import

class AdminController {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required int quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('delc6lpe8', 'n2hj6ajd');

      List<String> imageUrl = [];
      for (var img in images) {
         CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(img.path, folder: name));

         imageUrl.add(res.secureUrl);
        print(res.secureUrl);
      }

      
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrl,
        category: category,
        price: price,
      );
      http.Response res = await http.post(Uri.parse("$uri/admin/add-products"),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'token': userProvider.user.token,
          },
          body: product.toJson());
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            showSnackBar(context, "Product added Successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/admin/get-products"),
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
              productList
                  .add(Product.fromJson(jsonEncode(jsonDecode(res.body)[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required context,
    required Product product,
    required onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'token': userProvider.user.token,
              },
              body: jsonEncode({'id': product.id}));
      httpErrorHandler(
          context: context,
          response: res,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


   Future<void> switchToSeller(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse("$uri/api/switch-to-seller"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        context: context,
        response: res,
        onSuccess: () {
          showSnackBar(context, "User switched to seller mode successfully.");
          // Optionally, update the user type in your provider if needed
          userProvider.user.type = 'seller'; // Update user type in provider
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
