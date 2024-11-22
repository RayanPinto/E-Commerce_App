import 'package:amazon_rayan/controller/searchController.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/view/auth/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.searchQuery});
  static const String routeName = '/search-screen';
  final String searchQuery;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchControllerService searchController = SearchControllerService();

  fetchSearchedProduct() async {
    products = await searchController.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    print(products);
    setState(() {});
  }

  @override
  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      initialValue: widget.searchQuery,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: products == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: products!.length,
                        itemBuilder: (context, index) {
                          final product = products![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailScreen.routeName,
                                  arguments: product);
                            },
                            child: Expanded(
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
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
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: RatingStars(
                                                value: 4.5,
                                              ),
                                            ),
                                            Container(
                                              width: 235,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                'Rs.${product.price.toString()}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 2,
                                              ),
                                            ),
                                            Container(
                                              width: 235,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                "Free Shipping",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              width: 235,
                                              padding: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Text(
                                                "In Stock",
                                                style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold),
                                                maxLines: 2,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
    );
  }
}
