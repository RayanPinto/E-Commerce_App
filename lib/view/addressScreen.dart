import 'package:amazon_rayan/controller/addressController.dart';
import 'package:amazon_rayan/controller/provider_controller/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String addressToBeUsed = "";

  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController addressLine1Controller = TextEditingController();

  final TextEditingController addressLine2Controller = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController districtController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController landmarkController = TextEditingController();

  final TextEditingController pincodeController = TextEditingController();

  final AddressController addressController = AddressController();

  final _categoryNotifier = ValueNotifier<String>('Karnataka');
   onOrderSuccess(res) {
                                if (Provider.of<UserProvider>(context,listen: false)
                                    .user
                                    .address
                                    .isEmpty) {
                                  addressController.saveUserAddress(
                                      context: context,
                                      address: addressToBeUsed);
                                  
                                }
                                addressController.placeOrder(
                                      context: context,
                                      address: addressToBeUsed,
                                       total: double.parse(widget.totalAmount));
                              }

  List<String> stateName = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  List<String> cityName = [
    'Ahmedabad',
    'Bengaluru',
    'Chennai',
    'Delhi',
    'Hyderabad',
    'Kolkata',
    'Mumbai',
    'Pune',
    'Jaipur',
    'Lucknow',
    'Surat',
    'Nagpur',
    'Visakhapatnam',
    'Kanpur',
    'Indore',
    'Thane',
    'Bhopal',
    'Patna',
    'Vadodara',
    'Coimbatore',
    'Kochi',
    'Chandigarh',
    'Nashik',
    'Agra',
    'Rajkot',
    'Gurgaon',
    'Noida',
    'Dehradun',
    'Mangalore',
    'Mysuru',
    'Ghaziabad',
  ];

  void payment(String addressFromProvider) {
    addressToBeUsed = "";

    bool isFromFill = addressLine1Controller.text.isNotEmpty ||
        addressLine2Controller.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        districtController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty;

    if (isFromFill) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${addressLine1Controller.text},${addressLine2Controller.text},${cityController.text},${districtController.text},${landmarkController.text},${pincodeController.text}';
      } else {
        throw Exception("Please Enter all values");
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      throw Exception(
          "You Have Made A Mistake While Filling The Form,Please Check Your Details");
    }
      onOrderSuccess("res");

  
  }

  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Payable Amount',
        status: PaymentItemStatus.final_price));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Your Address",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              address.isNotEmpty
                  ? InkWell(
                    onTap:(){
                       payment(address);
                    },
                    child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)),
                            child: Text(
                              address,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("You Already have an Saved Address above.",style: TextStyle(fontWeight: FontWeight.w400),),
                        ],
                      ),
                  )
                  : SizedBox(),
              Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: addressLine1Controller,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'Please Enter your Home Address',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: stateController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'State',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: SizedBox(
                              width: 170, // Adjust width as necessary
                              child: ValueListenableBuilder<String>(
                                valueListenable: _categoryNotifier,
                                builder: (context, selectedCategory, child) {
                                  return DropdownButton<String>(
                                    // Set the value to null so it won't show anything next to the dropdown
                                    value:
                                        null, // This ensures nothing appears next to the dropdown
                                    items: stateName.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (String? newVal) {
                                      if (newVal != null) {
                                        _categoryNotifier.value =
                                            newVal; // Update the notifier
                                        stateController.text =
                                            newVal; // Update the TextFormField
                                        // Ensure the hint text disappears
                                        stateController.selection = TextSelection
                                            .fromPosition(TextPosition(
                                                offset: newVal
                                                    .length)); // Move cursor to the end
                                      }
                                    },
                                    underline:
                                        SizedBox(), // Removes the default underline of DropdownButton
                                    isExpanded:
                                        true, // Ensures the dropdown takes full width
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: cityController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'Town/City',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: SizedBox(
                              width: 170, // Adjust width as necessary
                              child: ValueListenableBuilder<String>(
                                valueListenable: _categoryNotifier,
                                builder: (context, selectedCategory, child) {
                                  return DropdownButton<String>(
                                    // Set the value to null so it won't show anything next to the dropdown
                                    value:
                                        null, // This ensures nothing appears next to the dropdown
                                    items: cityName.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item),
                                      );
                                    }).toList(),
                                    onChanged: (String? newVal) {
                                      if (newVal != null) {
                                        _categoryNotifier.value =
                                            newVal; // Update the notifier
                                        cityController.text =
                                            newVal; // Update the TextFormField
                                        // Ensure the hint text disappears
                                        cityController.selection = TextSelection
                                            .fromPosition(TextPosition(
                                                offset: newVal
                                                    .length)); // Move cursor to the end
                                      }
                                    },
                                    underline:
                                        SizedBox(), // Removes the default underline of DropdownButton
                                    isExpanded:
                                        true, // Ensures the dropdown takes full width
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: districtController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'District',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: landmarkController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'LandMark (Optional)',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: pincodeController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is mandatory";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'Pincode',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              payment(addressToBeUsed);
                             
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2.5 -
                                          40,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Order Now'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
