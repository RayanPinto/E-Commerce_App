import 'package:amazon_rayan/controller/authController.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/order.dart';
import 'package:amazon_rayan/seller_view/controller/accountController.dart';
import 'package:amazon_rayan/utils/account_button.dart';
import 'package:amazon_rayan/utils/seller_bottom_nav_bar.dart';
import 'package:amazon_rayan/utils/singleProduct.dart';
import 'package:amazon_rayan/view/auth/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Order>? orders;

  final AccountController accountController = AccountController();
  final AuthController authController = AuthController();
  fetchOrder() async {
    orders = await accountController.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(color: const Color.fromRGBO(34, 150, 243, 1.0)),
            ),
            title: Row(
              children: [
                Image.asset(
                  "assets/images/logo3-removebg.png",
                  width: 175,
                  height: 190,
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications,
                      size: 30,
                    )), //SizedBox(width: 10,),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    )),
              ],
            ),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Text(
              "Hey 👋! ${user.name}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Expanded(
  child: ProfileButton(
    text: "Your Account",
    onTap: () {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.user;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Text(
              "User Details",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // User ID
                        Row(
                          children: [
                            Icon(Icons.perm_identity, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              "ID:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.id.isNotEmpty ? user.id : "N/A",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        
                        // User Name
                        Row(
                          children: [
                            Icon(Icons.person, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              "Name:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.name.isNotEmpty ? user.name : "N/A",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        
                        // User Email
                        Row(
                          children: [
                            Icon(Icons.email, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              "Email:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.email.isNotEmpty ? user.email : "N/A",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        
                        // User Address
                        Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              "Address:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.address.isNotEmpty ? user.address : "N/A",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        
                        // User Type
                        Row(
                          children: [
                            Icon(Icons.label, color: Colors.blueAccent),
                            SizedBox(width: 10),
                            Text(
                              "Type:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                user.type.isNotEmpty ? user.type : "N/A",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        
                        // User Cart
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          );
        },
      );
    },
  ),
),
                ProfileButton(
                  text: "Your Wishlist",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Your Wishlist is empty."),
                        backgroundColor: Colors.black));
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ProfileButton(
                text: "Seller Mode",
                onTap: () async {
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  final userId = userProvider.user.id;

                  // Update user type to 'seller'
                  await accountController.updateUserType(
                      userId, 'seller', context);

                  // Fetch updated user data with context
                  String userJson = await authController.fetchUserData(context);

                  // Check if the response contains an error
                  if (userJson.contains('error')) {
                    // Handle error response accordingly
                    print("Error fetching user data: $userJson");

                    return; // Exit if there's an error
                  }

                  // Update user in UserProvider with the fetched data
                  userProvider.setUser(userJson);

                  // Navigate to SellerBottomNavBar after updating the type
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SellerBottomNavBar()),
                  );
                },
              ),
              ProfileButton(
                text: "Logout",
                onTap: () {
                  Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                },
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Your Orders",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          orders == null
              ? CircularProgressIndicator()
              : orders!.isEmpty // Check if orders is empty
                  ? Center(
                      child: Text(
                          "No orders found.")) // Show a message if no orders
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          final product = orders![index];

                          // Ensure products list is not empty before accessing it
                          if (product.products.isNotEmpty &&
                              product.products[0].images.isNotEmpty) {
                            return SingleProduct(order: product);
                          } else {
                            return Container(); // Return an empty container or a placeholder
                          }
                        },
                      ),
                    )
        ],
      ),
    );
  }
}
