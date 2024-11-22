import 'package:amazon_rayan/constant/global.dart';
import 'package:amazon_rayan/controller/authController.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/utils/bottom_nav_bar.dart';
import 'package:amazon_rayan/utils/seller_bottom_nav_bar.dart';
import 'package:amazon_rayan/view/auth/authScreen.dart';
import 'package:amazon_rayan/view/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
  
  }

  class _MyAppState extends State<MyApp>{
    final AuthController authController=AuthController();

    @override
    void initState(){
      authController.fetchUserData(context);
      
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) => generateRoute(settings),
        debugShowCheckedModeBanner: false,
        title: 'Rayan Amazon',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: GlobalVariables.primaryColor,
            )),
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty? Provider.of<UserProvider>(context).user.type=='user' ?BottomNavBar():SellerBottomNavBar():AuthScreen()
        
        
        );
  }
}
