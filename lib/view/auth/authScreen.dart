import 'package:amazon_rayan/controller/authController.dart';
import 'package:amazon_rayan/utils/errorHandler.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var signUpkey = GlobalKey<FormState>();
  var signInKey = GlobalKey<FormState>();

  void SignUpsubmit(String email, String name, String password) {
    final isValid = signUpkey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpkey.currentState!.save();
    AuthController().signUpUser(
        context: context, email: email, name: name, password: password);
  }

  void SignInsubmit() {
    final isValid = signInKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signInKey.currentState!.save();
    AuthController().signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text);
  }

  bool isLoginEnabled = false;
  bool _showPassword = false;
  bool _keepSignedIn = false;
  void _showForgotPasswordDialog() {
    final TextEditingController forgotPasswordEmailController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Forgot Password?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please Enter Your Email To Receive A New Password.',
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: forgotPasswordEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'A new password has been sent to your email.',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rayan Amazon',
          style: TextStyle(
            decoration: TextDecoration.underline,
            decorationThickness: 2.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              child: isLoginEnabled
                  ? Form(
                      key: signInKey,
                      child: Column(
                        children: [
                          Text(
                            'Sign in with your email and password',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed:  _showForgotPasswordDialog,
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(fontSize: 17),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-z0-9.a-zA-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a Valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                if (value.length < 8) {
                                  return 'Enter valid password';
                                } else {
                                  return null;
                                }
                              }
                            },
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            value: _showPassword,
                            onChanged: (value) {
                              setState(() {
                                _showPassword = value!;
                              });
                            },
                            title: Text('Show Password'),
                          ),
                          CheckboxListTile(
                            value: _keepSignedIn,
                            onChanged: (value) {
                              setState(() {
              _keepSignedIn = value!;
            });
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _keepSignedIn ? 'Keep Signed In enabled' : 'Keep Signed In disabled',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: _keepSignedIn ? Colors.green : Colors.red,
                duration: Duration(seconds: 2),
              ),
            );
                            },
                            title: Text('Keep Signed In'),
                          ),
                          InkWell(
                            onTap: () => SignInsubmit(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2.5 -
                                          40,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.orangeAccent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Sign In'),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Divider(
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text("New to Rayan's App"),
                          SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoginEnabled = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 3 -
                                          40,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Create A New Account'),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text("Rayan's Terms And Conditions"))
                        ],
                      ),
                    )
                  : Form(
                      key: signUpkey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Create Account',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter your name";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: 'Your Name',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-z0-9.a-zA-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a Valid email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: 'Email',
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              RegExp regex = RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else {
                                if (value.length < 8) {
                                  return 'Enter valid password';
                                } else {
                                  return null;
                                }
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Password must be at least 8 characters.'),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller:
                                rePasswordController, // Define this controller
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              } else if (value != passwordController.text) {
                                // Ensure it matches
                                return 'Passwords do not match';
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                hintText: 'Re-Enter Password',
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black))),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          InkWell(
                            onTap: () {
                              if (emailController.text.isNotEmpty &&
                                  nameController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty &&
                                  rePasswordController.text.isNotEmpty) {
                                SignUpsubmit(
                                    emailController.text.isNotEmpty
                                        ? emailController.text
                                        : '',
                                    nameController.text,
                                    passwordController.text);
                              } else {
                                showSnackBar(
                                    context, "Please fill in all fields");
                              }
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
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text('Already a customer?'),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLoginEnabled = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 3 -
                                          40,
                                  vertical: 10),
                              decoration: BoxDecoration(
                                  color: Colors.orange[200],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text('Sign In'),
                            ),
                          ),
                          Spacer(),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                  "Feeling Horny? You're at right place! "))
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

