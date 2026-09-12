# Contributing to Retail Store App

Thank you for your interest in contributing! This document provides guidelines for contributing to this project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Style](#code-style)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

## 🤝 Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct/). By participating, you agree to uphold this code.

## 🚀 Getting Started

1. **Fork** the repository
2. **Clone** your fork locally
3. **Install dependencies**: `flutter pub get`
4. **Set up Firebase** (see README.md)
5. **Run the app**: `flutter run`

## 🔄 Development Workflow

### Branch Naming Convention

| Type | Format | Example |
|------|--------|---------|
| Feature | `feature/<short-description>` | `feature/add-wishlist` |
| Bug Fix | `fix/<short-description>` | `fix/cart-total-calculation` |
| Refactor | `refactor/<short-description>` | `refactor/product-card-widget` |
| Docs | `docs/<short-description>` | `docs/update-readme` |
| Chore | `chore/<short-description>` | `chore/update-dependencies` |

### Workflow Steps

1. Create branch from `main`
2. Make atomic, focused commits
3. Run tests: `flutter test`
4. Run linter: `flutter analyze`
5. Push to your fork
6. Open Pull Request against `main`

## 🎨 Code Style

### Dart/Flutter Conventions

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart)
- Use `flutter_lints` package (configured in `analysis_options.yaml`)
- Format with `dart format .` before committing
- Maximum line length: 100 characters

### File Organization

```
lib/
├── <feature>_screen/      # Feature-based grouping
│   └── <feature>_screen.dart
├── widgets/               # Shared reusable components
├── theme/                 # Theming & colors
├── resources/             # Utilities, constants, validation
└── nav_bar/               # Navigation components
```

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Files | snake_case | `product_card.dart` |
| Classes | PascalCase | `ProductCard` |
| Variables/Functions | camelCase | `productPrice` |
| Constants | SCREAMING_SNAKE | `MAX_CART_ITEMS` |
| Private members | _prefix | `_itemCount` |

### Widget Guidelines

- Prefer `const` constructors
- Extract reusable widgets early
- Use `StatelessWidget` when possible
- Keep `build()` methods small
- Document complex widgets with `///` comments

### State Management

Current: `setState` for local UI state
Future: Ready for Provider/Bloc migration

## 📝 Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `style` | Formatting, missing semicolons, etc. |
| `refactor` | Code restructuring |
| `perf` | Performance improvement |
| `test` | Adding tests |
| `chore` | Maintenance, dependencies |
| `ci` | CI/CD changes |

### Examples

```bash
feat(cart): add quantity selector to cart items

fix(auth): handle firebase auth exception on weak password

docs(readme): add firebase setup instructions

refactor(widgets): extract product card into separate file

chore(deps): upgrade firebase_auth to ^6.6.1
```

## 🔍 Pull Request Process

### Before Submitting

- [ ] All tests pass (`flutter test`)
- [ ] No analyzer issues (`flutter analyze`)
- [ ] Code formatted (`dart format .`)
- [ ] Commits follow convention
- [ ] Branch is up to date with `main`
- [ ] Screenshots added for UI changes

### PR Template

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Screenshots (if applicable)
| Before | After |
|--------|-------|
| ![before](url) | ![after](url) |

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] Manual testing completed

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex logic
- [ ] Documentation updated
```

### Review Process

1. Automated checks must pass
2. At least 1 maintainer approval required
3. Address all review comments
4. Squash commits if requested
5. Merge via "Squash and merge"

## 🐛 Issue Reporting

### Bug Reports

Use the bug report template:

```markdown
**Describe the Bug**
Clear description of the issue

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected Behavior**
What should happen

**Screenshots**
If applicable

**Environment**
- OS: [e.g., Android 14, iOS 17]
- Device: [e.g., Pixel 8, iPhone 15]
- Flutter Version: [e.g., 3.13.0]
- App Version: [e.g., 1.0.0]

**Additional Context**
Any other information
```

### Feature Requests

Use the feature request template:

```markdown
**Problem Statement**
What problem does this solve?

**Proposed Solution**
Describe your ideal solution

**Alternatives Considered**
Other approaches considered

**Additional Context**
Screenshots, mockups, references
```

## 🏷️ Release Process

1. Update version in `pubspec.yaml`
2. Update `CHANGELOG.md`
3. Create release tag: `git tag v1.1.0`
4. Push tag: `git push origin v1.1.0`
5. GitHub Actions builds & publishes

## 📞 Getting Help

- **Discord**: [Community Server](https://discord.gg/example)
- **Discussions**: [GitHub Discussions](https://github.com/YOUR_USERNAME/retail-store-app/discussions)
- **Email**: maintainers@example.com

---

**Thank you for contributing!** 🎉