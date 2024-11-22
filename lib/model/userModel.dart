import 'dart:convert';

class User {
  final String id;
  final String email;
  final String name;
  final String password;
  final String address;
   String type;
  final String token;
  List<dynamic> cart;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    required this.address,
    required this.type,
    required this.token,
    required this.cart,
  });

  Map<String, dynamic> fromAppToDB() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'address': address,
      'type': type,
      'token': token,
      'cart':cart
    };
  }

  factory User.fromDBtoApp(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      cart: map['cart']!=null?  List<Map<String,dynamic>>.from(map['cart'].map((x)=>Map<String,dynamic>.from(x))
      ):[]
    );
  }

  factory User.fromJson(String source) => User.fromDBtoApp(jsonDecode(source));



  User copyWith({
  
   String ? id,
   String ? email,
   String ? name,
   String ? password,
   String ? address,
   String ? type,
   String ? token,
  List<dynamic>? cart,
  }){
    return User(id: id??this.id, email:email ??this.email, name: name??this.name, password: password??this.password, address: address ?? this.address, type: type?? this.type, token: token??this.token, cart: cart??this.cart);
  }
}
