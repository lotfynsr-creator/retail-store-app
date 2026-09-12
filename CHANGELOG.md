# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project structure
- Firebase authentication (login/signup)
- Product catalog with categories
- Shopping cart functionality
- User profile management
- Search functionality
- Material Design 3 theming
- Dark/Light theme support

### Changed
- N/A

### Deprecated
- N/A

### Removed
- N/A

### Fixed
- N/A

### Security
- Added .gitignore rules for sensitive Firebase credentials
- Created template files for Firebase configuration

## [1.0.0] - 2026-09-12

### Added
- **Authentication**
  - Email/password registration with validation
  - Secure login with session persistence
  - Password visibility toggle
  - Form validation with real-time feedback

- **Home Screen**
  - Promotional banner carousel
  - Category navigation chips
  - Featured products grid
  - Responsive layout

- **Product Catalog**
  - Category-based filtering (All, Electronics, Fashion, Accessories)
  - Product grid with images, names, prices
  - Pull-to-refresh support
  - Loading & error states

- **Product Details**
  - Full-screen image gallery
  - Product specifications
  - Quantity selector
  - Add to cart with confirmation

- **Shopping Cart**
  - Item quantity management
  - Price calculation (subtotal, tax, total)
  - Item removal with swipe-to-delete
  - Empty cart state
  - Checkout flow preparation

- **Search**
  - Real-time search suggestions
  - Search history
  - Filter by category
  - Empty & error states

- **User Profile**
  - User information display
  - Order history placeholder
  - Settings navigation
  - Logout functionality

- **Navigation**
  - Bottom navigation bar (Home, Products, Cart, Profile)
  - Smooth page transitions
  - Active state indicators

- **UI/UX**
  - Material Design 3 components
  - Custom color palette (deep purple seed)
  - Dark/Light theme with system preference
  - Consistent spacing & typography
  - Loading skeletons & shimmer effects
  - Snackbar notifications

- **Architecture**
  - Feature-first folder structure
  - Reusable widget library
  - Validation utilities
  - Firebase integration layer

- **Firebase Setup**
  - Firebase Core initialization
  - Firebase Auth configuration
  - Cloud Firestore ready
  - Firebase Storage ready
  - Cross-platform support (Android, Web)

### Technical Details
- Flutter 3.13+ / Dart 3.0+
- firebase_core ^4.14.0
- firebase_auth ^6.6.1
- cloud_firestore ^6.9.0
- cupertino_icons ^1.0.8

---

## Versioning Scheme

| Version | Meaning |
|---------|---------|
| MAJOR | Breaking changes, API incompatibility |
| MINOR | New features, backward compatible |
| PATCH | Bug fixes, backward compatible |

## Release Checklist

- [ ] Update `pubspec.yaml` version
- [ ] Update `CHANGELOG.md`
- [ ] Run `flutter test` & `flutter analyze`
- [ ] Create git tag: `git tag vX.Y.Z`
- [ ] Push tag: `git push origin vX.Y.Z`
- [ ] Create GitHub Release with notes