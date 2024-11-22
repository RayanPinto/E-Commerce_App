import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/seller_view/controller/accountController.dart';
import 'package:amazon_rayan/utils/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDelivery extends StatefulWidget {
  const MyDelivery({super.key});

  @override
  State<MyDelivery> createState() => _MyDeliveryState();
}

class _MyDeliveryState extends State<MyDelivery> {
  @override
  Widget build(BuildContext context) {
    final accountController = AccountController();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Delivery'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person),
        onPressed: () async {
          final userId =
              Provider.of<UserProvider>(context, listen: false).user.id;

          // Update user type to 'user'
          await accountController.updateUserType(userId, 'user', context);

          // Navigate back to user mode (HomeScreen)
          Navigator.pushReplacementNamed(context, BottomNavBar.routeName);
        },
      ),
    );
  }
}
