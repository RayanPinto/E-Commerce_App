import 'package:amazon_rayan/seller_view/addProduct.dart';
import 'package:amazon_rayan/seller_view/controller/AdminController.dart';
import 'package:flutter/material.dart';
import 'package:amazon_rayan/model/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = []; // Ensure products is non-nullable
  final AdminController adminController = AdminController();

  // Fetch products from the server
  fetchAllProducts() async {
    final fetchedProducts = await adminController.fetchAllProducts(context);
    setState(() {
      products = fetchedProducts ?? []; // Assign fetchedProducts safely
    });
  }

  void deleteProduct(Product delProduct, int index) {
    adminController.deleteProduct(
        context: context,
        product: delProduct,
        onSuccess: () {
          products.removeAt(index);
          setState(() {
            
          });
        });
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts(); // Call to fetch products
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Your Products :${products.length}'),backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
      ),
      body: products.isEmpty // Check for an empty list
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            
            child: Expanded(
              child: GridView.builder(
                  itemCount: products.length, // Use the non-nullable list
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    final product = products[index]; // Access product directly
                    return Material(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                           
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(
                          children:[ Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    //height: 120,
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, StackTrace) {
                                        return Icon(Icons.error);
                                      },
                                    ), // Access the correct image
                                  ),
              
                                ),Divider(thickness: 1.5,height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        product.name,
                                        textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                   
                                  ],
                                ),
                              ],
                            ),
                          ),
                         Positioned(
                                     right: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 4.0),
                                        child: IconButton(
                                          iconSize: 30,
                                          onPressed: () {
                                           deleteProduct(product, index);
                                          },
                                          icon: Icon(Icons.delete),
                                        ),
                                      ),
                                    )],),
                      ),
                    );
                  },
                ),
            ),
          ),
    );
  }
}
