import 'package:amazon_rayan/view/cartScreen.dart';
import 'package:amazon_rayan/view/homeScreen.dart';
import 'package:amazon_rayan/view/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider_controller/user_provider.dart';

class BottomNavBar extends StatefulWidget {
  static const String routeName = '/navBar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int screen_index = 0;
  List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
    CartScreen(),
  ];

  updateScreen(int index) {
    setState(() {
      screen_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLen = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: screens[screen_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateScreen,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.black,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: screen_index == 0 ? Colors.amber : Colors.black,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: screen_index == 1 ? Colors.amber : Colors.black,
              ),
              label: ""),
          BottomNavigationBarItem(
            label: "",
              icon: Badge(
                label: Text(userCartLen.toString()),
                  child: Icon(
            Icons.shopping_cart,
            color: screen_index == 2 ? Colors.amber : Colors.black,
          )))
        ],
      ),
    );
  }
}
