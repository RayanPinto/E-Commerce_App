import 'package:amazon_rayan/controller/homeController.dart';
import 'package:amazon_rayan/controller/searchController.dart';
import 'package:amazon_rayan/model/product.dart';
import 'package:amazon_rayan/view/auth/productDetail.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatefulWidget {
  String category;
  TopCategories({super.key, required this.category});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
   Product? dodproduct;
  List<Product>? productList;
   final SearchControllerService searchController = SearchControllerService();
  final HomeController homeController = HomeController();
  
  fetchCategoryProd() async {
    productList = await homeController.fetchCategory(
        context: context, category: widget.category);
    setState(() {});
  }
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategoryProd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.amberAccent),
            ),
            title: Text(widget.category),
          )),
      body: productList == null
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : productList!.isEmpty
              ? Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          size: 140,
                        ),
                        Text("No Items Available"),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Go Back"))
                      ],
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        'Showing results for ${widget.category}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 670,
                      child: GridView.builder(
                        itemCount: productList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                             onTap: () {
                              Navigator.pushNamed(
                                  context, ProductDetailScreen.routeName,
                                  arguments: productList![index]);
                            },
                            child: Material(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 110,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5)),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Image.network(
                                            productList![index].images[0]),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                      productList![index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
