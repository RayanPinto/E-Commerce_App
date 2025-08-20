# 🛒 Amazon Clone - Flutter E-Commerce App

[![Flutter](https://img.shields.io/badge/Flutter-3.5.3+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![Node.js](https://img.shields.io/badge/Node.js-14+-green.svg)](https://nodejs.org/)
[![MongoDB](https://img.shields.io/badge/MongoDB-5.0+-green.svg)](https://www.mongodb.com/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

A full-stack e-commerce application built with **Flutter** and **Node.js**, featuring a complete online shopping experience similar to Amazon. The app supports both customer and seller roles with distinct functionalities.

## ✨ Features

### 🛍️ Customer Features

- **User Authentication** - Secure login/registration with JWT
- **Product Browsing** - Browse products by categories
- **Search Functionality** - Real-time product search
- **Shopping Cart** - Add/remove products with quantity management
- **Product Ratings** - Rate and review products
- **Deal of the Day** - Featured products algorithm
- **Profile Management** - Update user information and address

### 🏪 Seller Features

- **Product Management** - Add/edit products with image upload
- **Order Management** - Track and manage customer orders
- **Earnings Dashboard** - Monitor sales and revenue
- **Delivery Tracking** - Manage product deliveries
- **Inventory Control** - Stock management

### 🔧 Technical Features

- **Cross-Platform** - Works on Android and iOS
- **Real-time Updates** - Live cart and order updates
- **Image Upload** - Cloudinary integration for product images
- **Payment Integration** - Google Pay support
- **Responsive Design** - Optimized for all screen sizes
- **Secure Authentication** - JWT with bcrypt password hashing

## 🛠️ Technology Stack

### Frontend

- **Framework**: Flutter (Dart)
- **State Management**: Provider Pattern
- **HTTP Client**: http package
- **Local Storage**: SharedPreferences
- **Image Handling**: image_picker, cloudinary_public
- **UI Components**: carousel_slider, dotted_border, flutter_rating_stars
- **Payment**: pay package (Google Pay)

### Backend

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: JWT (jsonwebtoken)
- **Password Hashing**: bcrypt
- **CORS**: Cross-origin resource sharing

## 📱 Screenshots

### Customer Interface

| Home Screen                            | Product Details                              | Shopping Cart                          | Search                                     |
| -------------------------------------- | -------------------------------------------- | -------------------------------------- | ------------------------------------------ |
| ![Home](assets/images/home_screen.png) | ![Product](assets/images/product_detail.png) | ![Cart](assets/images/cart_screen.png) | ![Search](assets/images/search_screen.png) |

### Seller Interface

| Dashboard                                        | Add Product                                   | Orders                              | Earnings                                |
| ------------------------------------------------ | --------------------------------------------- | ----------------------------------- | --------------------------------------- |
| ![Dashboard](assets/images/seller_dashboard.png) | ![Add Product](assets/images/add_product.png) | ![Orders](assets/images/orders.png) | ![Earnings](assets/images/earnings.png) |

## 🏗️ Architecture

```
┌─────────────────┐    HTTP/REST    ┌─────────────────┐    MongoDB    ┌─────────────────┐
│   Flutter App   │ ◄─────────────► │   Node.js API   │ ◄────────────► │   Database      │
│   (Frontend)    │                 │   (Backend)     │               │   (MongoDB)     │
└─────────────────┘                 └─────────────────┘               └─────────────────┘
```

## 📁 Project Structure

```
flutterproject/
├── lib/                          # Flutter source code
│   ├── constant/                 # Global constants
│   ├── controller/               # Business logic
│   ├── model/                    # Data models
│   ├── seller_view/              # Seller-specific screens
│   ├── utils/                    # Reusable widgets
│   ├── view/                     # Customer screens
│   └── main.dart                 # App entry point
├── server/                       # Node.js backend
│   ├── model/                    # Database schemas
│   ├── middlewares/              # Authentication middleware
│   ├── auth.js                   # Authentication routes
│   ├── products.js               # Product management
│   └── index.js                  # Server entry point
├── assets/                       # Images and resources
└── android/ & ios/               # Platform-specific code
```

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** (3.5.3 or higher)
- **Node.js** (14 or higher)
- **MongoDB** (local or cloud)
- **Android Studio** / **VS Code**
- **Git**

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/amazon-clone-flutter.git
   cd amazon-clone-flutter
   ```

2. **Setup Backend**

   ```bash
   # Navigate to server directory
   cd server

   # Install dependencies
   npm install

   # Start MongoDB (if local)
   mongod

   # Start the server
   npm run dev
   ```

3. **Setup Frontend**

   ```bash
   # Navigate back to root directory
   cd ..

   # Install Flutter dependencies
   flutter pub get

   # Update API endpoint (optional)
   # Edit lib/constant/global.dart with your server IP
   ```

4. **Run the Application**

   ```bash
   # For Android
   flutter run

   # For iOS
   flutter run -d ios
   ```

### Environment Configuration

Update the API endpoint in `lib/constant/global.dart`:

```dart
final String uri = 'http://YOUR_IP_ADDRESS:6000';
```

## 🔌 API Endpoints

### Authentication

- `POST /api/signup` - User registration
- `POST /api/signin` - User login
- `POST /validateToken` - Token validation

### Products

- `GET /api/products?category=...` - Get products by category
- `GET /api/products/search/:name` - Search products
- `POST /api/rate-product` - Rate a product
- `GET /api/deal-of-day` - Get deal of the day

### User Management

- `GET /api/user` - Get user profile
- `PUT /api/user` - Update user profile
- `POST /api/user/cart` - Update cart

## 🔐 Security Features

- **Password Hashing**: bcrypt with salt rounds
- **JWT Authentication**: Stateless token-based auth
- **Input Validation**: Email format and password strength
- **CORS Protection**: Cross-origin request handling
- **Middleware Security**: Route-level authentication

## 📊 Database Schema

### User Collection

```javascript
{
  name: String,
  email: String (unique),
  password: String (hashed),
  address: String,
  type: String (user/seller),
  token: String,
  cart: Array
}
```

### Product Collection

```javascript
{
  name: String,
  description: String,
  images: Array,
  quantity: Number,
  price: Number,
  category: String,
  ratings: Array
}
```

## 🧪 Testing

```bash
# Run Flutter tests
flutter test

# Run backend tests
cd server
npm test
```

## 📦 Dependencies

### Flutter Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  http: ^1.2.2
  provider: ^6.1.0
  shared_preferences: ^2.2.2
  carousel_slider: ^5.0.0
  image_picker: ^0.8.4+4
  cloudinary_public: ^0.23.1
  flutter_rating_stars: ^1.1.0
  pay: ^2.0.0
```

### Node.js Dependencies

```json
{
  "dependencies": {
    "express": "^4.21.0",
    "mongoose": "^8.7.0",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.0",
    "cors": "^2.8.5"
  }
}
```

## 🚀 Deployment

### Frontend Deployment

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Build for Web
flutter build web
```

### Backend Deployment

```bash
# Deploy to Heroku
heroku create your-app-name
git push heroku main

# Deploy to Vercel
vercel --prod
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Email: your.email@example.com

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Node.js](https://nodejs.org/) - Backend runtime
- [MongoDB](https://www.mongodb.com/) - Database
- [Cloudinary](https://cloudinary.com/) - Image storage
- [Express.js](https://expressjs.com/) - Web framework

## 📈 Project Statistics

- **Frontend Lines of Code**: ~5,000+
- **Backend Lines of Code**: ~1,500+
- **Total Files**: 50+
- **Dependencies**: 15+ packages
- **API Endpoints**: 10+
- **Features**: 20+ core features

## ⭐ Star History

[![Star History Chart](https://api.star-history.com/svg?repos=yourusername/amazon-clone-flutter&type=Date)](https://star-history.com/#yourusername/amazon-clone-flutter&Date)

---

<div align="center">

**If you find this project helpful, please give it a ⭐ star!**

Made with ❤️ by [Your Name](https://github.com/yourusername)

</div>
