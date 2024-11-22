import "package:amazon_rayan/model/order.dart";
import "package:amazon_rayan/model/product.dart";
import "package:amazon_rayan/seller_view/addProduct.dart";
import "package:amazon_rayan/utils/bottom_nav_bar.dart";
import "package:amazon_rayan/view/addressScreen.dart";
import "package:amazon_rayan/view/auth/authScreen.dart";
import "package:amazon_rayan/view/auth/productDetail.dart";
import "package:amazon_rayan/view/homeScreen.dart";
import "package:amazon_rayan/view/orderDetails.dart";
import "package:amazon_rayan/view/searchScreen.dart";
import "package:flutter/material.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => AuthScreen());
    case BottomNavBar.routeName:
      return MaterialPageRoute(builder: (_) => BottomNavBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => AddProductScreen());
    case SearchScreen.routeName:
      return MaterialPageRoute(
          builder: (_) =>
              SearchScreen(searchQuery: routeSettings.arguments as String));
    case ProductDetailScreen.routeName:
      return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: routeSettings.arguments as Product,));
      case AddressScreen.routeName:
      return MaterialPageRoute(builder: (_) => AddressScreen(totalAmount: routeSettings.arguments as String,));
       case OrderDetails.routeName:
      return MaterialPageRoute(builder: (_) => OrderDetails(order: routeSettings.arguments as Order,));
       case HomeScreen.routeName:  // Add this case for HomeScreen
      return MaterialPageRoute(builder: (_) => HomeScreen());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text("Page not exits")),
              ));
  }
}
