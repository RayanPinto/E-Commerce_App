import 'package:amazon_rayan/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

import '../controller/provider_controller/user_provider.dart';
import '../controller/userController.dart';
import '../view/auth/productDetail.dart';

class CartProduct extends StatefulWidget {
  int index;
  CartProduct({super.key, required this.index});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  void increaseQuantity(Product product) {
    UserController().addToCart(context: context, product: product);
  }

  void decreaseQuantity(Product product) {
    UserController().removeFromCart(context: context, product: product);
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];

    final product = Product.fromDBtoApp(productCart['product']);
    final quantity = productCart['quantity'];
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ProductDetailScreen.routeName,
              arguments: product);
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7.7),
              child: Row(
                children: [
                  Image.network(
                    product.images[0],
                    height: 140,
                    width: 140,
                    fit: BoxFit.contain,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 235,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          product.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: RatingStars(
                          value: 4.5,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          'Rs.${product.price.toString()}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          "Free Shipping",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: EdgeInsets.only(left: 25, top: 5),
                        child: Text(
                          "In Stock",
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                decreaseQuantity(product);
                              },
                              child: Container(
                                width: 35,
                                height: 32,
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: Icon(Icons.remove, size: 18),
                              ),
                            ),
                            DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 1.5),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0)),
                                child: Container(
                                  height: 32,
                                  width: 35,
                                  alignment: Alignment.center,
                                  child: Text(
                                    quantity.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                            InkWell(
                              onTap: () {
                                increaseQuantity(product);
                              },
                              child: Container(
                                width: 35,
                                height: 32,
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: Icon(Icons.add, size: 18),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
