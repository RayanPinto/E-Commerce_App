import 'package:amazon_rayan/controller/homeController.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/utils/account_button.dart';
import 'package:amazon_rayan/view/auth/ScrollController.dart';
import 'package:amazon_rayan/view/auth/TopCategories.dart';
import 'package:amazon_rayan/view/auth/productDetail.dart';
import 'package:amazon_rayan/view/searchScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/provider_controller/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  static const List<String> carouselImages = [
    'https://img.freepik.com/free-vector/hand-drawn-beauty-sale-banner-design_23-2149667222.jpg?t=st=1729960606~exp=1729964206~hmac=3d5cf1fc06e9e5e09feb4f6de0841eb9c198b431789088f032183b3e28119c47&w=900',
    'https://img.pikbest.com/backgrounds/20210728/attractive-fashion-sale-banner-template_6053664.jpg!sw800',
    'https://img.freepik.com/free-vector/cosmetics-sale-banner-with-lipstick-blush-make-up_107791-2246.jpg',
    'https://img.freepik.com/free-vector/horizontal-sale-banner-template_23-2148897328.jpg',
    
    'https://s3.amazonaws.com/media.mediapost.com/dam/cropped/2019/12/06/screenshot-2019-12-05-at-23107-pm_kKdoMd4.png',
    'https://shop.daisycomms.co.uk/wp-content/uploads/2023/09/Apple-iPhone-15-promo-banner-buy-now-scaled.jpg',
    'https://cdna.artstation.com/p/assets/images/images/031/542/572/large/gamunu-dissanayaka-product-cream-design.jpg?1603908970',
    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs3/266175955/original/277ffa812eef9d27bde1251eb009ded62b75e988/unique-design-your-creative-product-advertisement-poster.jpg',
    // 'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Product? dodproduct;

  List<Map<String, String>> categoryData = [
    {
      "name": "Mobiles",
      "imgUrl":
          "https://suprememobiles.in/cdn/shop/files/mobiles.jpg?crop=center&height=2048&v=1664280076&width=2048"
    },
    {
      "name": "Home Appliances",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNu4bEfzavRP8kmwt-cHXxRiIvI7ils0mUZA&s"
    },
    {
      "name": "Clothes",
      "imgUrl":
          "https://www.eurokidsindia.com/blog/wp-content/uploads/2023/07/baby-care-products.jpg"
    },
    {
      "name": "Grocery",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRKEDP45_a_fizrXJ7UQ4qFistPcFlSxX4uw&s"
    },
    {
      "name": "Books",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKnVp3abpKHU6VI-9TV3Rova8rKtVHp-b0Sg&s"
    },
    {
      "name": "Laptops",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR23hVJDRwORZETPdBEX3aXkWXKwAW2wmWDlg&s"
    },
    {
      "name": "Furnitures",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSf_YeU70m-40c2cCDnQTjr7vBKgu-ctVbzYg&s"
    },
    {
      "name": "TV's",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTL5NydupQPPKwZo-KaJvit6Z4um1kt-zMB0g&s"
    },
    {
      "name": "Movies",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQWEnzFCV_pu380BA50rg0CQmqVPyqXOuRyA&s"
    },
    {
      "name": "Video Games",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4s8NjfZH8IOF_prQHfszEYJriNSVy1mJ7Sg&s"
    },
    {
      "name": "Cameras",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdkrr_qjtUnbT__fmR63B2DDByQFdpobZFdQ&s"
    },
    {
      "name": "Sports & Fitness",
      "imgUrl":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMtf5R7my3prkOSzl1sCK6E4i2zwW_jRpeQw&s"
    }
  ];
  final ScrollController _scrollController = ScrollController();

  fetch(BuildContext context) async {
    dodproduct = await HomeController().fetchDealOfTheDay(context: context);
    if (dodproduct == null) {
      return Center(child: CircularProgressIndicator());
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch(context);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final carouselController = CarouselController();

    void scrollToTop() {
      _scrollController.animateTo(
        0, // Scroll position at the top
        duration: Duration(seconds: 1), // Duration of the animation
        curve: Curves.easeInOut, // Ease-in-out animation curve
      );
    } // Use the aliased import

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 232, 232),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        Navigator.pushNamed(context, SearchScreen.routeName,
                            arguments: value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Rayan.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                  icon: const Icon(Icons.mic, color: Colors.black, size: 25),
                  onPressed: () {
                    // Show dialog when the microphone icon is pressed
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Feature Not Supported'),
                          content: Text(
                              'Your device does not support this feature.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 114, 226, 221),
                        Color.fromARGB(255, 162, 236, 233),
                      ],
                      stops: [0.5, 1.0],
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Delivery to ${user.name} - ${user.address.isEmpty ? "Address not set" : user.address} ',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 5,
                          top: 2,
                        ),
                        child: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 115,
                  color: const Color.fromARGB(255, 254, 183, 16),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryData.length,
                      itemBuilder: (context, index) {
                        final cat = categoryData[index];
                        final imgurl = cat["imgUrl"];
                        final name = cat["name"];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopCategories(
                                          category: cat["name"]!,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape
                                    .circle, // Makes the border circular
                                border: Border.all(
                                  color: Colors
                                      .red, // Replace with your desired color
                                  width: 3.0, // Border width
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: imgurl != null
                                    ? NetworkImage(imgurl)
                                    : const AssetImage('assets/images/logo3-removebg.png'),
                                radius: 40,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                CarouselSlider(
                  items: HomeScreen.carouselImages.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.cover,
                          height: 250,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    autoPlay: true,
                    height: 250,
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: dodproduct!)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 90, 14),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: const Color.fromARGB(255, 147, 15, 6),
                                width: 2)),
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 10),
                        child: Text(
                          'Deal Of The Day',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      dodproduct != null && dodproduct!.images.isNotEmpty
                          ? CarouselSlider(
                              options: CarouselOptions(
                                height: 235, // Set the height of the carousel
                                autoPlay: true, // Enables automatic sliding
                                enlargeCenterPage:
                                    true, // Enlarges the center image
                                aspectRatio: 1,
                                viewportFraction:
                                    0.8, // Controls the size of the displayed image
                              ),
                              items: dodproduct!.images.map((imageUrl) {
                                String discount = "-30% OFF";
                                return Stack(
                                  alignment: Alignment.topRight, //
                                  children: [
                                    Container(
                                      child: Builder(
                                        builder: (BuildContext context) {
                                          return Image.network(imageUrl,
                                              fit: BoxFit
                                                  .contain, // Set the fit for the images in the carousel
                                              height: 235, errorBuilder:
                                                  (context, error, stackTrace) {
                                            return const Icon(Icons.error,
                                                size: 60);
                                          });
                                        },
                                      ),
                                    ),
                                    Positioned(
                                        child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topRight: Radius.circular(5),
                                        ),
                                      ),
                                      child: Text(
                                        discount,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                  ],
                                );
                              }).toList(),
                            )
                          : const Text("No Deal Available"),
                      if (dodproduct != null)
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          alignment: Alignment.center,
                          child: Text(
                            '₹${dodproduct!.price + 500} only ',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.red,
                                decorationThickness: 1.5),
                          ),
                        ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        alignment: Alignment.center,
                        child: Text(
                          'MRP ₹${dodproduct!.price} only',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      if (dodproduct != null)
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 25, top: 5, right: 25, bottom: 25),
                          child: Text(
                            dodproduct!.name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      Divider(
                        color: Colors.red,
                        height: 1,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.grey,
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: Text(
                    'Exciting Offers For You ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '           The Services are not available right now\n                                Contact Rayan',
                        ),
                        backgroundColor: const Color.fromARGB(255, 160, 32, 23),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 0.8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 1.2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildOfferButton('Under ₹99', 'Budget Buys'),
                                  _buildOfferButton('Under ₹199', 'Best Buys'),
                                  _buildOfferButton(
                                      'Under ₹299', 'Super Saver'),
                                  _buildOfferButton('From ₹49', 'Bazaar'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        color: Colors.grey,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 0.8)),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 1.2)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildFeatureButton(
                                      'Rayan Pay', Icons.payment),
                                  _buildFeatureButton('Recharge', Icons.bolt),
                                  _buildFeatureButton(
                                      'Rewards', Icons.emoji_events),
                                  _buildFeatureButton(
                                      'Pay Bills', Icons.receipt),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/amazon.jpg', // Use a similar banner image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        color: Colors.grey,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 241, 20, 120),
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 0.8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 241, 20, 186),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.black, width: 0.8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildFooterFeature(
                                      'Free Delivery', Icons.local_shipping),
                                  _buildFooterFeature(
                                      'Pay on Delivery', Icons.payments),
                                  _buildFooterFeature(
                                      'Easy Returns', Icons.restart_alt),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Want to know about me? Not Today.',
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 195, 94, 241),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    height: 40, // Use the height of the SizedBox
                    color: Colors.lightBlue, // Set the background color
                    alignment: Alignment.center, // Center the child
                    child: Text(
                      'About Rayan',
                      style: TextStyle(
                        color: Colors.grey[400], // Text color
                        fontSize: 16, // Text size
                        fontWeight: FontWeight.bold, // Text weight
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.black87,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row of links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Hii 👋! ${user.name}",
                                  ),
                                  backgroundColor:
                                      const Color.fromARGB(255, 195, 94, 241),
                                  duration: Duration(seconds: 3),
                                ),
                              ); // Handle 'Your Rayan.in' button click
                            },
                            child: Text(
                              'Your Rayan.in',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle 'Your Orders' button click
                            },
                            child: Text(
                              'Your Orders',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle 'About Us' button click
                            },
                            child: Text(
                              'About Us',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Second row of links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle 'Amazon Pay' button click
                            },
                            child: Text(
                              'Amazon Pay',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          TextButton(
                            child: Text(
                              "Your Account",
                              style: TextStyle(color: Colors.blue),
                            ),
                            onPressed: () {
                              final userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              final user = userProvider.user;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
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
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // User ID
                                                Row(
                                                  children: [
                                                    Icon(Icons.perm_identity,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "ID:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        user.id.isNotEmpty
                                                            ? user.id
                                                            : "N/A",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // User Name
                                                Row(
                                                  children: [
                                                    Icon(Icons.person,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Name:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        user.name.isNotEmpty
                                                            ? user.name
                                                            : "N/A",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // User Email
                                                Row(
                                                  children: [
                                                    Icon(Icons.email,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Email:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        user.email.isNotEmpty
                                                            ? user.email
                                                            : "N/A",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // User Address
                                                Row(
                                                  children: [
                                                    Icon(Icons.location_on,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Address:",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        user.address.isNotEmpty
                                                            ? user.address
                                                            : "N/A",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),

                                                // User Type
                                                Row(
                                                  children: [
                                                    Icon(Icons.label,
                                                        color:
                                                            Colors.blueAccent),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Type:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Text(
                                                        user.type.isNotEmpty
                                                            ? user.type
                                                            : "N/A",
                                                        style: TextStyle(
                                                            fontSize: 16),
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
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle 'My Account' button click
                            },
                            child: Text(
                              'Returns',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      // Additional rows of links
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle button click
                            },
                            child: Text(
                              "Sell Products",
                              style: TextStyle(
                                  color: Colors.blue), // Styling for the link
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle button click
                            },
                            child: Text(
                              "Your Lists",
                              style: TextStyle(
                                  color: Colors.blue), // Styling for the link
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle button click
                            },
                            child: Text(
                              "Services",
                              style: TextStyle(
                                  color: Colors.blue), // Styling for the link
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      Center(
                        child: Text(
                          '© 2004-2024, Rayan.com, Inc. and its affiliates',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: _buildScrollToTopButton(),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(BuildContext context, String text) {
    return TextButton(
      onPressed: () {
        // Handle button click
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.blue), // Styling for the link
      ),
    );
  }

  Widget _buildFeatureButton(String label, IconData icon) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.orange[100],
            radius: 28,
            child: Icon(
              icon,
              color: Colors.black87,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildOfferButton(String price, String label) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CircleAvatar(
            backgroundColor: Colors.yellow[100],
            radius: 28,
            child: Text(
              price,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildFooterFeature(String label, IconData icon) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.black87,
            size: 34,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void scrollToTop() {
    if (_scrollController.hasClients) {
      print('Scrolling to top...'); // Debugging
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildScrollToTopButton() {
    return GestureDetector(
      onTap: scrollToTop,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue, // Button color
          borderRadius: BorderRadius.circular(25), // Circular button
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_upward,
          color: Colors.white, // Icon color
        ),
      ),
    );
  }
}
