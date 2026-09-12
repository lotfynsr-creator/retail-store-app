# Retail Store App

A modern, feature-rich Flutter e-commerce application with Firebase backend integration. Built with clean architecture principles and Material Design 3.

![Flutter](https://img.shields.io/badge/Flutter-3.13%2B-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0%2B-blue?logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore-orange?logo=firebase)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-lightgrey)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Features

### 🛍️ Shopping Experience
- **Product Catalog** - Browse products with categories, search, and filtering
- **Product Details** - High-quality images, descriptions, pricing, and specifications
- **Shopping Cart** - Add/remove items, quantity management, persistent cart
- **Categories** - Organized product navigation (Electronics, Fashion, Accessories)

### 🔐 Authentication & User Management
- **Email/Password Auth** - Secure registration and login
- **Profile Management** - User profile with order history
- **Session Persistence** - Auto-login with Firebase Auth state management
- **Password Validation** - Real-time form validation

### 🎨 Modern UI/UX
- **Material Design 3** - Latest design system with dynamic theming
- **Responsive Layout** - Adapts to mobile, tablet, and desktop
- **Dark/Light Theme** - System-aware theme switching
- **Smooth Animations** - Page transitions, loading states, micro-interactions
- **Custom Components** - Reusable widgets (ProductCard, PromoBanner, NavBar)

### 🔥 Firebase Integration
- **Firebase Auth** - User authentication
- **Cloud Firestore** - Real-time database for products/orders
- **Firebase Storage** - Product image hosting
- **Cross-platform** - Android, iOS, Web support

## 📱 Screenshots

| Home Screen | Product Details | Shopping Cart |
|:-----------:|:---------------:|:-------------:|
| ![Home](docs/screenshots/home.png) | ![Details](docs/screenshots/details.png) | ![Cart](docs/screenshots/cart.png) |

| Login | Signup | Profile |
|:-----:|:------:|:-------:|
| ![Login](docs/screenshots/login.png) | ![Signup](docs/screenshots/signup.png) | ![Profile](docs/screenshots/profile.png) |

## 🏗️ Architecture

```
lib/
├── main.dart                 # App entry point, Firebase init
├── firebase_options.dart     # Firebase config (gitignored)
├── theme/
│   └── app_colors.dart       # Color palette & theming
├── resources/
│   └── app_validation.dart   # Form validation utilities
├── widgets/                  # Reusable UI components
│   ├── product_card.dart
│   └── promo_bannar.dart
├── nav_bar/
│   └── nav_bar.dart          # Bottom navigation
├── home_screen/              # Home page with featured products
├── products_screen/          # Product listing & filtering
├── search_screen/            # Search functionality
├── details_screen/           # Product detail view
├── cart_screen/              # Shopping cart management
├── login_screen/             # Authentication - login
├── signup_screen/            # Authentication - registration
└── profile_screen/           # User profile & orders
```

### Key Design Decisions
- **Feature-first organization** - Screens grouped by feature, not layer
- **Stateless where possible** - Minimal stateful widgets
- **Provider/Bloc ready** - Structure supports state management migration
- **Firebase-first backend** - Serverless architecture

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK** 3.13+ ([Install Guide](https://flutter.dev/docs/get-started/install))
- **Dart** 3.0+ (included with Flutter)
- **Android Studio** / **VS Code** with Flutter extensions
- **Firebase Account** ([Create Project](https://console.firebase.google.com/))

### Firebase Setup

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add Project" → follow setup wizard
   - Enable **Authentication** → Email/Password provider
   - Enable **Cloud Firestore** → Start in test mode
   - Enable **Storage** → Start in test mode

2. **Configure Android App**
   - Add Android app with package name: `com.example.retailstoreapp`
   - Download `google-services.json`
   - Place in `android/app/google-services.json`

3. **Configure Web App (Optional)**
   - Add Web app in Firebase Console
   - Copy config values

4. **Generate Firebase Options**
   ```bash
   # Install FlutterFire CLI
   dart pub global activate flutterfire_cli
   
   # Configure (run from project root)
   flutterfire configure --project=YOUR_PROJECT_ID
   ```
   This generates `lib/firebase_options.dart` with your credentials.

### Local Development

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/retail-store-app.git
cd retail-store-app

# Install dependencies
flutter pub get

# Verify Firebase config exists
ls android/app/google-services.json
ls lib/firebase_options.dart

# Run app
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle --release

# iOS (requires macOS)
flutter build ios --release

# Web
flutter build web --release
```

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `flutter` | SDK | UI Framework |
| `cupertino_icons` | ^1.0.8 | iOS-style icons |
| `firebase_core` | ^4.14.0 | Firebase initialization |
| `firebase_auth` | ^6.6.1 | Authentication |
| `cloud_firestore` | ^6.9.0 | Database |

**Dev Dependencies:**
- `flutter_test` - Unit/widget testing
- `flutter_lints` - Code quality rules

## 🔧 Configuration

### Environment Variables (Optional)
Create `.env` file for build-time configuration:
```env
API_BASE_URL=https://your-api.com
FEATURE_ANALYTICS=true
```

### Theme Customization
Edit `lib/theme/app_colors.dart`:
```dart
static const Color primarySeed = Colors.deepPurple;
static const Color secondarySeed = Colors.teal;
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html
```

## 📁 Project Structure Details

<details>
<summary><strong>Screens</strong></summary>

| Screen | File | Description |
|--------|------|-------------|
| Home | `home_screen/home_screen.dart` | Featured products, categories, promo banner |
| Products | `products_screen/products_screen.dart` | Grid view with category filter |
| Search | `search_screen/search_screen.dart` | Real-time search with suggestions |
| Details | `details_screen/details_screen.dart` | Image gallery, specs, add to cart |
| Cart | `cart_screen/cart_screen.dart` | Item management, checkout flow |
| Login | `login_screen/login_screen.dart` | Email/password authentication |
| Signup | `signup_screen/signup_screen.dart` | User registration with validation |
| Profile | `profile_screen/profile_screen.dart` | User info, order history, settings |
</details>

<details>
<summary><strong>Widgets</strong></summary>

| Widget | File | Reusability |
|--------|------|-------------|
| ProductCard | `widgets/product_card.dart` | Product grids, search results |
| PromoBanner | `widgets/promo_bannar.dart` | Home screen carousel |
| NavBar | `nav_bar/nav_bar.dart` | Bottom navigation (all screens) |
</details>

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) for details on:
- Code style & conventions
- Branch naming & commit messages
- Pull request process
- Issue reporting

### Quick Contribution Steps
1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'feat: add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev/) - Amazing framework
- [Firebase](https://firebase.google.com/) - Backend services
- [Material Design](https://m3.material.io/) - Design system
- Community packages & contributors

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/lotfynsr-creator)
- **Discussions**: [GitHub Discussions](https://github.com/lotfynsr-creator)
- **Email**: lotfynsrzx123uh@gmail.com
---

<p align="center">Made with ❤️ using Flutter & Firebase</p>
<p align="center">
  <a href="#top">Back to Top</a>
</p>
