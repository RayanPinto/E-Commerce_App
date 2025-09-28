import 'package:flutter/material.dart';

// Development configuration - use localhost for local development
// For production, change this to your actual server IP address
// Make sure your server is running on port 6000
final String uri = 'http://10.0.2.2:6000'; // For Android emulator
// final String uri = 'http://localhost:6000'; // For iOS simulator
// final String uri = 'http://192.168.137.1:6000'; // For physical device (update IP as needed)

class GlobalVariables {
  static Color primaryColor = Colors.orange;
}
