import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:amazon_rayan/model/order.dart';
import 'package:amazon_rayan/model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetails({super.key, required this.order});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    // Get the User object from the UserProvider
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle('View Order Details'),
              _buildOrderSummary(widget.order),
              const SizedBox(height: 10),
              _buildTitle('Purchase Details'),
              _buildProductDetails(widget.order),
              const SizedBox(height: 10),
              _buildTitle('Tracking'),
              _buildStepper(user),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 150, 243, 1.0),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Image.asset(
              "assets/images/logo3-removebg.png",
              width: 175,
              height: 190,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, size: 30),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildOrderSummary(Order order) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Date: ${_formatDate(order.orderedAt)}'),
          Text('Order ID: ${order.id}'),
          Text('Order Total: ${order.total}'),
        ],
      ),
    );
  }

  String _formatDate(int timestamp) {
    return DateFormat.yMMMd().format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  Widget _buildProductDetails(Order order) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      child: Column(
        children: order.products.asMap().entries.map((entry) {
          int i = entry.key;
          var product = entry.value;
          return Row(
            children: [
              Image.network(
                product.images[0],
                height: 120,
                width: 120,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('Qty: ${order.quantity[i]}'),
                  ],
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStepper(User user) {
    return Stepper(
      controlsBuilder: (context, details) {
        if (user.type == 'user') {
          return TextButton(
            onPressed: () {
              setState(() {
                if (currentStep <= 3) {
                  currentStep += 1;
                }

                // Show SnackBar and pop when currentStep reaches 4 (after all steps are completed)
                if (currentStep > 3) {
                  // Show SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Thank you for buying! Please rate the product.',),backgroundColor: Colors.green,
                      duration: Duration(seconds: 3),
                    ),
                  );

                  // Delay pop after showing SnackBar
                  Future.delayed(Duration(seconds: 0), () {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  });
                }
              });
            },
            child: const Text('Done'),
          );
        }
        return const SizedBox();
      },
      currentStep: currentStep,
      steps: [
        _buildStep('Pending', 'Your order is being processed', 0),
        _buildStep('Order Confirmed', 'Your order has been confirmed', 1),
        _buildStep('Dispatched', 'Your order has been dispatched', 2),
        _buildStep(
            'Delivered', 'Your order has been delivered successfully', 3),
      ],
    );
  }

  Step _buildStep(String title, String content, int stepIndex) {
    return Step(
      title: Text(title),
      content: Text(content),
      isActive: currentStep > stepIndex,
      state: currentStep > stepIndex ? StepState.complete : StepState.indexed,
    );
  }
}
